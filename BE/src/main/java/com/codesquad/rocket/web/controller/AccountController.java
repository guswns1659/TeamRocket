package com.codesquad.rocket.web.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.codesquad.rocket.service.AccountService;
import com.codesquad.rocket.web.dto.response.account.AccountResponseDto;
import com.codesquad.rocket.web.dto.response.account.EcoPointResponseDto;
import com.codesquad.rocket.web.dto.response.account.PointHistoryResponseDto;
import com.codesquad.rocket.web.dto.response.account.TodaySavingResponseDto;
import com.codesquad.rocket.web.dto.response.account.TotalSavingResponseDto;
import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
@RequestMapping("/account")
public class AccountController {

    private final AccountService accountService;

    @GetMapping("{accountId}")
    public AccountResponseDto findById(@PathVariable Long accountId) {
        return accountService.findById(accountId);
    }

    @GetMapping("totalSaving")
    public TotalSavingResponseDto totalSaving() {
        return accountService.totalSaving();
    }

    @GetMapping("todaySaving")
    public TodaySavingResponseDto todaySaving() {
        return accountService.todaySaving();
    }

    @GetMapping("ecoPoint")
    public EcoPointResponseDto ecoPointOfAccount() {
        return accountService.ecoPointOfAccount();
    }

    @GetMapping("pointHistory")
    public PointHistoryResponseDto pointHistory() {
        return accountService.pointHistory();
    }
}
