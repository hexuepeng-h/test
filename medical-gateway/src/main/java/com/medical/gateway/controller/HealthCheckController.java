package com.medical.gateway.controller;

import com.netflix.discovery.EurekaClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.http.ResponseEntity;

@RestController
public class HealthCheckController {

    private final EurekaClient eurekaClient;

    public HealthCheckController(EurekaClient eurekaClient) {
        this.eurekaClient = eurekaClient;
    }

    @GetMapping("/livez")
    public ResponseEntity<String> liveness() {
        return ResponseEntity.ok("OK");
    }

    @GetMapping("/readyz")
    public ResponseEntity<String> readiness() {
        try {
            // 检查Eureka服务是否可用，并且至少有一个服务注册
            if (eurekaClient.getApplications().size() > 0) {
                return ResponseEntity.ok("OK");
            } else {
                return ResponseEntity.status(503).body("No Services Available");
            }
        } catch (Exception e) {
            return ResponseEntity.status(503).body("Service Unavailable");
        }
    }
} 