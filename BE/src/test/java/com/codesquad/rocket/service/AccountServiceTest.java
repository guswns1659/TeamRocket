package com.codesquad.rocket.service;

import static org.assertj.core.api.Assertions.*;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.codesquad.rocket.web.dto.response.account.EcoPointResponseDto;
import com.codesquad.rocket.web.dto.response.account.TodaySavingResponseDto;
import com.codesquad.rocket.web.dto.response.account.TotalSavingResponseDto;

@SpringBootTest
public class AccountServiceTest {

    @Autowired
    private AccountService accountService;

    @DisplayName("totalSaving을 가져오는 테스트")
    @CsvSource({"1.5, 10"})
    @ParameterizedTest
    void totalSaving을_가져온다(Double totalSaving, Integer totalPlates) {
        TotalSavingResponseDto totalSavingResponseDto = accountService.totalSaving();
        assertThat(totalSavingResponseDto.getTotalSaving()).isEqualTo(totalSaving);
        assertThat(totalSavingResponseDto.getTotalPlates()).isEqualTo(totalPlates);
    }

    @DisplayName("todaySaving을 가져오는 테스트")
    @CsvSource({"18, 1"})
    @ParameterizedTest
    void todaySaving을_요청한다(Integer todayTotalPlates, Integer todayMyPlates) {
        TodaySavingResponseDto todaySavingResponseDto = accountService.todaySaving();
        assertThat(todaySavingResponseDto.getTodayTotalPlates()).isEqualTo(todayTotalPlates);
        assertThat(todaySavingResponseDto.getTodayMyPlates()).isEqualTo(todayMyPlates);
    }

    @DisplayName("ecoPoint api 테스트")
    @CsvSource({"500"})
    @ParameterizedTest
    void 사용자의_ecoPoint를_응답한다(Integer ecoPoint) {
    }
}

