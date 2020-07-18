package com.codesquad.rocket.web.controller;

import static org.assertj.core.api.Assertions.*;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.reactive.AutoConfigureWebTestClient;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.web.server.LocalServerPort;
import org.springframework.http.HttpStatus;
import org.springframework.test.web.reactive.server.WebTestClient;

import com.codesquad.rocket.web.dto.response.restaurant.NearRestaurantResponseDtos;
import com.codesquad.rocket.web.dto.response.restaurant.RestaurantDto;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
@AutoConfigureWebTestClient(timeout = "30000")
public class RestaurantControllerTest {

    @Autowired
    private WebTestClient webTestClient;

    @LocalServerPort
    private int port;

    @DisplayName("nKm 이내의 식당을 구하는 테스트")
    @CsvSource({"33.24859, 126.56480, 62"})
    @ParameterizedTest
    void nKM_이내_식당을_요청한다(Double latitude, Double longitude, Integer size) {

        String url = "http://15.164.255.212/api/restaurant/nearRestaurant?latitude="+latitude+"&"+"longitude="+longitude;

        NearRestaurantResponseDtos nearRestaurantResponseDtos = webTestClient.get()
            .uri(url)
            .exchange()
            .expectStatus().isEqualTo(HttpStatus.OK)
            .expectBody(NearRestaurantResponseDtos.class)
            .returnResult()
            .getResponseBody();

        assertThat(nearRestaurantResponseDtos.getData().size()).isEqualTo(size);
    }

    @DisplayName("레스토랑 하나를 가져오는 테스트")
    @CsvSource({"1, 제주식당"})
    @ParameterizedTest
    void 식당을_하나를_요청한다(Long restaurantId, String restaurantName) {

        String url = "http://localhost:" + port + "/restaurant/" + restaurantId;

        RestaurantDto restaurantDto = webTestClient.get()
            .uri(url)
            .exchange()
            .expectStatus().isEqualTo(HttpStatus.OK)
            .expectBody(RestaurantDto.class)
            .returnResult()
            .getResponseBody();

        assertThat(restaurantDto.getId()).isEqualTo(restaurantId);
        assertThat(restaurantDto.getName()).isEqualTo(restaurantName);
    }

    }
