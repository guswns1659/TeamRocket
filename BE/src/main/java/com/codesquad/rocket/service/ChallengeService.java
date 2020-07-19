package com.codesquad.rocket.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.codesquad.rocket.domain.account.Account;
import com.codesquad.rocket.domain.account.AccountRepository;
import com.codesquad.rocket.domain.account.PointHistory;
import com.codesquad.rocket.domain.account.PointOption;
import com.codesquad.rocket.domain.challenge.Challenge;
import com.codesquad.rocket.domain.challenge.ChallengeRepository;
import com.codesquad.rocket.domain.challenge.Like;
import com.codesquad.rocket.domain.restaurant.Restaurant;
import com.codesquad.rocket.domain.restaurant.RestaurantRepository;
import com.codesquad.rocket.utils.GeometryUtils;
import com.codesquad.rocket.utils.S3Uploader;
import com.codesquad.rocket.web.dto.response.challenge.ChallengeDetailResponseDto;
import com.codesquad.rocket.web.dto.response.challenge.ChallengeResponseDto;
import com.codesquad.rocket.web.dto.response.challenge.ChallengeStatusResponseDto;
import com.codesquad.rocket.web.dto.response.challenge.LikeResponseDto;
import com.codesquad.rocket.web.dto.response.challenge.WeeklyTopLikeResponseDto;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ChallengeService {

    private static final String NULL = "null";
    private static final String DIRECTORYNAME = "static";
    private static final String DELMA = "delma";
    private static final Integer NO_RESTAURANT_ECOPOINT = 200;
    private static final Integer RESTAURANT_ECOPOINT = 400;
    private static final String STATUS_OK = "200";
    private static final String STATUS_FAIL = "400";
    private final AccountRepository accountRepository;
    private final ChallengeRepository challengeRepository;
    private final RestaurantRepository restaurantRepository;
    private final S3Uploader s3Uploader;
    private final static String TRUE = "True";

    public WeeklyTopLikeResponseDto weeklyTopLike() {
        List<Challenge> challenges = challengeRepository.findAll();
        challenges.sort((o1, o2) -> o2.getLikes().size() - o1.getLikes().size());
        challenges = challenges.subList(0, 7);
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

    public ChallengeDetailResponseDto findById(Long id) {
        Challenge challenge = challengeRepository.findById(id).orElse(new Challenge());
        Account account = accountRepository.findAccountByName(DELMA).orElse(new Account());
        boolean isLiked = hasAccountInLikes(account, challenge);
        if (isLiked) {
            return ChallengeDetailResponseDto.likedOf(challenge);
        }
        return ChallengeDetailResponseDto.unLikedOf(challenge);
    }

    public LikeResponseDto getLikeResult(Long id, String liked) {
        final String OK = "200";
        final String FAIL = "400";
        Account account = accountRepository.findAccountByName(DELMA).orElse(new Account());
        Challenge challenge = challengeRepository.findById(id).orElse(new Challenge());

        if (likedIsTrue(liked)) {
            try {
                challenge.addLike(Like.of(account));
                challengeRepository.save(challenge);

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
            challengeRepository.save(challenge);

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

    public ChallengeStatusResponseDto addChallenge(Long restaurantId, MultipartFile multipartFile, String description) {
        try {
            Restaurant restaurant = restaurantRepository.findById(restaurantId).orElse(new Restaurant());
            Account account = accountRepository.findAccountByName(DELMA).orElse(new Account());
            String uploadUrl = s3Uploader.upload(multipartFile, DIRECTORYNAME);

            Challenge challenge = Challenge.builder()
                .account(account)
                .createdAt(new Date())
                .description(description)
                .point(restaurant.getPoint())
                .restaurantName(restaurant.getName())
                .updatedAt(new Date())
                .url(uploadUrl)
                .build();

            challengeRepository.save(challenge);
            PointHistory pointHistory = PointHistory.builder()
                .pointOption(PointOption.SAVE)
                .createdAt(new Date())
                .ecoPoint(RESTAURANT_ECOPOINT)
                .build();

            account.addPointHistory(pointHistory);
            account.addPlate();
            account.giveEcoPoint(RESTAURANT_ECOPOINT);
            accountRepository.save(account);

            return ChallengeStatusResponseDto.builder()
                .status(STATUS_OK)
                .build();
        } catch (Exception e) {
            return ChallengeStatusResponseDto.builder()
                .status(STATUS_FAIL)
                .build();
        }
    }


    public ChallengeStatusResponseDto addChallenge(MultipartFile multipartFile, String description) {
        try {
            // Restaurant restaurant = restaurantRepository.findById(restaurantId).orElse(new Restaurant());
            Account account = accountRepository.findAccountByName(DELMA).orElse(new Account());
            String uploadUrl = s3Uploader.upload(multipartFile, DIRECTORYNAME);

            Challenge challenge = Challenge.builder()
                .account(account)
                .createdAt(new Date())
                .description(description)
                .updatedAt(new Date())
                .url(uploadUrl)
                .restaurantName(NULL)
                .point(GeometryUtils.getEmptyPoint())
                .build();

            challengeRepository.save(challenge);
            PointHistory pointHistory = PointHistory.builder()
                .pointOption(PointOption.SAVE)
                .createdAt(new Date())
                .ecoPoint(NO_RESTAURANT_ECOPOINT)
                .build();

            account.addPointHistory(pointHistory);
            account.addPlate();
            account.giveEcoPoint(NO_RESTAURANT_ECOPOINT);
            accountRepository.save(account);

            return ChallengeStatusResponseDto.builder()
                .status(STATUS_OK)
                .build();
        } catch (Exception e) {
            return ChallengeStatusResponseDto.builder()
                .status(STATUS_FAIL)
                .build();
        }
    }
}
