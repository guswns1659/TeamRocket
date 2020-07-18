package com.codesquad.rocket.web.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.codesquad.rocket.service.RestaurantService;
import com.codesquad.rocket.web.dto.response.restaurant.NearRestaurantResponseDtos;
import com.codesquad.rocket.web.dto.response.restaurant.RestaurantDto;
import io.swagger.annotations.ApiOperation;
import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
@RequestMapping("restaurant")
public class RestaurantController {

    private final RestaurantService restaurantService;

    @ApiOperation(value = "300M 이내 식당 요청",
        notes = "기준 좌표 300M 이내 식당 리스트 요청, 고정 latitude = 33.24859, longitude = 126.5648")
    @GetMapping("nearRestaurant")
    public NearRestaurantResponseDtos nearRestaurant(
        @RequestParam(value = "latitude") Double latitude,
        @RequestParam(value = "longitude") Double longitude) {
        return restaurantService.nearRestaurant(latitude, longitude);
    }

    @GetMapping("{restaurantId}")
    public RestaurantDto findById(@PathVariable Long restaurantId){
        return restaurantService.findById(restaurantId);
    }
}
