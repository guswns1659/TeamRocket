package com.codesquad.rocket.domain.account;

import lombok.Getter;

@Getter
public enum PointOption {

    SAVE("적립"), DONATE("기부");

    public String option;

    PointOption(String option) {
        this.option = option;
    }
}