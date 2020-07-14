package com.codesquad.rocket.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.bedatadriven.jackson.datatype.jts.JtsModule;

@Configuration
public class BeanConfig {

    @Bean
    public JtsModule jtsModule()
    {
        return new JtsModule();
    }
}
