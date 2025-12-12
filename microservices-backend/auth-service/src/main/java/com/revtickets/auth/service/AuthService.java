package com.revtickets.auth.service;

import com.revtickets.auth.config.JwtTokenUtil;
import com.revtickets.auth.dto.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import java.util.*;

@Service
public class AuthService {
    @Autowired
    private PasswordEncoder passwordEncoder;
    @Autowired
    private JwtTokenUtil jwtTokenUtil;
    @Value("${user.service.url}")
    private String userServiceUrl;
    
    private final RestTemplate restTemplate = new RestTemplate();

    public Map<String, Object> login(AuthRequest request) {
        try {
            Map<String, String> credentials = Map.of(
                "email", request.getEmail(),
                "password", request.getPassword()
            );
            Map<String, Object> user = restTemplate.postForObject(
                userServiceUrl + "/api/users/validate", credentials, Map.class);
            if (user == null) throw new RuntimeException("Invalid credentials");
            String token = jwtTokenUtil.generateToken(
                (String) user.get("email"), (String) user.get("role"));
            return Map.of("token", token, "user", user);
        } catch (Exception e) {
            throw new RuntimeException("Invalid credentials");
        }
    }

    public Map<String, Object> signup(SignupRequest request) {
        try {
            Map<String, Object> user = restTemplate.postForObject(
                userServiceUrl + "/api/users", request, Map.class);
            String token = jwtTokenUtil.generateToken(
                (String) user.get("email"), (String) user.get("role"));
            return Map.of("token", token, "user", user);
        } catch (Exception e) {
            throw new RuntimeException("Registration failed: " + e.getMessage());
        }
    }

    public boolean validateToken(String token) {
        return jwtTokenUtil.validateToken(token);
    }
    
    public void resetPassword(String email, String newPassword) {
        try {
            System.out.println("\n========== RESET PASSWORD ==========");
            System.out.println("Email: " + email);
            System.out.println("User Service URL: " + userServiceUrl);
            
            Map<String, Object> user = restTemplate.getForObject(
                userServiceUrl + "/api/users/email/" + email, Map.class);
            if (user == null) throw new RuntimeException("User not found");
            
            System.out.println("User found: " + user.get("id"));
            
            Map<String, String> updateData = Map.of(
                "password", newPassword
            );
            restTemplate.put(
                userServiceUrl + "/api/users/" + user.get("id") + "/password", updateData);
            
            System.out.println("✅ Password reset successful");
            System.out.println("========== RESET PASSWORD END ==========\n");
        } catch (Exception e) {
            System.err.println("❌ Reset password failed: " + e.getMessage());
            e.printStackTrace();
            System.out.println("========== RESET PASSWORD END ==========\n");
            throw new RuntimeException("Failed to reset password: " + e.getMessage());
        }
    }

    public Map<String, Object> googleLogin(String idToken) {
        System.out.println("\n========== GOOGLE LOGIN ==========");
        System.out.println("Received token: " + (idToken != null ? idToken.substring(0, Math.min(50, idToken.length())) + "..." : "NULL"));
        
        try {
            if (idToken == null || idToken.trim().isEmpty()) {
                throw new RuntimeException("Token is empty");
            }
            
            // Decode JWT token to extract email and name
            String[] parts = idToken.split("\\.");
            System.out.println("Token parts: " + parts.length);
            
            if (parts.length < 2) {
                throw new RuntimeException("Invalid token format - expected 3 parts, got " + parts.length);
            }
            
            String payload = new String(Base64.getUrlDecoder().decode(parts[1]));
            System.out.println("Decoded payload: " + payload);
            
            Map<String, Object> claims = new com.fasterxml.jackson.databind.ObjectMapper().readValue(payload, Map.class);
            
            String email = (String) claims.get("email");
            String name = (String) claims.get("name");
            
            System.out.println("Extracted email: " + email);
            System.out.println("Extracted name: " + name);
            
            if (email == null || email.isEmpty()) {
                throw new RuntimeException("Email not found in token");
            }
            
            Map<String, Object> user;
            try {
                System.out.println("Checking if user exists: " + email);
                user = restTemplate.getForObject(
                    userServiceUrl + "/api/users/email/" + email, Map.class);
                System.out.println("User found: " + user.get("id"));
            } catch (Exception e) {
                System.out.println("User not found, creating new user");
                Map<String, Object> newUser = new HashMap<>();
                newUser.put("name", name != null ? name : "Google User");
                newUser.put("email", email);
                newUser.put("password", UUID.randomUUID().toString());
                newUser.put("phone", "");
                newUser.put("role", "USER");
                
                user = restTemplate.postForObject(
                    userServiceUrl + "/api/users", newUser, Map.class);
                System.out.println("New user created: " + user.get("id"));
            }
            
            String token = jwtTokenUtil.generateToken(
                (String) user.get("email"), (String) user.get("role"));
            System.out.println("✅ Google login successful");
            System.out.println("========== GOOGLE LOGIN END ==========\n");
            return Map.of("token", token, "user", user);
        } catch (Exception e) {
            System.err.println("❌ Google login failed: " + e.getMessage());
            e.printStackTrace();
            System.out.println("========== GOOGLE LOGIN END ==========\n");
            throw new RuntimeException("Google login failed: " + e.getMessage());
        }
    }
}
