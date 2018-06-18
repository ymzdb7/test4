package com.crm.auth;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

@Configuration  
@ComponentScan(basePackages={"com.crm.controller"})  
@EnableWebMvc  
public class MvcConfig extends WebMvcConfigurerAdapter{  
    @Override  
    public void addInterceptors(InterceptorRegistry registry) {  
        registry.addInterceptor(new AuthInterceptor());  
    }  
}  