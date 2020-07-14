package com.codesquad.rocket.web.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.codesquad.rocket.service.ChallengeService;
import com.codesquad.rocket.web.dto.response.challenge.WeeklyTopLikeResponseDto;
import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
@RequestMapping("/challenge")
public class ChallengeController {

    private final ChallengeService challengeService;

    @GetMapping("/weeklyTopLike")
    public WeeklyTopLikeResponseDto weeklyTopLike() {
        return challengeService.weeklyTopLike();
    }
}
