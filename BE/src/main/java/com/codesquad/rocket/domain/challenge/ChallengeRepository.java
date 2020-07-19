package com.codesquad.rocket.domain.challenge;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

public interface ChallengeRepository extends JpaRepository<Challenge, Long> {
    List<Challenge> findAllByOrderByCreatedAtDesc();
}
