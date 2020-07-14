package com.codesquad.rocket.service;

import org.springframework.stereotype.Service;

import com.codesquad.rocket.domain.account.AccountRepository;
import com.codesquad.rocket.web.dto.response.TotalSavingResponseDto;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AccountService {

    private final AccountRepository accountRepository;
    private final static double SAVING_UNIT_PER_PLATE = 0.15;

    public TotalSavingResponseDto totalSaving() {
        double totalSaving = accountRepository.sumTotalSaving() * SAVING_UNIT_PER_PLATE;

        return TotalSavingResponseDto.builder()
            .totalSaving(totalSaving)
            .build();
    }
}
