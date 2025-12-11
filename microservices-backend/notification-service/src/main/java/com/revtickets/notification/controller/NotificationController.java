package com.revtickets.notification.controller;

import com.revtickets.notification.service.EmailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import java.util.Map;

@RestController
@RequestMapping("/api/notifications")
public class NotificationController {
    @Autowired
    private EmailService emailService;
    
    private final RestTemplate restTemplate = new RestTemplate();

    @PostMapping("/booking-confirmation")
    public ResponseEntity<String> sendBookingConfirmation(@RequestBody Map<String, Object> data) {
        try {
            Long bookingId = Long.valueOf(data.get("bookingId").toString());
            
            // Get booking details
            Map booking = restTemplate.getForObject("http://localhost:8083/api/bookings/" + bookingId, Map.class);
            
            // Get user details
            Map user = restTemplate.getForObject("http://localhost:8081/api/users/" + booking.get("userId"), Map.class);
            
            // Get event details
            Map event = restTemplate.getForObject("http://localhost:8082/api/events/" + booking.get("eventId"), Map.class);
            
            // Get show details
            Map show = restTemplate.getForObject("http://localhost:8082/api/shows/" + booking.get("showId"), Map.class);
            
            // Get venue details
            Map venue = restTemplate.getForObject("http://localhost:8082/api/venues/" + show.get("venueId"), Map.class);
            
            // Send email
            emailService.sendBookingConfirmation(
                user.get("email").toString(),
                user.get("name").toString(),
                event.get("title").toString(),
                venue.get("name").toString(),
                show.get("showTime").toString(),
                Integer.parseInt(booking.get("numberOfSeats").toString()),
                Double.parseDouble(booking.get("totalAmount").toString()),
                bookingId.toString()
            );
            
            return ResponseEntity.ok("Email sent successfully");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Failed to send email: " + e.getMessage());
        }
    }
}
