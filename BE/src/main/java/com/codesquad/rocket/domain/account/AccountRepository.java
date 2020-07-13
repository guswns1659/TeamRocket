package com.codesquad.rocket.domain.account;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface AccountRepository extends JpaRepository<Account, Long> {

    @Query("SELECT SUM(a.totalCount) FROM Account a")
    int sumTotalSaving();
}
