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

import com.codesquad.rocket.web.dto.response.project.ProjectOrderByResponseDtos;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
@AutoConfigureWebTestClient(timeout = "30000")
public class ProjectControllerTest {

    @Autowired
    private WebTestClient webTestClient;

    @LocalServerPort
    private int port;

    @Transactional
    @DisplayName("orderByCreatedAt API 테스트")
    @CsvSource({"1, 9999, 해양 포유류 보호법 후원 프로젝트, 6"})
    @ParameterizedTest
    void 최근생성순으로_프로젝트를_요청한다(Long id, Integer currentMoney, String projectTitle, Long leftDays) {

        String url = "http://localhost:" + port + "/project/orderByCreatedAt";

        ProjectOrderByResponseDtos projectOrderByResponseDtos = webTestClient.get()
            .uri(url)
            .exchange()
            .expectStatus().isEqualTo(HttpStatus.OK)
            .expectBody(ProjectOrderByResponseDtos.class)
            .returnResult()
            .getResponseBody();

        assertThat(projectOrderByResponseDtos.getData().get(0).getId()).isEqualTo(id);
        assertThat(projectOrderByResponseDtos.getData().get(0).getCurrentMoney()).isEqualTo(currentMoney);
        assertThat(projectOrderByResponseDtos.getData().get(0).getProjectTitle()).isEqualTo(projectTitle);
        assertThat(projectOrderByResponseDtos.getData().get(0).getLeftDays()).isEqualTo(leftDays);
    }

    @Transactional
    @DisplayName("orderByCreatedAt API 테스트")
    @CsvSource({"1, 9999, 해양 포유류 보호법 후원 프로젝트, 6"})
    @ParameterizedTest
    void 마감순으로_프로젝트를_요청한다(Long id, Integer currentMoney, String projectTitle, Long leftDays) {

        String url = "http://localhost:" + port + "/project/orderByDeadLine";

        ProjectOrderByResponseDtos projectOrderByResponseDtos = webTestClient.get()
            .uri(url)
            .exchange()
            .expectStatus().isEqualTo(HttpStatus.OK)
            .expectBody(ProjectOrderByResponseDtos.class)
            .returnResult()
            .getResponseBody();

        assertThat(projectOrderByResponseDtos.getData().get(0).getId()).isEqualTo(id);
        assertThat(projectOrderByResponseDtos.getData().get(0).getCurrentMoney()).isEqualTo(currentMoney);
        assertThat(projectOrderByResponseDtos.getData().get(0).getProjectTitle()).isEqualTo(projectTitle);
        assertThat(projectOrderByResponseDtos.getData().get(0).getLeftDays()).isEqualTo(leftDays);
    }
}
