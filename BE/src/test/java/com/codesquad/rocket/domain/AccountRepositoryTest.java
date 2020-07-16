package com.codesquad.rocket.domain;

import static org.assertj.core.api.Assertions.*;

import java.util.Date;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;
import org.locationtech.jts.geom.Point;
import org.locationtech.jts.io.ParseException;
import org.locationtech.jts.io.WKTReader;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.reactive.AutoConfigureWebTestClient;
import org.springframework.boot.test.context.SpringBootTest;

import com.codesquad.rocket.domain.account.Account;
import com.codesquad.rocket.domain.account.AccountRepository;
import com.codesquad.rocket.domain.challenge.Challenge;
import com.codesquad.rocket.domain.account.PointHistory;
import com.codesquad.rocket.domain.account.PointOption;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
@AutoConfigureWebTestClient(timeout = "30000")
public class AccountRepositoryTest {

    @Autowired
    private AccountRepository accountRepository;

    @DisplayName("사용자와 위치정보를 가진 피드를 저장하는 테스트")
    @CsvSource({"accountName, 3, 10, 4, 2, restaurantName, projectName"})
    @ParameterizedTest
    void 유저와_피드를_저장한다(String accountName, Integer totalCount, Integer todayCount, Integer ecoPoint, Integer likeCount,
        String restaurantName, String projectName) throws ParseException {
        Account account = Account.builder()
            .name(accountName)
            .totalPlate(totalCount)
            .todayPlate(todayCount)
            .ecoPoint(ecoPoint)
            .build();

        Double latitude = 32.123;
        Double longitude = 127.123;
        String pointWKT = String.format("POINT(%s %s)", longitude, latitude);
        Point point = (Point) new WKTReader().read(pointWKT);

        Challenge challenge = Challenge.builder()
            .point(point)
            .restaurantName(restaurantName)
            .createdAt(new Date())
            .updatedAt(new Date())
            .build();

        PointHistory pointHistory = PointHistory.builder()
            .ecoPoint(ecoPoint)
            .projectName(projectName)
            .createdAt(new Date())
            .pointOption(PointOption.SAVE)
            .build();

        account.addPointHistory(pointHistory);
        account.addChallenge(challenge);
        accountRepository.save(account);

        assertThat(account.getChallenges().iterator().next().getPoint().getX()).isEqualTo(longitude);
        assertThat(account.getChallenges().iterator().next().getRestaurantName()).isEqualTo(restaurantName);
        assertThat(account.getPointHistories().iterator().next().getEcoPoint()).isEqualTo(ecoPoint);
        assertThat(account.getPointHistories().iterator().next().getPointOption().getOption()).isEqualTo(PointOption.SAVE.getOption());
    }
}
