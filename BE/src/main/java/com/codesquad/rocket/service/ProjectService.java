package com.codesquad.rocket.service;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.codesquad.rocket.domain.account.Account;
import com.codesquad.rocket.domain.account.AccountRepository;
import com.codesquad.rocket.domain.project.Project;
import com.codesquad.rocket.domain.project.ProjectRepository;
import com.codesquad.rocket.web.dto.response.project.ProjectDetailResponseDto;
import com.codesquad.rocket.web.dto.response.project.ProjectOrderByResponseDtos;
import com.codesquad.rocket.web.dto.response.project.ProjectOrderByDto;
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
        Project project = projectRepository.findById(id).orElse(new Project());
        project.addEcoPoint(ecoPoint);
        Project addedProject = projectRepository.save(project);
        Account account = accountRepository.findAccountByName("delma").orElse(new Account());
        account.subtractEcoPoint(ecoPoint);

        return ProjectDetailResponseDto.of(addedProject);
    }
}
