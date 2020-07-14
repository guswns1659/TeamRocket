package com.codesquad.rocket.service;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.codesquad.rocket.domain.project.Project;
import com.codesquad.rocket.domain.project.ProjectRepository;
import com.codesquad.rocket.web.dto.response.project.ProjectOrderByResponseDtos;
import com.codesquad.rocket.web.dto.response.project.ProjectOrderByDto;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ProjectService {

    private final ProjectRepository projectRepository;

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
}
