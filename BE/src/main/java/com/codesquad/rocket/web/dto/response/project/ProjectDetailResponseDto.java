package com.codesquad.rocket.web.dto.response.project;

import com.codesquad.rocket.domain.project.Project;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@Builder
public class ProjectDetailResponseDto {

    private final static long DAY = 24 * 60 * 60 * 1000;
    private final static long HOUR = 60 * 60 * 1000;
    private final static String postfix = "와(과) 함께 하는";

    private Long id;
    private String titleWithCompany;
    private String title;
    private Integer currentMoney;
    private Integer targetMoney;
    private Long leftDay;
    private Long leftHour;
    private Integer donators;
    private String descriptionURL;

    public static ProjectDetailResponseDto of(Project project) {
        return ProjectDetailResponseDto.builder()
            .id(project.getId())
            .title(project.getName())
            .currentMoney(project.getCurrentMoney())
            .descriptionURL("www.naver.com")
            .donators(project.getDonators())
            .targetMoney(project.getTargetMoney())
            .titleWithCompany(project.getCorporation().getName() + postfix)
            .leftDay(project.calculateLeftDays(DAY))
            .leftHour(project.calculateLeftHours(HOUR) - (project.calculateLeftDays(DAY) * 24))
            .build();
    }
}
