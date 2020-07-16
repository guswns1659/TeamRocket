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

import com.codesquad.rocket.web.dto.response.challenge.ChallengeDetailResponseDto;
import com.codesquad.rocket.web.dto.response.challenge.ChallengeResponseDto;
import com.codesquad.rocket.web.dto.response.challenge.LikeResponseDto;
import com.codesquad.rocket.web.dto.response.challenge.WeeklyTopLikeResponseDto;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
@AutoConfigureWebTestClient(timeout = "30000")
public class ChallengeControllerTest {

    @Autowired
    private WebTestClient webTestClient;

    @LocalServerPort
    private int port;

    @Transactional
    @DisplayName("weeklyTopLike API 테스트")
    @CsvSource({"2, https://s3-angelhack.s3.ap-northeast-2.amazonaws.com/static/empty_image4.jpg%20new"})
    @ParameterizedTest
    void weeklyTopLike를_응답한다(Integer likeCount, String challengeUrl) {

        String url = "http://localhost:" + port + "/challenge/weeklyTopLike";

        WeeklyTopLikeResponseDto weeklyTopLikeResponseDto = webTestClient.get()
            .uri(url)
            .exchange()
            .expectStatus().isEqualTo(HttpStatus.OK)
            .expectBody(WeeklyTopLikeResponseDto.class)
            .returnResult()
            .getResponseBody();

        assertThat(weeklyTopLikeResponseDto.getData().get(0).getLikeCount()).isEqualTo(likeCount);
    }

    @Transactional
    @DisplayName("challenge/all API 테스트")
    @CsvSource({"4"})
    @ParameterizedTest
    void 전체_챌린지를_응답한다(Integer size) {

        String url = "http://localhost:" + port + "/challenge/all";

        ChallengeResponseDto challengeResponseDto = webTestClient.get()
            .uri(url)
            .exchange()
            .expectStatus().isEqualTo(HttpStatus.OK)
            .expectBody(ChallengeResponseDto.class)
            .returnResult()
            .getResponseBody();

        assertThat(challengeResponseDto.getData().size()).isEqualTo(size);
    }

    @Transactional
    @DisplayName("challenge/{id} API 테스트")
    @CsvSource({"1"})
    @ParameterizedTest
    void 챌린지_상세페이지를_응답한다(Long id) {

        String url = "http://localhost:" + port + "/challenge/" + id;

        ChallengeDetailResponseDto challengeDetailResponseDto = webTestClient.get()
            .uri(url)
            .exchange()
            .expectStatus().isEqualTo(HttpStatus.OK)
            .expectBody(ChallengeDetailResponseDto.class)
            .returnResult()
            .getResponseBody();

        assertThat(challengeDetailResponseDto.getId()).isEqualTo(id);
    }

    @Transactional
    @DisplayName("challenge/{id}?liked= API 테스트")
    @CsvSource({"1, True, 200"})
    @ParameterizedTest
    void 좋아요의_결과를_응답한다(Long id, String result, String status) {

        String url = "http://localhost:" + port + "/challenge/like/" + id + "?liked=" + result;

        LikeResponseDto likeResponseDto = webTestClient.get()
            .uri(url)
            .exchange()
            .expectStatus().isEqualTo(HttpStatus.OK)
            .expectBody(LikeResponseDto.class)
            .returnResult()
            .getResponseBody();

        assertThat(likeResponseDto.getStatus()).isEqualTo(status);
    }
}
