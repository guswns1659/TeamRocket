package com.codesquad.rocket.web.dto.response.challenge;

import java.util.Date;

import com.codesquad.rocket.domain.account.Challenge;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@Builder
public class ChallengeDto {

    private Integer likeCount;
    private String image;
    private String description;
    private String restaurantName;
    private Double latitude;
    private Double longitude;
    private Date createdAt;
    private Date updatedAt;

    public static ChallengeDto of(Challenge challenge) {
        return ChallengeDto.builder()
            .likeCount(challenge.getLikeCount())
            .image(challenge.getUrl())
            .description(challenge.getDescription())
            .restaurantName(challenge.getRestaurantName())
            .createdAt(challenge.getCreatedAt())
            .updatedAt(challenge.getUpdatedAt())
            .latitude(challenge.getPoint().getY())
            .longitude(challenge.getPoint().getX())
            .build();
    }
}
