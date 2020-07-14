package com.codesquad.rocket.domain;

import static org.assertj.core.api.Assertions.*;

import java.time.LocalDate;
import java.util.Date;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.reactive.AutoConfigureWebTestClient;
import org.springframework.boot.test.context.SpringBootTest;

import com.codesquad.rocket.domain.account.Account;
import com.codesquad.rocket.domain.corporation.Corporation;
import com.codesquad.rocket.domain.project.Project;
import com.codesquad.rocket.domain.project.ProjectRepository;
import com.codesquad.rocket.domain.restaurant.Image;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
@AutoConfigureWebTestClient(timeout = "30000")
public class ProjectRepositoryTest {

    @Autowired
    private ProjectRepository projectRepository;

    @DisplayName("기업과 프로젝트를 저장하는 테스트")
    @CsvSource({"corporation, project1, 100000, description, 55555, 2020-07-13, 100, project2"})
    @ParameterizedTest
    void 프로젝트저장소로_프로젝트와_기업을_저장한다(String corporationName, String projectName1, Integer currentMoney,
        String description, Integer targetMoney, String deadLine, Integer donators, String projectName2) {
        Corporation corporation = Corporation.builder()
            .name(corporationName)
            .build();

        Project project1 = Project.builder()
            .name(projectName1)
            .currentMoney(currentMoney)
            .createdAt(new Date())
            .description(description)
            .targetMoney(targetMoney)
            .deadLine(LocalDate.parse(deadLine))
            .donators(donators)
            .build();

        Project project2 = Project.builder()
            .name(projectName2)
            .currentMoney(currentMoney)
            .description(description)
            .targetMoney(targetMoney)
            .deadLine(LocalDate.parse(deadLine))
            .donators(donators)
            .build();

        corporation.addProject(project1);
        corporation.addProject(project2);
        Project savedProject1 = projectRepository.save(project1);
        Project savedProject2 = projectRepository.save(project2);

        assertThat(savedProject1.getCorporation().getName()).isEqualTo(corporationName);
        assertThat(savedProject2.getCorporation().getName()).isEqualTo(corporationName);
        assertThat(savedProject1.getCurrentMoney()).isEqualTo(currentMoney);
    }

    @DisplayName("유저와 프로젝트를 저장하는 테스트")
    @CsvSource({"accountName1, 3, 3, www.naver.com, projectName1, 2020-08-10, description, corporationName"})
    @ParameterizedTest
    void 유저와_프로젝트를_중간테이블로_저장한다(String accountName, Integer ecoPoint, Integer todayCount, String url,
        String projectName1, String deadLine, String description, String corporationName) {

        Account account = Account.builder()
            .name(accountName)
            .ecoPoint(ecoPoint)
            .todayPlate(todayCount)
            .build();

        Image image = Image.builder()
            .url(url)
            .build();

        Project project1 = Project.builder()
            .name(projectName1)
            .deadLine(LocalDate.parse(deadLine))
            .description(description)
            .build();

        project1.addImage(image);

        Corporation corporation = Corporation.builder()
            .name(corporationName)
            .build();

        corporation.addProject(project1);
        project1.addAccount(account);
        Project savedProject = projectRepository.save(project1);

        assertThat(savedProject.getProjectAccounts().size()).isEqualTo(1);
        assertThat(savedProject.getProjectAccounts().iterator().next().getAccount().getEcoPoint()).isEqualTo(ecoPoint);
    }
}
