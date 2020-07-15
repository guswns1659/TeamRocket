package com.codesquad.rocket.domain.challenge;

import org.springframework.data.jpa.repository.JpaRepository;

import com.codesquad.rocket.domain.account.Challenge;

public interface ChallengeRepository extends JpaRepository<Challenge, Long> {
}
