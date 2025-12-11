package com.revtickets.booking.controller;

import com.revtickets.booking.model.Booking;
import com.revtickets.booking.service.BookingService;
import com.revtickets.booking.service.EmailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/bookings")
public class BookingController {
    @Autowired
    private BookingService bookingService;
    
    @Autowired
    private EmailService emailService;
    
    @Autowired
    private RestTemplate restTemplate;
    
    @Value("${user.service.url}")
    private String userServiceUrl;

    @GetMapping
    public ResponseEntity<List<Booking>> getAllBookings() {
        return ResponseEntity.ok(bookingService.getAllBookings());
    }

    @PostMapping
    public ResponseEntity<Booking> createBooking(@RequestBody Booking booking) {
        System.out.println("\n========== CREATING BOOKING ==========");
        Booking createdBooking = bookingService.createBooking(booking);
        System.out.println("Booking created with ID: " + createdBooking.getId());
        
        try {
            System.out.println("Fetching user details for userId: " + booking.getUserId());
            Map<String, Object> user = restTemplate.getForObject(
                userServiceUrl + "/api/users/" + booking.getUserId(), Map.class);
            System.out.println("User email: " + (user != null ? user.get("email") : "NULL"));
            
            System.out.println("Fetching show details for showId: " + booking.getShowId());
            Map<String, Object> show = restTemplate.getForObject(
                "http://localhost:8082/api/shows/" + booking.getShowId(), Map.class);
            System.out.println("Show fetched: " + (show != null ? "YES" : "NULL"));
            
            System.out.println("Fetching event details for eventId: " + show.get("eventId"));
            Map<String, Object> event = restTemplate.getForObject(
                "http://localhost:8082/api/events/" + show.get("eventId"), Map.class);
            System.out.println("Event title: " + (event != null ? event.get("title") : "NULL"));
            
            System.out.println("Fetching venue details for venueId: " + show.get("venueId"));
            Map<String, Object> venue = restTemplate.getForObject(
                "http://localhost:8082/api/venues/" + show.get("venueId"), Map.class);
            System.out.println("Venue name: " + (venue != null ? venue.get("name") : "NULL"));
            
            if (user != null && event != null && show != null && venue != null) {
                System.out.println("\n🔔 SENDING EMAIL NOW...");
                emailService.sendBookingConfirmationEmail(
                    (String) user.get("email"),
                    (String) user.get("name"),
                    String.valueOf(createdBooking.getId()),
                    (String) event.get("title"),
                    show.get("showTime").toString(),
                    createdBooking.getSeatNumbers(),
                    String.valueOf(createdBooking.getTotalAmount()),
                    (String) venue.get("name"),
                    (String) event.get("language"),
                    (String) event.get("genreOrType")
                );
                System.out.println("Email method called successfully");
            } else {
                System.err.println("❌ MISSING DATA - Cannot send email!");
                System.err.println("User: " + (user != null));
                System.err.println("Event: " + (event != null));
                System.err.println("Show: " + (show != null));
                System.err.println("Venue: " + (venue != null));
            }
        } catch (Exception e) {
            System.err.println("❌ ERROR in booking email: " + e.getMessage());
            e.printStackTrace();
        }
        
        System.out.println("========== BOOKING COMPLETE ==========\n");
        return ResponseEntity.ok(createdBooking);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Booking> getBookingById(@PathVariable Long id) {
        return ResponseEntity.ok(bookingService.getBookingById(id));
    }

    @GetMapping("/{id}/details")
    public ResponseEntity<Map<String, Object>> getBookingDetails(@PathVariable Long id) {
        Booking booking = bookingService.getBookingById(id);
        Map<String, Object> details = new java.util.HashMap<>();
        
        try {
            // Get show details
            Map<String, Object> show = restTemplate.getForObject(
                "http://localhost:8082/api/shows/" + booking.getShowId(), Map.class);
            
            // Get event/movie details
            Map<String, Object> event = restTemplate.getForObject(
                "http://localhost:8082/api/events/" + show.get("eventId"), Map.class);
            
            // Get venue details
            Map<String, Object> venue = restTemplate.getForObject(
                "http://localhost:8082/api/venues/" + show.get("venueId"), Map.class);
            
            // Build complete details
            details.put("bookingId", booking.getId());
            details.put("userId", booking.getUserId());
            details.put("status", booking.getStatus());
            details.put("bookingDate", booking.getBookingDate());
            details.put("numberOfSeats", booking.getNumberOfSeats());
            details.put("seatNumbers", booking.getSeatNumbers());
            details.put("totalAmount", booking.getTotalAmount());
            details.put("paymentId", booking.getPaymentId());
            
            // Movie details
            details.put("movieName", event.get("title"));
            details.put("movieLanguage", event.get("language"));
            details.put("movieGenre", event.get("genreOrType"));
            details.put("moviePoster", event.get("posterUrl"));
            details.put("movieRating", event.get("rating"));
            
            // Show details
            details.put("showTime", show.get("showTime"));
            details.put("showId", show.get("id"));
            
            // Venue details
            details.put("venueName", venue.get("name"));
            details.put("venueAddress", venue.get("address"));
            details.put("venueCity", venue.get("city"));
            
        } catch (Exception e) {
            System.err.println("Error fetching booking details: " + e.getMessage());
        }
        
        return ResponseEntity.ok(details);
    }

    @GetMapping("/user/{userId}")
    public ResponseEntity<List<Booking>> getBookingsByUserId(@PathVariable Long userId) {
        return ResponseEntity.ok(bookingService.getBookingsByUserId(userId));
    }

    @PutMapping("/{id}/confirm")
    public ResponseEntity<Booking> confirmBooking(@PathVariable Long id, @RequestParam String paymentId) {
        return ResponseEntity.ok(bookingService.confirmBooking(id, paymentId));
    }

    @PutMapping("/{id}/cancel")
    public ResponseEntity<Void> cancelBooking(@PathVariable Long id) {
        System.out.println("\n========== CANCELLING BOOKING ==========");
        Booking booking = bookingService.getBookingById(id);
        bookingService.cancelBooking(id);
        
        try {
            Map<String, Object> user = restTemplate.getForObject(
                userServiceUrl + "/api/users/" + booking.getUserId(), Map.class);
            
            Map<String, Object> show = restTemplate.getForObject(
                "http://localhost:8082/api/shows/" + booking.getShowId(), Map.class);
            
            Map<String, Object> event = restTemplate.getForObject(
                "http://localhost:8082/api/events/" + show.get("eventId"), Map.class);
            
            Map<String, Object> venue = restTemplate.getForObject(
                "http://localhost:8082/api/venues/" + show.get("venueId"), Map.class);
            
            if (user != null && event != null && show != null && venue != null) {
                System.out.println("🔔 SENDING CANCELLATION EMAIL...");
                emailService.sendBookingCancellationEmail(
                    (String) user.get("email"),
                    (String) user.get("name"),
                    String.valueOf(booking.getId()),
                    (String) event.get("title"),
                    String.valueOf(booking.getTotalAmount()),
                    show.get("showTime").toString(),
                    booking.getSeatNumbers(),
                    (String) venue.get("name")
                );
            }
        } catch (Exception e) {
            System.err.println("❌ Failed to send cancellation email: " + e.getMessage());
            e.printStackTrace();
        }
        
        System.out.println("========== CANCELLATION COMPLETE ==========\n");
        return ResponseEntity.ok().build();
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteBooking(@PathVariable Long id) {
        bookingService.deleteBooking(id);
        return ResponseEntity.ok().build();
    }
}
