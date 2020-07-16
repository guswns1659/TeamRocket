package com.codesquad.rocket.domain.account;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.CollectionTable;
import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;

import com.codesquad.rocket.domain.challenge.Challenge;
import com.codesquad.rocket.domain.project.ProjectAccount;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Getter
@NoArgsConstructor
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@Builder
public class Account {

    @Id
    @GeneratedValue
    private Long id;

    private String name;

    private Integer totalPlate;

    private Integer todayPlate;

    private Integer ecoPoint;

    @OneToMany(mappedBy = "account")
    private final Set<ProjectAccount> projectAccounts = new HashSet<>();

    @OneToMany(mappedBy = "account", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    private final Set<Challenge> challenges = new HashSet<>();

    @ElementCollection
    @CollectionTable(name = "account_point_history", joinColumns = @JoinColumn(name = "account_id"))
    private final Set<PointHistory> pointHistories = new HashSet<>();

    public void addChallenge(Challenge challenge) {
        this.getChallenges().add(challenge);
    }

    public void addPointHistory(PointHistory pointHistory) {
        this.getPointHistories().add(pointHistory);
    }

    public void subtractEcoPoint(Integer ecoPoint) {
        this.ecoPoint -= ecoPoint;
    }
}