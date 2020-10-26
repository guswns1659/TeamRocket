package com.codesquad.rocket.domain.challenge;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.codesquad.rocket.domain.restaurant.Restaurant;
import org.locationtech.jts.geom.Point;
import org.locationtech.jts.io.WKTReader;

import com.codesquad.rocket.domain.account.Account;
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

    @ElementCollection(fetch = FetchType.EAGER)
    @CollectionTable(name = "challenge_like", joinColumns = @JoinColumn(name = "challenge_id"))
    @AttributeOverrides({
        @AttributeOverride(name = "name", column = @Column(name = "account_name"))
    })
    private final List<Like> likes = new ArrayList<>();

    public static Challenge from(Account account, Restaurant restaurant, String uploadUrl, String description) {
        return Challenge.builder()
                .account(account)
                .createdAt(new Date())
                .description(description)
                .point(restaurant.getPoint())
                .restaurantName(restaurant.getName())
                .updatedAt(new Date())
                .url(uploadUrl)
                .build();
    }

    public void addLike(Like like) {
        this.likes.add(like);
    }

    public void removeLike(Account account) {
        Like foundLike = this.likes.stream()
            .filter(like -> like.hasAccount(account))
            .findFirst()
            .orElseThrow(() -> new IllegalStateException("해당하는 Like가 없습니다. accountName" + account.getName()));
        this.likes.remove(foundLike);
    }

    public void isAtRestaurant() {
        try {
            if (this.getRestaurantName() == null) {
                this.restaurantName = "null";
                Double latitude = 0.0;
                Double longitude = 0.0;
                String pointWKT = String.format("POINT(%s %s)", longitude, latitude);
                this.point = (Point) new WKTReader().read(pointWKT);
            }
        } catch (Exception e) {
            this.restaurantName = "null";
            throw new IllegalStateException("point 생성 실패");
        }
    }
}