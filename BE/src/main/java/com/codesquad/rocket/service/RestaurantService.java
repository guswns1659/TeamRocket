package com.codesquad.rocket.service;

import java.util.List;
import java.util.stream.Collectors;

import javax.persistence.EntityManager;
import javax.persistence.Query;

import org.springframework.stereotype.Service;

import com.codesquad.rocket.domain.restaurant.Restaurant;
import com.codesquad.rocket.domain.restaurant.RestaurantRepository;
import com.codesquad.rocket.utils.CardinalDirection;
import com.codesquad.rocket.utils.GeometryUtils;
import com.codesquad.rocket.utils.Location;
import com.codesquad.rocket.web.dto.response.restaurant.NearRestaurantResponseDtos;
import com.codesquad.rocket.web.dto.response.restaurant.RestaurantDto;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class RestaurantService {

    private final RestaurantRepository restaurantRepository;
    private final EntityManager entityManager;

    public NearRestaurantResponseDtos nearRestaurant(Double latitude, Double longitude) {

        double distance = 0.3;

        // 북동쪽 좌표 구하기
        Location northEast = GeometryUtils.calculateByDirection(latitude, longitude, distance, CardinalDirection.NORTHEAST
            .getBearing());
        Location southWest = GeometryUtils.calculateByDirection(latitude, longitude, distance, CardinalDirection.SOUTHWEST
            .getBearing());

        double x1 = northEast.getLongitude();
        double y1 = northEast.getLatitude();
        double x2 = southWest.getLongitude();
        double y2 = southWest.getLatitude();

        // native query 활용
        Query query = entityManager.createNativeQuery("" +
                "SELECT r.id, r.address, r.description, r.name, r.point, r.rating \n" +
                "FROM restaurant AS r \n" +
                "WHERE MBRContains(ST_LINESTRINGFROMTEXT(" + String.format("'LINESTRING(%f %f, %f %f)')", x1, y1, x2, y2) + ", r.point)"
            , Restaurant.class);

        // query.setParameter(1, baseLongitude);
        // query.setParameter(2, baseLatitude);
        // query.setParameter(3, distance * 1000);

        List<Restaurant> results = query.getResultList();
        List<RestaurantDto> data = results.stream()
            .map(RestaurantDto::of)
            .collect(Collectors.toList());

        return NearRestaurantResponseDtos.builder()
            .dataCount(data.size())
            .data(data)
            .build();
    }
}
