package com.codesquad.rocket.domain.restaurant;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.CollectionTable;
import javax.persistence.Column;
import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;

import org.locationtech.jts.geom.Point;

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
public class Restaurant {

    @Id
    @GeneratedValue
    private Long id;

    private String name;

    private String description;

    private String address;

    private Double rating;

    private Point point;

    @ElementCollection
    @CollectionTable(name = "restaurant_image", joinColumns = @JoinColumn(name = "restaurant_id"))
    @AttributeOverrides({
        @AttributeOverride(name = "url", column = @Column(name = "image_url"))
    })
    private final List<Image> images = new ArrayList<>();

    public void addImage(Image image) {
        this.getImages().add(image);
    }
}
