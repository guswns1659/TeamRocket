package com.codesquad.rocket.web.dto.response.account;

import com.codesquad.rocket.domain.account.Account;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@Builder
public class AccountResponseDto {

    private Long id;
    private String name;
    private Integer ecoPoint;
    private String profileUrl;

    public static AccountResponseDto of(Account account) {
        return AccountResponseDto.builder()
            .id(account.getId())
            .name(account.getName())
            .ecoPoint(account.getEcoPoint())
            .profileUrl(account.getProfileUrl())
            .build();
    }
}
