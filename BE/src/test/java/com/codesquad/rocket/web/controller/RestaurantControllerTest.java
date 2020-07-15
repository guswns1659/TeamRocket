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

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
@AutoConfigureWebTestClient(timeout = "30000")
public class RestaurantControllerTest {

    @Autowired
    private WebTestClient webTestClient;

    @LocalServerPort
    private int port;

    @DisplayName("nKm 이내의 식당을 구하는 테스트")
    @CsvSource({"33.24859, 126.56480, 6"})
    @ParameterizedTest
    void nKM_이내_식당을_요청한다(Double latitude, Double longitude, Integer size) {

        String url = "http://localhost:" + port + "/restaurant/nearRestaurant?" +
            "latitude=" + latitude + "&" + "longitude=" + longitude;

        NearRestaurantResponseDtos nearRestaurantResponseDtos = webTestClient.get()
            .uri(url)
            .exchange()
            .expectStatus().isEqualTo(HttpStatus.OK)
            .expectBody(NearRestaurantResponseDtos.class)
            .returnResult()
            .getResponseBody();

        assertThat(nearRestaurantResponseDtos.getData().size()).isEqualTo(size);
    }
}
