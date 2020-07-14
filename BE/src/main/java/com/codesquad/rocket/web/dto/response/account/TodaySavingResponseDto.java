package com.codesquad.rocket.web.dto.response.account;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Getter
@ToString
@NoArgsConstructor
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@Builder
public class TodaySavingResponseDto {

    private Integer todayTotalPlates;
    private Double todayTotalSaving;
    private Integer todayMyPlates;
    private Double todayMySaving;
}
