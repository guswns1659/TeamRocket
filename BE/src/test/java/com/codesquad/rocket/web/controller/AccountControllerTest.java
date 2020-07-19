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

import com.codesquad.rocket.web.dto.response.account.AccountResponseDto;
import com.codesquad.rocket.web.dto.response.account.EcoPointResponseDto;
import com.codesquad.rocket.web.dto.response.account.PointHistoryResponseDto;
import com.codesquad.rocket.web.dto.response.account.TodaySavingResponseDto;
import com.codesquad.rocket.web.dto.response.account.TotalSavingResponseDto;
import com.codesquad.rocket.web.dto.response.project.ProjectDetailResponseDto;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
@AutoConfigureWebTestClient(timeout = "30000")
public class AccountControllerTest {

    @Autowired
    private WebTestClient webTestClient;

    @LocalServerPort
    private int port;

    @DisplayName("totalSaving api 테스트")
    @CsvSource({"1.5"})
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
    @CsvSource({"18, 1"})
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

    @DisplayName("ecoPoint api 테스트")
    @CsvSource({"500"})
    @ParameterizedTest
    void 사용자의_ecoPoint를_응답한다(Integer ecoPoint) {

        String url = "http://localhost:" + port + "/account/ecoPoint";

        EcoPointResponseDto ecoPointResponseDto = webTestClient.get()
            .uri(url)
            .exchange()
            .expectStatus().isEqualTo(HttpStatus.OK)
            .expectBody(EcoPointResponseDto.class)
            .returnResult()
            .getResponseBody();

        assertThat(ecoPointResponseDto.getEcoPoint()).isEqualTo(ecoPoint);
    }

    @DisplayName("donate api 테스트")
    @CsvSource({"1, 600, 9600"})
    @ParameterizedTest
    void 사용자의_포인트로_기부하면_추가된_프로젝트_응답한다(Long projectId, Integer ecoPoint, Integer currentMoney) {

        String url = "http://localhost:" + port + "/project/donate/" + projectId + "?ecoPoint=" + ecoPoint;

        ProjectDetailResponseDto projectDetailResponseDto = webTestClient.get()
            .uri(url)
            .exchange()
            .expectStatus().isEqualTo(HttpStatus.OK)
            .expectBody(ProjectDetailResponseDto.class)
            .returnResult()
            .getResponseBody();

        assertThat(projectDetailResponseDto.getCurrentMoney()).isEqualTo(currentMoney);
    }

    @DisplayName("포인트 히스토리 api 테스트")
    @CsvSource({"2020-07-19, 600, 기부, 북극곰 살리기 프로젝트"})
    @ParameterizedTest
    void 포인트_히스토리를_응답한다(String createdAt, Integer ecoPoint, String pointOption, String projectName) {

        String url = "http://localhost:" + port + "/account/pointHistory";

        PointHistoryResponseDto pointHistoryResponseDto = webTestClient.get()
            .uri(url)
            .exchange()
            .expectStatus().isEqualTo(HttpStatus.OK)
            .expectBody(PointHistoryResponseDto.class)
            .returnResult()
            .getResponseBody();

        assertThat(pointHistoryResponseDto.getData().get(0).getCreatedAt()).isEqualTo(createdAt);
        assertThat(pointHistoryResponseDto.getData().get(0).getEcoPoint()).isEqualTo(ecoPoint);
        assertThat(pointHistoryResponseDto.getData().get(0).getPointOption()).isEqualTo(pointOption);
    }

    @DisplayName("사용자 한명 요청하는 api 테스트")
    @CsvSource({"1, delma, 500, https://s3-angelhack.s3.ap-northeast-2.amazonaws.com/static/delma.png"})
    @ParameterizedTest
    void 사용자_한명을_응답한다(Long accountId, String accountName, Integer ecoPoint, String profileUrl) {

        String url = "http://localhost:" + port + "/account/" + accountId;

        AccountResponseDto accountResponseDto = webTestClient.get()
            .uri(url)
            .exchange()
            .expectStatus().isEqualTo(HttpStatus.OK)
            .expectBody(AccountResponseDto.class)
            .returnResult()
            .getResponseBody();

        assertThat(accountResponseDto.getId()).isEqualTo(accountId);
        assertThat(accountResponseDto.getName()).isEqualTo(accountName);
        assertThat(accountResponseDto.getEcoPoint()).isEqualTo(ecoPoint);
        assertThat(accountResponseDto.getProfileUrl()).isEqualTo(profileUrl);
    }
}
