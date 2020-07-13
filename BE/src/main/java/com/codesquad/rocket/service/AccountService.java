package com.codesquad.rocket.service;

import org.springframework.stereotype.Service;

import com.codesquad.rocket.domain.account.AccountRepository;
import com.codesquad.rocket.web.dto.response.TotalSavingResponseDto;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AccountService {

    private final AccountRepository accountRepository;

    public TotalSavingResponseDto totalSaving() {
        int totalCount = accountRepository.sumTotalSaving();

        return TotalSavingResponseDto.builder()
            .totalSaving(totalCount)
            .build();
    }
}
