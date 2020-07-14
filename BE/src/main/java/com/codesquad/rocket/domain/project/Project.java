package com.codesquad.rocket.domain.project;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.CascadeType;
import javax.persistence.CollectionTable;
import javax.persistence.Column;
import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.codesquad.rocket.domain.account.Account;
import com.codesquad.rocket.domain.corporation.Corporation;
import com.codesquad.rocket.domain.restaurant.Image;
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
public class Project {

    @Id
    @GeneratedValue
    private Long id;

    private String name;

    private Date deadLine;

    @Temporal(TemporalType.DATE)
    private Date createdAt;

    private String description;

    private Integer targetMoney;

    private Integer currentMoney;

    private Integer donators;

    @ElementCollection(fetch = FetchType.EAGER)
    @CollectionTable(name = "project_image", joinColumns = @JoinColumn(name = "project_id"))
    @AttributeOverrides({
        @AttributeOverride(name = "url", column = @Column(name = "project_image"))
    })
    private final Set<Image> images = new HashSet<>();

    @ManyToOne(cascade = CascadeType.ALL)
    private Corporation corporation;

    @OneToMany(mappedBy = "project", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    private final Set<ProjectAccount> projectAccounts = new HashSet<>();

    public void addCorporation(Corporation corporation) {
        this.corporation = corporation;
    }

    public void addAccount(Account account) {
        ProjectAccount projectAccount = ProjectAccount.builder()
            .project(this)
            .account(account)
            .build();

        this.projectAccounts.add(projectAccount);
    }

    public void addImage(Image image) {
        this.images.add(image);
    }

    public long calculateLeftDays(long DAY) {
        return (this.deadLine.getTime() - new Date().getTime()) / DAY;
    }

    public long calculateLeftHours(long HOUR) {
        return (this.deadLine.getTime() - new Date().getTime()) / HOUR;
    }

    public void addEcoPoint(Integer ecoPoint) {
        this.currentMoney += ecoPoint;
    }
}