package com.codesquad.rocket.web.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.codesquad.rocket.service.RestaurantService;
import com.codesquad.rocket.web.dto.response.restaurant.NearRestaurantResponseDtos;
import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
@RequestMapping("restaurant")
public class RestaurantController {

    private final RestaurantService restaurantService;

    @GetMapping("nearRestaurant")
    public NearRestaurantResponseDtos nearRestaurant(@RequestParam(required = false, value = "latitude") Double latitude,
        @RequestParam(required = false, value = "longitude") Double longitude) {
        return restaurantService.nearRestaurant(latitude, longitude);
    }
}
