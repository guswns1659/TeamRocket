package com.codesquad.rocket.web.dto.response.account;

import java.text.DateFormat;
import java.text.SimpleDateFormat;

import com.codesquad.rocket.domain.account.PointHistory;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@Builder
public class PointHistoryDto {

    private String createdAt;
    private String projectName;
    private Integer ecoPoint;
    private String pointOption;

    public static PointHistoryDto of(PointHistory pointHistory) {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        return PointHistoryDto.builder()
            .createdAt(dateFormat.format(pointHistory.getCreatedAt()))
            .ecoPoint(pointHistory.getEcoPoint())
            .pointOption(pointHistory.getPointOption().getOption())
            .projectName(pointHistory.getProjectName())
            .build();
    }
}
