package com.codesquad.rocket.web.dto.response.project;

import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

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
    private final static String postfix = "와(과) 함께하는";

    private Long id;
    private Long leftDays;
    private Integer targetMoney;
    private Integer currentMoney;
    private String titleWithCompany;
    private String projectTitle;
    private Integer donators;
    private List<String> images;

    public static ProjectOrderByDto of (Project project) {
        List<String> images = project.getImages().stream()
            .map(Image::getUrl).collect(Collectors.toList());

        return ProjectOrderByDto.builder()
            .id(project.getId())
            .leftDays((project.getDeadLine().getTime() - new Date().getTime()) / DAY)
            .currentMoney(project.getCurrentMoney())
            .projectTitle(project.getName())
            .images(images)
            .titleWithCompany(project.getCorporation().getName() + postfix)
            .targetMoney(project.getTargetMoney())
            .donators(project.getDonators())
            .build();
    }
}
