package com.codesquad.rocket.domain.account;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.CascadeType;
import javax.persistence.CollectionTable;
import javax.persistence.Column;
import javax.persistence.ElementCollection;
import javax.persistence.Embeddable;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.locationtech.jts.geom.Point;

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
public class Challenge {

    @Id
    @GeneratedValue
    private Long id;

    @Column(name = "challenge_like_count")
    private Integer likeCount;

    private String url;

    private String description;

    @Column(name = "challenge_restaurant_name")
    private String restaurantName;

    private Point point;

    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;

    @Temporal(TemporalType.TIMESTAMP)
    private Date updatedAt;

    @ManyToOne(cascade = CascadeType.ALL)
    private Account account;

    @ElementCollection
    @CollectionTable(name = "challenge_like", joinColumns = @JoinColumn(name = "challenge_id"))
    @AttributeOverrides({
        @AttributeOverride(name = "name", column = @Column(name = "account_name"))
    })
    private final List<Like> likes = new ArrayList<>();

    public void addLike(Like like) {
        this.likes.add(like);
    }
}