package com.codesquad.rocket.web.dto.response.challenge;

import java.util.List;

import com.codesquad.rocket.domain.account.Challenge;
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
public class WeeklyTopLikeResponseDto {

    private List<Challenge> data;
}
