package com.codesquad.rocket.web.dto.response;

import java.util.List;

import com.codesquad.rocket.web.dto.response.project.ProjectByCreatedAtDto;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@Builder
public class ProjectByCreatedAtResponseDtos {

    private String status;
    private List<ProjectByCreatedAtDto> data;

}
