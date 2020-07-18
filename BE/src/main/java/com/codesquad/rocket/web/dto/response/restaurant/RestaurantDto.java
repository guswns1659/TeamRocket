package com.codesquad.rocket.web.dto.response.restaurant;

import java.util.List;
import java.util.stream.Collectors;

import com.codesquad.rocket.domain.restaurant.Image;
import com.codesquad.rocket.domain.restaurant.Restaurant;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@Builder
public class RestaurantDto {

    private Long id;
    private String name;
    private String description;
    private String address;
    private Double rating;
    private Double latitude;
    private Double longitude;
    private List<String> images;

    public static RestaurantDto of(Restaurant restaurant) {
        List<String> images = restaurant.getImages().stream()
            .map(Image::getUrl)
            .collect(Collectors.toList());
        images = images.stream()
            .map(image -> image.replaceAll("\r", ""))
            .collect(Collectors.toList());

        return RestaurantDto.builder()
            .id(restaurant.getId())
            .address(restaurant.getAddress())
            .description(restaurant.getDescription())
            .latitude(restaurant.getPoint().getY())
            .longitude(restaurant.getPoint().getX())
            .name(restaurant.getName())
            .rating(restaurant.getRating())
            .images(images)
            .build();
    }
}
