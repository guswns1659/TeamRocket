package com.codesquad.rocket.service;

import static org.assertj.core.api.Assertions.*;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.codesquad.rocket.web.dto.response.ProjectByCreatedAtResponseDtos;

@SpringBootTest
public class ProjectServiceTest {

    @Autowired
    private ProjectService projectService;

    @DisplayName("orderByCreatedAt API 테스트")
    @CsvSource({"5, 9999, 해양 포유류 보호법 후원 프로젝트, 3"})
    @ParameterizedTest
    void orderByCreatedAt을_요청한다(Integer size, Integer currentMoney, String projectTitle, Long leftDays) {
        ProjectByCreatedAtResponseDtos projectByCreatedAtResponseDtos = projectService.orderByCreatedAt();

        assertThat(projectByCreatedAtResponseDtos.getData().size()).isEqualTo(size);
        assertThat(projectByCreatedAtResponseDtos.getData().get(0).getCurrentMoney()).isEqualTo(currentMoney);
        assertThat(projectByCreatedAtResponseDtos.getData().get(0).getProjectTitle()).isEqualTo(projectTitle);
        assertThat(projectByCreatedAtResponseDtos.getData().get(0).getLeftDays()).isEqualTo(leftDays);
    }
}
