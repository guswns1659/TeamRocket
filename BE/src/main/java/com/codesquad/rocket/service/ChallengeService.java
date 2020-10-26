package com.codesquad.rocket.service;

import com.codesquad.rocket.domain.account.Account;
import com.codesquad.rocket.domain.account.AccountRepository;
import com.codesquad.rocket.domain.account.PointHistory;
import com.codesquad.rocket.domain.challenge.Challenge;
import com.codesquad.rocket.domain.challenge.ChallengeRepository;
import com.codesquad.rocket.domain.challenge.Like;
import com.codesquad.rocket.domain.restaurant.Restaurant;
import com.codesquad.rocket.domain.restaurant.RestaurantRepository;
import com.codesquad.rocket.utils.S3Uploader;
import com.codesquad.rocket.web.dto.response.challenge.*;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ChallengeService {

    private final AccountRepository accountRepository;
    private final ChallengeRepository challengeRepository;
    private final RestaurantRepository restaurantRepository;
    private final S3Uploader s3Uploader;
    private static final String DIRECTORYNAME = "static";
    private static final String DELMA = "delma";

    public WeeklyTopLikeResponseDto weeklyTopLike() {
        List<Challenge> challenges = challengeRepository.findAll();
        challenges.sort((o1, o2) -> o2.getLikes().size() - o1.getLikes().size());
        challenges = challenges.subList(0, 7);
        // 좋아요가 눌린 상태인지 아닌지 구분하는 로직
        List<ChallengeDetailResponseDto> data = challengeHasLikeWithAccount(challenges);

        return WeeklyTopLikeResponseDto.builder()
                .data(data)
                .build();
    }

    public ChallengeResponseDto findByAll() {
        List<Challenge> challenges = challengeRepository.findAllByOrderByCreatedAtDesc();
        List<ChallengeDetailResponseDto> data = challengeHasLikeWithAccount(challenges);

        return ChallengeResponseDto.builder()
                .data(data)
                .build();
    }


    public LikeResponseDto getLikeResult(Long id, String liked) {
        Account account = accountRepository.findAccountByName(DELMA).orElse(new Account());
        Challenge challenge = challengeRepository.findById(id).orElse(new Challenge());

        // 눌렀으면 챌린지에 사용자의 좋아요 추가
        if (likedIsTrue(liked)) {
            challenge.addLike(Like.of(account));
            challengeRepository.save(challenge);
            return LikeResponseDto.builder()
                    .status(String.valueOf(HttpStatus.OK.value()))
                    .build();
        }

        // 취소했으면 챌린지에 사용자의 좋아요 취소
        challenge.removeLike(account);
        challengeRepository.save(challenge);
        return LikeResponseDto.builder()
                .status(String.valueOf(HttpStatus.OK.value()))
                .build();
    }

    public ChallengeDetailResponseDto findById(Long id) {
        Challenge challenge = challengeRepository.findById(id).orElse(new Challenge());
        Account account = accountRepository.findAccountByName(DELMA).orElse(new Account());
        boolean isLiked = hasAccountInLikes(account, challenge);
        if (isLiked) {
            return ChallengeDetailResponseDto.likedOf(challenge);
        }
        return ChallengeDetailResponseDto.unLikedOf(challenge);
    }

    private boolean likedIsTrue(String liked) {
        final String TRUE = "True";
        return liked.equals(TRUE);
    }

    /**
     * 챌린지 추가
     */
    public ChallengeStatusResponseDto addChallenge(Long restaurantId, MultipartFile multipartFile, String description) throws IOException {
        final Integer RESTAURANT_ECOPOINT = 400;
        Restaurant restaurant = restaurantRepository.findById(restaurantId).orElse(new Restaurant());
        Account account = accountRepository.findAccountByName(DELMA).orElse(new Account());
        String uploadUrl = s3Uploader.upload(multipartFile, DIRECTORYNAME);

        Challenge challenge = Challenge.from(account, restaurant, uploadUrl, description);

        challengeRepository.save(challenge);
        
        PointHistory pointHistory = PointHistory.from(RESTAURANT_ECOPOINT);
        account.addPointHistory(pointHistory);
        account.addPlate();
        account.giveEcoPoint(RESTAURANT_ECOPOINT);
        accountRepository.save(account);

        return ChallengeStatusResponseDto.builder()
                .status(String.valueOf(HttpStatus.OK))
                .build();
    }

    /**
     * 좋아요를 누른 사용자면 눌린 표시가 되고
     * 누르지 않았다면 안 눌린 표시가 필요
     */
    private List<ChallengeDetailResponseDto> challengeHasLikeWithAccount(List<Challenge> challenges) {
        Account account = accountRepository.findAccountByName(DELMA).orElse(new Account());
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
