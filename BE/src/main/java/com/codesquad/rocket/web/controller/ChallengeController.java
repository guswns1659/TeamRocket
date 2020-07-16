package com.codesquad.rocket.web.controller;

import java.io.IOException;

import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.codesquad.rocket.service.ChallengeService;
import com.codesquad.rocket.web.dto.response.challenge.ChallengeDetailResponseDto;
import com.codesquad.rocket.web.dto.response.challenge.ChallengeResponseDto;
import com.codesquad.rocket.web.dto.response.challenge.ChallengeStatusResponseDto;
import com.codesquad.rocket.web.dto.response.challenge.LikeResponseDto;
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

    @GetMapping("all")
    public ChallengeResponseDto findByAll() {
        return challengeService.findByAll();
    }

    @GetMapping("{id}")
    public ChallengeDetailResponseDto findById(@PathVariable Long id) {
        return challengeService.findById(id);
    }

    @GetMapping("/like/{id}")
    public LikeResponseDto getLikeResult(@PathVariable Long id,
        @RequestParam(value = "liked") String liked) {
        return challengeService.getLikeResult(id, liked);
    }

    @PostMapping(path = "{restaurantId}",consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ChallengeStatusResponseDto upload(
        @PathVariable Long restaurantId,
        @RequestPart(value = "picture") MultipartFile file,
        @RequestParam(value = "description") String description) throws IOException {

        return challengeService.addChallenge(restaurantId, file, description);
    }
}
