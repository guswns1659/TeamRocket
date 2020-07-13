package com.codesquad.rocket.web.controller;

import static org.assertj.core.api.Assertions.*;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.reactive.AutoConfigureWebTestClient;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.web.server.LocalServerPort;
import org.springframework.http.HttpStatus;
import org.springframework.test.web.reactive.server.WebTestClient;

import com.codesquad.rocket.web.dto.response.TotalSavingResponseDto;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
@AutoConfigureWebTestClient(timeout = "30000")
public class AccountControllerTest {

    @Autowired
    private WebTestClient webTestClient;

    @LocalServerPort
    private int port;

    @DisplayName("totalSaving api 테스트")
    @CsvSource({"10"})
    @ParameterizedTest
    void totalSaving를_응답한다(Integer totalSaving) {

        String url = "http://localhost:" + port + "/account/totalSaving";

        TotalSavingResponseDto totalSavingResponseDto = webTestClient.get()
            .exchange()
            .expectStatus().isEqualTo(HttpStatus.OK)
            .expectBody(TotalSavingResponseDto.class)
            .returnResult()
            .getResponseBody();

        assertThat(totalSavingResponseDto.getTotalSaving()).isEqualTo(totalSaving);
    }
}
