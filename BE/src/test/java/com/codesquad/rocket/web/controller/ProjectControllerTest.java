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
import org.springframework.transaction.annotation.Transactional;

import com.codesquad.rocket.web.dto.response.ProjectByCreatedAtResponseDtos;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
@AutoConfigureWebTestClient(timeout = "30000")
public class ProjectControllerTest {

    @Autowired
    private WebTestClient webTestClient;

    @LocalServerPort
    private int port;

    @Transactional
    @DisplayName("orderByCreatedAt API 테스트")
    @CsvSource({"9999, 해양 포유류 보호법 후원 프로젝트, 3"})
    @ParameterizedTest
    void 최근생성순으로_프로젝트를_요청한다(Integer currentMoney, String projectTitle, Long leftDays) {

        String url = "http://localhost:" + port + "/project/orderByCreatedAt";

        ProjectByCreatedAtResponseDtos projectByCreatedAtResponseDtos = webTestClient.get()
            .uri(url)
            .exchange()
            .expectStatus().isEqualTo(HttpStatus.OK)
            .expectBody(ProjectByCreatedAtResponseDtos.class)
            .returnResult()
            .getResponseBody();

        assertThat(projectByCreatedAtResponseDtos.getData().get(0).getCurrentMoney()).isEqualTo(currentMoney);
        assertThat(projectByCreatedAtResponseDtos.getData().get(0).getProjectTitle()).isEqualTo(projectTitle);
        assertThat(projectByCreatedAtResponseDtos.getData().get(0).getLeftDays()).isEqualTo(leftDays);
    }
}
