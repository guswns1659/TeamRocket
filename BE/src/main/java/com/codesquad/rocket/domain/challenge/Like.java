package com.codesquad.rocket.domain.challenge;

import javax.persistence.Column;
import javax.persistence.Embeddable;

import com.codesquad.rocket.domain.account.Account;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Embeddable
@Getter
@NoArgsConstructor
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@Builder
public class Like {

    private String name;

    public static Like of(Account account) {
        return Like.builder()
            .name(account.getName())
            .build();
    }

    public boolean hasAccount(Account account) {
        return this.name.equals(account.getName());
    }
}
