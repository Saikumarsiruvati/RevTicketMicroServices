package com.revtickets.review.controller;

import com.revtickets.review.model.Review;
import com.revtickets.review.service.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/reviews")
public class ReviewController {
    @Autowired
    private ReviewService reviewService;
    
    @Autowired
    private RestTemplate restTemplate;

    @PostMapping
    public ResponseEntity<Review> createReview(@RequestBody Review review) {
        try {
            // Fetch user name
            Map<String, Object> user = restTemplate.getForObject(
                "http://localhost:8081/api/users/" + review.getUserId(), Map.class);
            if (user != null) {
                review.setUserName((String) user.get("name"));
            }
            
            // Fetch movie name
            Map<String, Object> event = restTemplate.getForObject(
                "http://localhost:8082/api/events/" + review.getEventId(), Map.class);
            if (event != null) {
                review.setMovieName((String) event.get("title"));
            }
        } catch (Exception e) {
            System.err.println("Error fetching user/movie details: " + e.getMessage());
        }
        
        return ResponseEntity.ok(reviewService.createReview(review));
    }

    @GetMapping("/event/{eventId}")
    public ResponseEntity<List<Review>> getReviewsByEventId(@PathVariable Long eventId) {
        return ResponseEntity.ok(reviewService.getReviewsByEventId(eventId));
    }

    @GetMapping("/user/{userId}")
    public ResponseEntity<List<Review>> getReviewsByUserId(@PathVariable Long userId) {
        return ResponseEntity.ok(reviewService.getReviewsByUserId(userId));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteReview(@PathVariable String id) {
        reviewService.deleteReview(id);
        return ResponseEntity.ok().build();
    }
}
