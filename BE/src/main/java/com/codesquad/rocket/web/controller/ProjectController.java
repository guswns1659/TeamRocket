package com.codesquad.rocket.web.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.codesquad.rocket.service.ProjectService;
import com.codesquad.rocket.web.dto.response.ProjectByCreatedAtResponseDtos;
import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
@RequestMapping("/project")
public class ProjectController {

    private final ProjectService projectService;

    @GetMapping("/orderByCreatedAt")
    public ProjectByCreatedAtResponseDtos orderByCreatedAt() {
        return projectService.orderByCreatedAt();
    }
}
