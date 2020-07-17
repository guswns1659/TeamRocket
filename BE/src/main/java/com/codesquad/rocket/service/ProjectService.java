package com.codesquad.rocket.service;

import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.codesquad.rocket.domain.account.Account;
import com.codesquad.rocket.domain.account.AccountRepository;
import com.codesquad.rocket.domain.account.PointHistory;
import com.codesquad.rocket.domain.account.PointOption;
import com.codesquad.rocket.domain.project.Project;
import com.codesquad.rocket.domain.project.ProjectRepository;
import com.codesquad.rocket.web.dto.response.project.ProjectDetailResponseDto;
import com.codesquad.rocket.web.dto.response.project.ProjectOrderByDto;
import com.codesquad.rocket.web.dto.response.project.ProjectOrderByResponseDtos;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ProjectService {

    private final ProjectRepository projectRepository;
    private final AccountRepository accountRepository;

    public ProjectOrderByResponseDtos orderByCreatedAt() {
        List<Project> projects = projectRepository.findAllByOrderByCreatedAt();
        List<ProjectOrderByDto> data = projects.stream()
            .map(ProjectOrderByDto::of)
            .collect(Collectors.toList());

        return ProjectOrderByResponseDtos.builder()
            .data(data)
            .build();
    }

    public ProjectOrderByResponseDtos orderByDeadLine() {
        List<Project> projects = projectRepository.findTop3AllByOrderByDeadLine();
        List<ProjectOrderByDto> data = projects.stream()
            .map(ProjectOrderByDto::of)
            .collect(Collectors.toList());

        return ProjectOrderByResponseDtos.builder()
            .data(data)
            .build();
    }

    public ProjectDetailResponseDto projectDetail(Long projectId) {
        Project project = projectRepository.findById(projectId).orElse(new Project());
        return ProjectDetailResponseDto.of(project);
    }

    public ProjectDetailResponseDto donate(Long id, Integer ecoPoint) {
        Account account = accountRepository.findAccountByName("delma").orElse(new Account());
        Project project = projectRepository.findById(id).orElse(new Project());
        project.addEcoPoint(ecoPoint);
        project.hasDonator(account);
        Project addedProject = projectRepository.save(project);

        account.subtractEcoPoint(ecoPoint);
        // pointHistory 생성 후 account에 추가 한뒤 저장.
        PointHistory pointHistory = PointHistory.builder()
            .ecoPoint(ecoPoint)
            .pointOption(PointOption.DONATE)
            .createdAt(new Date())
            .projectName(project.getName())
            .build();
        account.addPointHistory(pointHistory);
        accountRepository.save(account);

        return ProjectDetailResponseDto.of(addedProject);
    }
}
