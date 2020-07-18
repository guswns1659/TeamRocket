package com.codesquad.rocket.service;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.codesquad.rocket.domain.account.Account;
import com.codesquad.rocket.domain.account.AccountRepository;
import com.codesquad.rocket.web.dto.response.account.AccountResponseDto;
import com.codesquad.rocket.web.dto.response.account.EcoPointResponseDto;
import com.codesquad.rocket.web.dto.response.account.PointHistoryDto;
import com.codesquad.rocket.web.dto.response.account.PointHistoryResponseDto;
import com.codesquad.rocket.web.dto.response.account.TodaySavingResponseDto;
import com.codesquad.rocket.web.dto.response.account.TotalSavingResponseDto;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AccountService {

    private final AccountRepository accountRepository;
    private final static double SAVING_UNIT_PER_PLATE = 0.15;
    private final static String USER = "delma";

    public TotalSavingResponseDto totalSaving() {
        Account account  = accountRepository.findAccountByName(USER).orElse(new Account());

        return TotalSavingResponseDto.builder()
            .accountName(account.getName())
            .totalPlates(account.getTotalPlate())
            .totalSaving(account.getTotalPlate() * SAVING_UNIT_PER_PLATE)
            .build();
    }

    public TodaySavingResponseDto todaySaving() {
        int todayTotalPlate = accountRepository.sumTodayPlate();
        Account account = accountRepository.findAccountByName(USER).orElse(new Account());

        return TodaySavingResponseDto.builder()
            .todayTotalPlates(todayTotalPlate)
            .todayTotalSaving(todayTotalPlate * SAVING_UNIT_PER_PLATE)
            .todayMyPlates(account.getTodayPlate())
            .todayMySaving(account.getTodayPlate() * SAVING_UNIT_PER_PLATE)
            .build();
    }

    public EcoPointResponseDto ecoPointOfAccount() {
        Account account  = accountRepository.findAccountByName(USER).orElse(new Account());

        return EcoPointResponseDto.builder()
            .ecoPoint(account.getEcoPoint())
            .build();
    }

    public PointHistoryResponseDto pointHistory() {
        Account account = accountRepository.findAccountByName(USER).orElse(new Account());
        account.getPointHistories().sort(Comparator.comparingInt(a -> (int)a.getCreatedAt().getTime()));
        Collections.reverse(account.getPointHistories());

        List<PointHistoryDto> data = account.getPointHistories().stream()
            .map(PointHistoryDto::of)
            .collect(Collectors.toList());

        return PointHistoryResponseDto.builder()
            .data(data)
            .build();
    }

    public AccountResponseDto findById(Long accountId) {
        Account account = accountRepository.findById(accountId).orElse(new Account());
        return AccountResponseDto.of(account);
    }
}
