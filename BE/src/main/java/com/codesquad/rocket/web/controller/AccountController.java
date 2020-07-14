package com.codesquad.rocket.web.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.codesquad.rocket.web.dto.response.account.TodaySavingResponseDto;
import com.codesquad.rocket.web.dto.response.account.TotalSavingResponseDto;
import com.codesquad.rocket.service.AccountService;
import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
@RequestMapping("/account")
public class AccountController {

    private final AccountService accountService;

    @GetMapping("totalSaving")
    public TotalSavingResponseDto totalSaving() {
        return accountService.totalSaving();
    }

    @GetMapping("todaySaving")
    public TodaySavingResponseDto todaySaving() {
        return accountService.todaySaving();
    }
}
