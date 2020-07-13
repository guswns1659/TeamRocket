package com.codesquad.rocket.service;

import static org.assertj.core.api.Assertions.*;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.codesquad.rocket.web.dto.response.TotalSavingResponseDto;

@SpringBootTest
public class AccountServiceTest {

    @Autowired
    private AccountService accountService;

    @DisplayName("totalSaving을 가져오는 테스트")
    @CsvSource({"90"})
    @ParameterizedTest
    void totalSaving을_가져온다(Integer totalSaving) {
        TotalSavingResponseDto totalSavingResponseDto = accountService.totalSaving();
        assertThat(totalSavingResponseDto.getTotalSaving()).isEqualTo(totalSaving);
    }
}
