package com.codesquad.rocket.web.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.codesquad.rocket.service.ProjectService;
import com.codesquad.rocket.web.dto.response.project.ProjectDetailResponseDto;
import com.codesquad.rocket.web.dto.response.project.ProjectOrderByResponseDtos;
import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
@RequestMapping("/project")
public class ProjectController {

    private final ProjectService projectService;

    @GetMapping("/orderByCreatedAt")
    public ProjectOrderByResponseDtos orderByCreatedAt() {
        return projectService.orderByCreatedAt();
    }

    @GetMapping("/orderByDeadLine")
    public ProjectOrderByResponseDtos orderByDeadLine() {
        return projectService.orderByDeadLine();
    }

    @GetMapping("/{id}")
    public ProjectDetailResponseDto projectDetail(@PathVariable Long id) {
        return projectService.projectDetail(id);
    }
}
