package com.codex.welcome.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class WelcomeController {

    @GetMapping("/")
    public String greet() {
        return "Hello from Spring Boot CI/CD Pipeline!";
    }

}
