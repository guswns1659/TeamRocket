package com.codesquad.rocket.service;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.codesquad.rocket.domain.project.Project;
import com.codesquad.rocket.domain.project.ProjectRepository;
import com.codesquad.rocket.web.dto.response.ProjectByCreatedAtResponseDtos;
import com.codesquad.rocket.web.dto.response.project.ProjectByCreatedAtDto;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ProjectService {

    private final ProjectRepository projectRepository;

    public ProjectByCreatedAtResponseDtos orderByCreatedAt() {
        List<Project> projects = projectRepository.findAllByOrderByCreatedAt();
        List<ProjectByCreatedAtDto> data = projects.stream()
            .map(ProjectByCreatedAtDto::of)
            .collect(Collectors.toList());

        return ProjectByCreatedAtResponseDtos.builder()
            .data(data)
            .build();
    }
}
