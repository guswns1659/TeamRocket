package com.codesquad.rocket.web.dto.response.restaurant;

import java.util.List;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@Builder
public class NearRestaurantResponseDtos {

    private Integer dataCount;
    private List<RestaurantDto> data;
}
