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

import com.codesquad.rocket.web.dto.response.account.TodaySavingResponseDto;
import com.codesquad.rocket.web.dto.response.account.TotalSavingResponseDto;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
@AutoConfigureWebTestClient(timeout = "30000")
public class AccountControllerTest {

    @Autowired
    private WebTestClient webTestClient;

    @LocalServerPort
    private int port;

    @DisplayName("totalSaving api 테스트")
    @CsvSource({"6"})
    @ParameterizedTest
    void totalSaving를_응답한다(Double totalSaving) {

        String url = "http://localhost:" + port + "/account/totalSaving";

        TotalSavingResponseDto totalSavingResponseDto = webTestClient.get()
            .uri(url)
            .exchange()
            .expectStatus().isEqualTo(HttpStatus.OK)
            .expectBody(TotalSavingResponseDto.class)
            .returnResult()
            .getResponseBody();

        assertThat(totalSavingResponseDto.getTotalSaving()).isEqualTo(totalSaving);
    }

    @DisplayName("todaySaving api 테스트")
    @CsvSource({"6, 1"})
    @ParameterizedTest
    void todaySaving을_응답한다(Integer todayTotalPlates, Integer todayMyPlates) {

        String url = "http://localhost:" + port + "/account/todaySaving";

        TodaySavingResponseDto todaySavingResponseDto = webTestClient.get()
            .uri(url)
            .exchange()
            .expectStatus().isEqualTo(HttpStatus.OK)
            .expectBody(TodaySavingResponseDto.class)
            .returnResult()
            .getResponseBody();

        assertThat(todaySavingResponseDto.getTodayTotalPlates()).isEqualTo(todayTotalPlates);
        assertThat(todaySavingResponseDto.getTodayMyPlates()).isEqualTo(todayMyPlates);
    }
}
