package com.codesquad.rocket.web.dto.response.challenge;

import java.util.Date;

import com.codesquad.rocket.domain.challenge.Challenge;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@Builder
public class ChallengeDetailResponseDto {

    private Long id;
    private Integer likeCount;
    private String image;
    private String description;
    private String restaurantName;
    private Double latitude;
    private Double longitude;
    private Date createdAt;
    private Date updatedAt;
    private String isLiked;
    private String author;

    public static ChallengeDetailResponseDto likedOf(Challenge challenge) {
        challenge.isAtRestaurant();

        return ChallengeDetailResponseDto.builder()
            .id(challenge.getId())
            .likeCount(challenge.getLikes().size())
            .image(challenge.getUrl())
            .description(challenge.getDescription())
            .restaurantName(challenge.getRestaurantName())
            .createdAt(challenge.getCreatedAt())
            .updatedAt(challenge.getUpdatedAt())
            .latitude(challenge.getPoint().getY())
            .longitude(challenge.getPoint().getX())
            .author(challenge.getAccount().getName())
            .isLiked("True")
            .build();
    }

    public static ChallengeDetailResponseDto unLikedOf(Challenge challenge) {
        challenge.isAtRestaurant();

        return ChallengeDetailResponseDto.builder()
            .id(challenge.getId())
            .likeCount(challenge.getLikes().size())
            .image(challenge.getUrl())
            .description(challenge.getDescription())
            .restaurantName(challenge.getRestaurantName())
            .createdAt(challenge.getCreatedAt())
            .updatedAt(challenge.getUpdatedAt())
            .latitude(challenge.getPoint().getY())
            .longitude(challenge.getPoint().getX())
            .author(challenge.getAccount().getName())
            .isLiked("False")
            .build();
    }
}
