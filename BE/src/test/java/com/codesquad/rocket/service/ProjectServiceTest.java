package com.codesquad.rocket.service;

import static org.assertj.core.api.Assertions.*;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import com.codesquad.rocket.web.dto.response.project.ProjectDetailResponseDto;
import com.codesquad.rocket.web.dto.response.project.ProjectOrderByResponseDtos;

@SpringBootTest
public class ProjectServiceTest {

    @Autowired
    private ProjectService projectService;

    @Transactional
    @DisplayName("orderByCreatedAt API 테스트")
    @CsvSource({"5, 9600, 해양 포유류 보호법 후원 프로젝트, 6"})
    @ParameterizedTest
    void orderByCreatedAt을_요청한다(Integer size, Integer currentMoney, String projectTitle, Long leftDays) {
        ProjectOrderByResponseDtos projectOrderByResponseDtos = projectService.orderByCreatedAt();

        assertThat(projectOrderByResponseDtos.getData().size()).isEqualTo(size);
    }

    @Transactional
    @DisplayName("orderByDeadLine API 테스트")
    @CsvSource({"3, 9000, 해양 포유류 보호법 후원 프로젝트, 6"})
    @ParameterizedTest
    void orderByDeadLine을_요청한다(Integer size, Integer currentMoney, String projectTitle, Long leftDays) {
        ProjectOrderByResponseDtos projectOrderByResponseDtos = projectService.orderByDeadLine();

        assertThat(projectOrderByResponseDtos.getData().size()).isEqualTo(size);
    }

    @Transactional
    @DisplayName("orderByCreatedAt API 테스트")
    @CsvSource({"1, 9000, 해양 포유류 보호법 후원 프로젝트, 6, 4"})
    @ParameterizedTest
    void 프로젝트_상세보기를_요청한다(Long projectId, Integer currentMoney, String title, Long leftDay, Long leftHour) {

        ProjectDetailResponseDto projectDetailResponseDto = projectService.projectDetail(projectId);

        assertThat(projectDetailResponseDto.getId()).isEqualTo(projectId);
    }
}
