package com.codesquad.rocket.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.codesquad.rocket.domain.account.Account;
import com.codesquad.rocket.domain.account.AccountRepository;
import com.codesquad.rocket.domain.account.Challenge;
import com.codesquad.rocket.web.dto.response.challenge.WeeklyTopLikeResponseDto;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ChallengeService {

    private final AccountRepository accountRepository;

    public WeeklyTopLikeResponseDto weeklyTopLike() {
        List<Account> accounts = accountRepository.findAll();
        List<Challenge> challenges = new ArrayList<>();
        accounts.forEach(account -> challenges.addAll(account.getChallenges()));
        challenges.sort((o1, o2) -> o2.getLikeCount() - o1.getLikeCount());

        return WeeklyTopLikeResponseDto.builder()
            .data(challenges)
            .build();
    }
}
