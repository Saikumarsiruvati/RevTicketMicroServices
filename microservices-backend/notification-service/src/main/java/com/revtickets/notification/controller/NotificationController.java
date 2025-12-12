package com.revtickets.notification.controller;

import com.revtickets.notification.model.Notification;
import com.revtickets.notification.repository.NotificationRepository;
import com.revtickets.notification.service.EmailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/notifications")
public class NotificationController {
    @Autowired
    private EmailService emailService;
    
    @Autowired
    private NotificationRepository notificationRepository;
    
    private final RestTemplate restTemplate = new RestTemplate();

    @PostMapping("/booking-confirmation")
    public ResponseEntity<String> sendBookingConfirmation(@RequestBody Map<String, Object> data) {
        System.out.println("\n========== NOTIFICATION SERVICE CALLED ==========");
        try {
            Long bookingId = Long.valueOf(data.get("bookingId").toString());
            System.out.println("Processing booking ID: " + bookingId);
            
            // Get booking details
            System.out.println("Fetching booking details...");
            Map booking = restTemplate.getForObject("http://localhost:8083/api/bookings/" + bookingId + "/details", Map.class);
            System.out.println("Booking details fetched: " + (booking != null));
            
            if (booking == null) {
                return ResponseEntity.status(500).body("Failed to fetch booking details");
            }
            
            // Get user details
            System.out.println("Fetching user details for userId: " + booking.get("userId"));
            Map user = restTemplate.getForObject("http://localhost:8081/api/users/" + booking.get("userId"), Map.class);
            System.out.println("User details fetched: " + (user != null));
            
            if (user == null) {
                return ResponseEntity.status(500).body("Failed to fetch user details");
            }
            
            // Send email
            System.out.println("Sending email to: " + user.get("email"));
            emailService.sendBookingConfirmation(
                user.get("email").toString(),
                user.get("name").toString(),
                booking.get("movieName").toString(),
                booking.get("venueName").toString(),
                booking.get("showTime").toString(),
                Integer.parseInt(booking.get("numberOfSeats").toString()),
                Double.parseDouble(booking.get("totalAmount").toString()),
                bookingId.toString()
            );
            System.out.println("Email sent successfully");
            
            // Save notification to database
            System.out.println("Saving notification to MongoDB...");
            Notification notification = new Notification();
            notification.setUserId(Long.valueOf(booking.get("userId").toString()));
            notification.setMessage("Booking confirmed for " + booking.get("movieName").toString() + " at " + booking.get("venueName").toString());
            notification.setType("BOOKING_CONFIRMATION");
            Notification saved = notificationRepository.save(notification);
            System.out.println("Notification saved with ID: " + saved.getId());
            System.out.println("========== NOTIFICATION COMPLETE ==========");
            
            return ResponseEntity.ok("Email sent and notification saved successfully");
        } catch (Exception e) {
            System.err.println("ERROR in notification service: " + e.getMessage());
            e.printStackTrace();
            return ResponseEntity.status(500).body("Failed to send email: " + e.getMessage());
        }
    }
    
    @GetMapping("/user/{userId}")
    public ResponseEntity<List<Notification>> getUserNotifications(@PathVariable Long userId) {
        return ResponseEntity.ok(notificationRepository.findByUserId(userId));
    }
    
    @PutMapping("/{id}/read")
    public ResponseEntity<Notification> markAsRead(@PathVariable String id) {
        Notification notification = notificationRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Notification not found"));
        notification.setIsRead(true);
        return ResponseEntity.ok(notificationRepository.save(notification));
    }
    
    @PostMapping("/test")
    public ResponseEntity<Notification> createTestNotification() {
        Notification notification = new Notification();
        notification.setUserId(1L);
        notification.setMessage("Test notification - Database created successfully");
        notification.setType("TEST");
        Notification saved = notificationRepository.save(notification);
        return ResponseEntity.ok(saved);
    }
}
