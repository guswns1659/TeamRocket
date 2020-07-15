package com.codesquad.rocket.web.dto.response.project;

import java.util.ArrayList;
import java.util.List;

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
    private String mainURL;
    private List<String> descriptionURL;

    public static ProjectDetailResponseDto of(Project project) {
        List<String> urls = new ArrayList<>();
        urls.add(project.getImages().get(0).getUrl());
        urls.add(project.getImages().get(0).getUrl());
        urls.add(project.getImages().get(0).getUrl());

        return ProjectDetailResponseDto.builder()
            .id(project.getId())
            .title(project.getName())
            .currentMoney(project.getCurrentMoney())
            .mainURL(project.getImages().get(0).getUrl())
            .descriptionURL(urls)
            .donators(project.getDonators())
            .targetMoney(project.getTargetMoney())
            .titleWithCompany(project.getCorporation().getName() + postfix)
            .leftDay(project.calculateLeftDays(DAY))
            .leftHour(project.calculateLeftHours(HOUR) - (project.calculateLeftDays(DAY) * 24))
            .build();
    }
}
