package com.codesquad.rocket.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.codesquad.rocket.domain.account.Account;
import com.codesquad.rocket.domain.account.AccountRepository;
import com.codesquad.rocket.domain.challenge.Challenge;
import com.codesquad.rocket.domain.challenge.ChallengeRepository;
import com.codesquad.rocket.domain.challenge.Like;
import com.codesquad.rocket.web.dto.response.challenge.ChallengeDetailResponseDto;
import com.codesquad.rocket.web.dto.response.challenge.ChallengeResponseDto;
import com.codesquad.rocket.web.dto.response.challenge.LikeResponseDto;
import com.codesquad.rocket.web.dto.response.challenge.WeeklyTopLikeResponseDto;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ChallengeService {

    private final AccountRepository accountRepository;
    private final ChallengeRepository challengeRepository;
    private final static String TRUE = "True";

    public WeeklyTopLikeResponseDto weeklyTopLike() {
        List<Challenge> challenges = challengeRepository.findAll();
        challenges.sort((o1, o2) -> o2.getLikes().size() - o1.getLikes().size());
        challenges.subList(0, 4);
        List<ChallengeDetailResponseDto> data = challengeHasLikeWithAccount(challenges);

        return WeeklyTopLikeResponseDto.builder()
            .data(data)
            .build();
    }

    public ChallengeResponseDto findByAll() {
        List<Challenge> challenges = challengeRepository.findAll();
        List<ChallengeDetailResponseDto> data = challengeHasLikeWithAccount(challenges);

        return ChallengeResponseDto.builder()
            .data(data)
            .build();
    }

    public ChallengeDetailResponseDto findById(Long id) {
        Challenge challenge = challengeRepository.findById(id).orElse(new Challenge());
        String userName = "delma";
        Account account = accountRepository.findAccountByName(userName).orElse(new Account());
        boolean isLiked = hasAccountInLikes(account, challenge);
        if (isLiked) {
            return ChallengeDetailResponseDto.likedOf(challenge);
        }
        return ChallengeDetailResponseDto.unLikedOf(challenge);
    }

    public LikeResponseDto getLikeResult(Long id, String liked) {
        final String OK = "200";
        final String FAIL = "400";
        String userName = "delma";
        Account account = accountRepository.findAccountByName(userName).orElse(new Account());
        Challenge challenge = challengeRepository.findById(id).orElse(new Challenge());

        if (likedIsTrue(liked)) {
            try {
                challenge.addLike(Like.of(account));
                return LikeResponseDto.builder()
                    .status(OK)
                    .build();
            } catch (Exception e) {
                return LikeResponseDto.builder()
                    .status(FAIL)
                    .build();
            }
        }

        try {
            challenge.removeLike(account);
            return LikeResponseDto.builder()
                .status(OK)
                .build();
        } catch (Exception e) {
            return LikeResponseDto.builder()
                .status(FAIL)
                .build();
        }
    }

    private boolean likedIsTrue(String liked) {
        return liked.equals(TRUE);
    }

    private List<ChallengeDetailResponseDto> challengeHasLikeWithAccount(List<Challenge> challenges) {
        String userName = "delma";
        Account account = accountRepository.findAccountByName(userName).orElse(new Account());
        List<ChallengeDetailResponseDto> data = new ArrayList<>();

        for (Challenge challenge : challenges) {
            boolean isLiked = hasAccountInLikes(account, challenge);
            if (isLiked) {
                data.add(ChallengeDetailResponseDto.likedOf(challenge));
            } else {
                data.add(ChallengeDetailResponseDto.unLikedOf(challenge));
            }
        }
        return data;
    }

    private boolean hasAccountInLikes(Account account, Challenge challenge) {
        return challenge.getLikes().stream()
            .anyMatch(like -> like.getName().equals(account.getName()));
    }
}
