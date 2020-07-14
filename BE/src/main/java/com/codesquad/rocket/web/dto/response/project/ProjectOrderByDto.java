package com.codesquad.rocket.web.dto.response.project;

import java.util.Date;

import com.codesquad.rocket.domain.project.Project;
import com.codesquad.rocket.domain.restaurant.Image;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@Builder
public class ProjectOrderByDto {

    private final static long DAY = 24 * 60 * 60 * 1000;

    private Long id;
    private Long leftDays;
    private Integer currentMoney;
    private String titleWithCompany;
    private String projectTitle;
    private Image image;

    public static ProjectOrderByDto of (Project project) {
        return ProjectOrderByDto.builder()
            .id(project.getId())
            .leftDays((project.getDeadLine().getTime() - new Date().getTime()) / DAY)
            .currentMoney(project.getCurrentMoney())
            .projectTitle(project.getName())
            .image(project.getImages().iterator().next())
            .titleWithCompany(project.getCorporation().getName()+"와 함께하는")
            .build();
    }
}
