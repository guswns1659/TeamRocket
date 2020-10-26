package com.codesquad.rocket.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    private final String ALL = "*";
    private final String ALL_PATH = "/**";

    @Override
    public void addCorsMappings(CorsRegistry registry) {
        String[] allowedMethods = new String[]{"GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS"};
        long MAX_AGE_SECS = 3600;

        registry.addMapping(ALL_PATH)
                .allowedOrigins(ALL)
                .allowedMethods(allowedMethods)
                .allowedHeaders(ALL)
                .allowCredentials(true)
                .maxAge(MAX_AGE_SECS);
    }
}
