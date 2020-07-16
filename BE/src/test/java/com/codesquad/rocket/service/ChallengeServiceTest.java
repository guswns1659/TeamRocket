package com.codesquad.rocket.service;

import static org.assertj.core.api.Assertions.*;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.codesquad.rocket.web.dto.response.challenge.WeeklyTopLikeResponseDto;

@SpringBootTest
public class ChallengeServiceTest {

    @Autowired
    private ChallengeService challengeService;

    private final Logger logger = LoggerFactory.getLogger(ChallengeServiceTest.class);

    @DisplayName("weeklyTopLike 요청 테스트")
    @CsvSource({"4, 2"})
    @ParameterizedTest
    void weeklyTopLike를_요청한다(Integer size, Integer likeCount) {

        WeeklyTopLikeResponseDto weeklyTopLikeResponseDto = challengeService.weeklyTopLike();
        assertThat(weeklyTopLikeResponseDto.getData().size()).isEqualTo(size);
        assertThat(weeklyTopLikeResponseDto.getData().get(0).getLikeCount()).isEqualTo(likeCount);
        logger.info("weeklyTopLike : {}", weeklyTopLikeResponseDto);
    }
}
