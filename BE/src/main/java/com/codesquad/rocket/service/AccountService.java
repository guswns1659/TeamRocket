package com.codesquad.rocket.service;

import org.springframework.stereotype.Service;

import com.codesquad.rocket.domain.account.Account;
import com.codesquad.rocket.domain.account.AccountRepository;
import com.codesquad.rocket.web.dto.response.account.EcoPointResponseDto;
import com.codesquad.rocket.web.dto.response.account.TodaySavingResponseDto;
import com.codesquad.rocket.web.dto.response.account.TotalSavingResponseDto;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AccountService {

    private final AccountRepository accountRepository;
    private final static double SAVING_UNIT_PER_PLATE = 0.15;

    public TotalSavingResponseDto totalSaving() {
        String user = "delma";
        Account account  = accountRepository.findAccountByName(user).orElse(new Account());

        return TotalSavingResponseDto.builder()
            .totalPlates(account.getTotalPlate())
            .totalSaving(account.getTotalPlate() * SAVING_UNIT_PER_PLATE)
            .build();
    }

    public TodaySavingResponseDto todaySaving() {
        int todayTotalPlate = accountRepository.sumTodayPlate();
        Account delma = accountRepository.findAccountByName("delma").orElse(new Account());

        return TodaySavingResponseDto.builder()
            .todayTotalPlates(todayTotalPlate)
            .todayTotalSaving(todayTotalPlate * SAVING_UNIT_PER_PLATE)
            .todayMyPlates(delma.getTodayPlate())
            .todayMySaving(delma.getTodayPlate() * SAVING_UNIT_PER_PLATE)
            .build();
    }

    public EcoPointResponseDto ecoPointOfAccount() {
        String user = "delma";
        Account account  = accountRepository.findAccountByName(user).orElse(new Account());

        return EcoPointResponseDto.builder()
            .ecoPoint(account.getEcoPoint())
            .build();
    }
}
