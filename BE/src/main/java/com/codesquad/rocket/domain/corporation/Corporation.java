package com.codesquad.rocket.domain.corporation;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;

import com.codesquad.rocket.domain.project.Project;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Getter
@NoArgsConstructor
@AllArgsConstructor(access = AccessLevel.PRIVATE)
@Builder
public class Corporation {

    @Id
    @GeneratedValue
    private Long id;

    private String name;

    @OneToMany(mappedBy = "corporation", cascade = CascadeType.ALL)
    private final Set<Project> projects = new HashSet<>();

    public void addProject(Project project) {
        this.projects.add(project);
        project.addCorporation(this);
    }
}
