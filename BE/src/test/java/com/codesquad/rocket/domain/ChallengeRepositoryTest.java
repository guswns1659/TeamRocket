package com.codesquad.rocket.domain;

import static org.assertj.core.api.Assertions.*;

import java.util.Date;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.codesquad.rocket.domain.account.Account;
import com.codesquad.rocket.domain.challenge.Challenge;
import com.codesquad.rocket.domain.challenge.Like;
import com.codesquad.rocket.domain.challenge.ChallengeRepository;

@SpringBootTest
public class ChallengeRepositoryTest {

    @Autowired
    private ChallengeRepository challengeRepository;

    @DisplayName("챌린지를 저장하는 테스트")
    @CsvSource({"1, 1, 1, 이름, description, restaurantName, www.naver.com"})
    @ParameterizedTest
    void 챌린지와_라이크를_저장한다(Integer todayPlate, Integer totalPlate, Integer ecoPoint, String name,
        String description, String restaurantName, String url) {

        Account account = Account.builder()
            .todayPlate(todayPlate)
            .totalPlate(totalPlate)
            .ecoPoint(ecoPoint)
            .name(name)
            .build();

        Challenge challenge = Challenge.builder()
            .account(account)
            .createdAt(new Date())
            .updatedAt(new Date())
            .description(description)
            .restaurantName(restaurantName)
            .url(url)
            .build();

        Like like = Like.builder()
            .name(name)
            .build();

        challenge.addLike(like);
        Challenge savedChallenge = challengeRepository.save(challenge);

        assertThat(savedChallenge.getRestaurantName()).isEqualTo(restaurantName);
    }
}
