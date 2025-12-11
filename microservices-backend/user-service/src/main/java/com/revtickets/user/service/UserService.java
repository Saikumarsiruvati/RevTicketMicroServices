package com.revtickets.user.service;

import com.revtickets.user.model.User;
import com.revtickets.user.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class UserService {
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private PasswordEncoder passwordEncoder;

    public User getUserById(Long id) {
        return userRepository.findById(id).orElseThrow(() -> new RuntimeException("User not found"));
    }

    public User getUserByEmail(String email) {
        return userRepository.findByEmail(email).orElseThrow(() -> new RuntimeException("User not found"));
    }

    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    public User updateUser(Long id, User userDetails) {
        User user = getUserById(id);
        
        if (userDetails.getName() != null && !userDetails.getName().isEmpty()) {
            user.setName(userDetails.getName());
        }
        
        if (userDetails.getEmail() != null && !userDetails.getEmail().isEmpty() 
            && !userDetails.getEmail().equals(user.getEmail())) {
            if (userRepository.existsByEmail(userDetails.getEmail())) {
                throw new RuntimeException("Email already exists");
            }
            user.setEmail(userDetails.getEmail());
        }
        
        if (userDetails.getPhone() != null) {
            user.setPhone(userDetails.getPhone());
        }
        
        return userRepository.save(user);
    }

    public void blockUser(Long id) {
        User user = getUserById(id);
        user.setIsBlocked(true);
        userRepository.save(user);
    }

    public void unblockUser(Long id) {
        User user = getUserById(id);
        user.setIsBlocked(false);
        userRepository.save(user);
    }

    public User validateUser(String email, String password) {
        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("Invalid credentials"));
        boolean isValid = passwordEncoder.matches(password, user.getPassword()) || password.equals(user.getPassword());
        if (!isValid)
            throw new RuntimeException("Invalid credentials");
        if (user.getIsBlocked())
            throw new RuntimeException("Account blocked");
        return user;
    }

    public User createUser(User user) {
        if (userRepository.existsByEmail(user.getEmail()))
            throw new RuntimeException("Email already exists");
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setIsBlocked(false);
        return userRepository.save(user);
    }
    
    public void updatePassword(Long id, String newPassword) {
        User user = getUserById(id);
        user.setPassword(passwordEncoder.encode(newPassword));
        userRepository.save(user);
    }
}
