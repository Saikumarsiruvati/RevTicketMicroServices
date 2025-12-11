package com.revtickets.auth.controller;

import com.revtickets.auth.dto.*;
import com.revtickets.auth.service.AuthService;
import com.revtickets.auth.service.EmailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.Map;
import java.util.HashMap;
import java.util.UUID;

@RestController
@RequestMapping("/api/auth")
public class AuthController {
    @Autowired
    private AuthService authService;
    
    @Autowired
    private EmailService emailService;
    
    private Map<String, String> resetTokens = new HashMap<>();

    @PostMapping("/login")
    public ResponseEntity<Map<String, Object>> login(@RequestBody AuthRequest request) {
        return ResponseEntity.ok(authService.login(request));
    }

    @PostMapping("/signup")
    public ResponseEntity<Map<String, Object>> signup(@RequestBody SignupRequest request) {
        return ResponseEntity.ok(authService.signup(request));
    }

    @PostMapping("/validate")
    public ResponseEntity<Boolean> validateToken(@RequestParam String token) {
        return ResponseEntity.ok(authService.validateToken(token));
    }

    @PostMapping("/google")
    public ResponseEntity<Map<String, Object>> googleLogin(@RequestBody Map<String, String> request) {
        return ResponseEntity.ok(authService.googleLogin(request.get("token")));
    }

    @PostMapping("/forgot-password")
    public ResponseEntity<Map<String, String>> forgotPassword(@RequestBody Map<String, String> request) {
        String email = request.get("email");
        try {
            String resetToken = UUID.randomUUID().toString();
            resetTokens.put(resetToken, email);
            emailService.sendPasswordResetEmail(email, resetToken);
            return ResponseEntity.ok(Map.of("message", "Password reset link sent to " + email));
        } catch (Exception e) {
            return ResponseEntity.ok(Map.of("message", "If the email exists, a reset link has been sent"));
        }
    }

    @PostMapping("/reset-password")
    public ResponseEntity<Map<String, String>> resetPassword(@RequestBody Map<String, String> request) {
        String token = request.get("token");
        String newPassword = request.get("password");
        
        if (!resetTokens.containsKey(token)) {
            return ResponseEntity.badRequest().body(Map.of("error", "Invalid or expired reset token"));
        }
        
        String email = resetTokens.get(token);
        resetTokens.remove(token);
        
        try {
            authService.resetPassword(email, newPassword);
            return ResponseEntity.ok(Map.of("message", "Password reset successful"));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of("error", "Failed to reset password"));
        }
    }
    
    @PostMapping("/reset-password-direct")
    public ResponseEntity<Map<String, String>> resetPasswordDirect(@RequestBody Map<String, String> request) {
        String email = request.get("email");
        String newPassword = request.get("password");
        
        try {
            authService.resetPassword(email, newPassword);
            return ResponseEntity.ok(Map.of("message", "Password reset successful"));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of("error", "Failed to reset password: " + e.getMessage()));
        }
    }
}
