package com.revtickets.booking.controller;

import com.revtickets.booking.model.Booking;
import com.revtickets.booking.model.Notification;
import com.revtickets.booking.repository.NotificationRepository;
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
    
    @Autowired
    private NotificationRepository notificationRepository;
    
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
            // Get booking details for notification
            Map<String, Object> bookingDetails = restTemplate.getForObject(
                "http://booking-service:8083/api/bookings/" + createdBooking.getId() + "/details", Map.class);
            
            // Get user details
            Map<String, Object> user = restTemplate.getForObject(
                userServiceUrl + "/api/users/" + createdBooking.getUserId(), Map.class);
            
            if (bookingDetails != null && user != null) {
                // Save notification to MongoDB
                System.out.println("💾 Saving notification to MongoDB...");
                Notification notification = new Notification();
                notification.setUserId(createdBooking.getUserId());
                notification.setUserName(user.get("name").toString());
                notification.setBookingId(createdBooking.getId());
                notification.setMovieName(bookingDetails.get("movieName").toString());
                notification.setVenueName(bookingDetails.get("venueName").toString());
                notification.setShowTime(bookingDetails.get("showTime").toString());
                notification.setNumberOfSeats(Integer.parseInt(bookingDetails.get("numberOfSeats").toString()));
                notification.setSeatNumbers(bookingDetails.get("seatNumbers").toString());
                notification.setTotalAmount(Double.parseDouble(bookingDetails.get("totalAmount").toString()));
                notification.setMessage("Booking confirmed for " + bookingDetails.get("movieName") + " at " + bookingDetails.get("venueName"));
                notification.setType("BOOKING_CONFIRMATION");
                Notification saved = notificationRepository.save(notification);
                System.out.println("✅ Notification saved with ID: " + saved.getId());
                
                // Send booking confirmation email directly
                System.out.println("📧 Sending booking confirmation email...");
                emailService.sendBookingConfirmationEmail(
                    user.get("email").toString(),
                    user.get("name").toString(),
                    String.valueOf(createdBooking.getId()),
                    bookingDetails.get("movieName").toString(),
                    bookingDetails.get("showTime").toString(),
                    bookingDetails.get("seatNumbers").toString(),
                    bookingDetails.get("totalAmount").toString(),
                    bookingDetails.get("venueName").toString(),
                    bookingDetails.get("movieLanguage") != null ? bookingDetails.get("movieLanguage").toString() : "N/A",
                    bookingDetails.get("movieGenre") != null ? bookingDetails.get("movieGenre").toString() : "N/A"
                );
                System.out.println("✅ Email sent successfully");
            }
        } catch (Exception e) {
            System.err.println("❌ ERROR: " + e.getMessage());
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
                "http://event-service:8082/api/shows/" + booking.getShowId(), Map.class);
            
            // Get event/movie details
            Map<String, Object> event = restTemplate.getForObject(
                "http://event-service:8082/api/events/" + show.get("eventId"), Map.class);
            
            // Get venue details
            Map<String, Object> venue = restTemplate.getForObject(
                "http://event-service:8082/api/venues/" + show.get("venueId"), Map.class);
            
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
    public ResponseEntity<List<Map<String, Object>>> getBookingsByUserId(@PathVariable Long userId) {
        List<Booking> bookings = bookingService.getBookingsByUserId(userId);
        List<Map<String, Object>> enrichedBookings = new java.util.ArrayList<>();
        
        for (Booking booking : bookings) {
            Map<String, Object> enriched = new java.util.HashMap<>();
            enriched.put("id", booking.getId());
            enriched.put("userId", booking.getUserId());
            enriched.put("showId", booking.getShowId());
            enriched.put("numberOfSeats", booking.getNumberOfSeats());
            enriched.put("seatNumbers", booking.getSeatNumbers());
            enriched.put("totalAmount", booking.getTotalAmount());
            enriched.put("status", booking.getStatus());
            enriched.put("bookingDate", booking.getBookingDate());
            enriched.put("paymentId", booking.getPaymentId());
            
            try {
                Map<String, Object> show = restTemplate.getForObject(
                    "http://event-service:8082/api/shows/" + booking.getShowId(), Map.class);
                if (show != null) {
                    Map<String, Object> event = restTemplate.getForObject(
                        "http://event-service:8082/api/events/" + show.get("eventId"), Map.class);
                    if (event != null) {
                        enriched.put("movieName", event.get("title"));
                    }
                }
            } catch (Exception e) {
                enriched.put("movieName", "Unknown");
            }
            
            enrichedBookings.add(enriched);
        }
        
        return ResponseEntity.ok(enrichedBookings);
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
                "http://event-service:8082/api/shows/" + booking.getShowId(), Map.class);
            
            Map<String, Object> event = restTemplate.getForObject(
                "http://event-service:8082/api/events/" + show.get("eventId"), Map.class);
            
            Map<String, Object> venue = restTemplate.getForObject(
                "http://event-service:8082/api/venues/" + show.get("venueId"), Map.class);
            
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
