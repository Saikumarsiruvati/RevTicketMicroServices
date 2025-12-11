package com.revtickets.user.service;

import com.revtickets.user.config.JwtTokenUtil;
import com.revtickets.user.dto.*;
import com.revtickets.user.model.User;
import com.revtickets.user.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import java.util.*;

@Service
public class AuthService {
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private PasswordEncoder passwordEncoder;
    @Autowired
    private JwtTokenUtil jwtTokenUtil;

    public Map<String, Object> login(AuthRequest request) {
        User user = userRepository.findByEmail(request.getEmail())
                .orElseThrow(() -> new RuntimeException("Invalid credentials"));
        if (!passwordEncoder.matches(request.getPassword(), user.getPassword()))
            throw new RuntimeException("Invalid credentials");
        if (user.getIsBlocked())
            throw new RuntimeException("Account blocked");
        String token = jwtTokenUtil.generateToken(user.getEmail(), user.getRole().name());
        return Map.of("token", token, "user", user);
    }

    public Map<String, Object> signup(SignupRequest request) {
        if (userRepository.existsByEmail(request.getEmail()))
            throw new RuntimeException("Email already exists");
        User user = new User();
        user.setName(request.getName());
        user.setEmail(request.getEmail());
        user.setPassword(passwordEncoder.encode(request.getPassword()));
        user.setPhone(request.getPhone());
        user.setRole("admin@revtickets.com".equals(request.getEmail()) ? User.Role.ADMIN : User.Role.USER);
        user = userRepository.save(user);
        String token = jwtTokenUtil.generateToken(user.getEmail(), user.getRole().name());
        return Map.of("token", token, "user", user);
    }
}
