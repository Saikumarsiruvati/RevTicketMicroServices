package com.revtickets.user.controller;

import com.revtickets.user.model.User;
import com.revtickets.user.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/users")
public class UserController {
    @Autowired
    private UserService userService;

    @GetMapping("/{id}")
    public ResponseEntity<User> getUserById(@PathVariable Long id) {
        return ResponseEntity.ok(userService.getUserById(id));
    }

    @GetMapping("/email/{email}")
    public ResponseEntity<User> getUserByEmail(@PathVariable String email) {
        return ResponseEntity.ok(userService.getUserByEmail(email));
    }

    @GetMapping
    public ResponseEntity<List<User>> getAllUsers() {
        return ResponseEntity.ok(userService.getAllUsers());
    }

    @PutMapping("/{id}")
    public ResponseEntity<User> updateUser(@PathVariable Long id, @RequestBody User user) {
        try {
            System.out.println("\n========== UPDATE USER ==========");
            System.out.println("User ID: " + id);
            System.out.println("Request body: " + user);
            System.out.println("Name: " + user.getName());
            System.out.println("Email: " + user.getEmail());
            System.out.println("Phone: " + user.getPhone());
            User updated = userService.updateUser(id, user);
            System.out.println("✅ User updated successfully");
            System.out.println("========== UPDATE USER END ==========\n");
            return ResponseEntity.ok(updated);
        } catch (Exception e) {
            System.err.println("❌ Update user failed: " + e.getMessage());
            e.printStackTrace();
            System.out.println("========== UPDATE USER END ==========\n");
            throw e;
        }
    }
    
    @PutMapping("/profile")
    public ResponseEntity<User> updateProfile(@RequestBody User user) {
        try {
            System.out.println("\n========== UPDATE PROFILE ==========");
            System.out.println("User ID: " + user.getId());
            System.out.println("Name: " + user.getName());
            System.out.println("Phone: " + user.getPhone());
            User updated = userService.updateUser(user.getId(), user);
            System.out.println("✅ Profile updated successfully");
            System.out.println("========== UPDATE PROFILE END ==========\n");
            return ResponseEntity.ok(updated);
        } catch (Exception e) {
            System.err.println("❌ Update profile failed: " + e.getMessage());
            e.printStackTrace();
            System.out.println("========== UPDATE PROFILE END ==========\n");
            throw e;
        }
    }

    @PutMapping("/{id}/block")
    public ResponseEntity<Void> blockUser(@PathVariable Long id) {
        userService.blockUser(id);
        return ResponseEntity.ok().build();
    }

    @PutMapping("/{id}/unblock")
    public ResponseEntity<Void> unblockUser(@PathVariable Long id) {
        userService.unblockUser(id);
        return ResponseEntity.ok().build();
    }
    
    @PutMapping("/{id}/password")
    public ResponseEntity<Void> updatePassword(@PathVariable Long id, @RequestBody Map<String, String> request) {
        String newPassword = request.get("password");
        userService.updatePassword(id, newPassword);
        return ResponseEntity.ok().build();
    }

    @PostMapping("/validate")
    public ResponseEntity<Map<String, Object>> validateUser(@RequestBody Map<String, String> credentials) {
        String email = credentials.get("email");
        String password = credentials.get("password");
        if (email == null || password == null) {
            throw new RuntimeException("Email and password are required");
        }
        User user = userService.validateUser(email, password);
        return ResponseEntity.ok(Map.of(
            "id", user.getId(),
            "name", user.getName(),
            "email", user.getEmail(),
            "phone", user.getPhone() != null ? user.getPhone() : "",
            "role", user.getRole().name(),
            "isBlocked", user.getIsBlocked()
        ));
    }

    @PostMapping
    public ResponseEntity<Map<String, Object>> createUser(@RequestBody Map<String, Object> request) {
        User user = new User();
        user.setName((String) request.get("name"));
        user.setEmail((String) request.get("email"));
        user.setPassword((String) request.get("password"));
        user.setPhone((String) request.get("phone"));
        user.setRole("admin@revtickets.com".equals(request.get("email")) ? User.Role.ADMIN : User.Role.USER);
        User created = userService.createUser(user);
        return ResponseEntity.ok(Map.of(
            "id", created.getId(),
            "name", created.getName(),
            "email", created.getEmail(),
            "phone", created.getPhone() != null ? created.getPhone() : "",
            "role", created.getRole().name(),
            "isBlocked", created.getIsBlocked()
        ));
    }
}
