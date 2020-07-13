package com.codesquad.rocket.domain;

import static org.assertj.core.api.Assertions.*;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.codesquad.rocket.domain.application.Application;
import com.codesquad.rocket.domain.application.ApplicationRepository;
import com.codesquad.rocket.domain.application.Information;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
public class ApplicationRepositoryTest {

    @Autowired
    private ApplicationRepository applicationRepository;

    @DisplayName("애플리케이션 저장 테스트")
    @CsvSource({"information url"})
    @ParameterizedTest
    void 애플리케이션을_하나_저장한다(String informationURL) {

        Application application = new Application();

        Information information = Information.builder()
            .information(informationURL)
            .build();

        application.addInformation(information);

        applicationRepository.save(application);

        assertThat(application.getInformations().iterator().next().getInformation()).isEqualTo(informationURL);
    }
}
