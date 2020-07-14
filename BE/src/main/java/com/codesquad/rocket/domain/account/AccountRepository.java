package com.codesquad.rocket.domain.account;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface AccountRepository extends JpaRepository<Account, Long> {

    @Query("SELECT SUM(a.totalPlate) FROM Account a")
    int sumTotalPlate();

    @Query("SELECT SUM(a.todayPlate) FROM Account  a")
    int sumTodayPlate();

    Optional<Account> findAccountByName(String name);
}
