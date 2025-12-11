package com.revtickets.event.controller;

import com.revtickets.event.dto.ShowRequest;
import com.revtickets.event.model.Show;
import com.revtickets.event.repository.ShowRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@RestController
@RequestMapping("/api/shows")
public class ShowController {
    @Autowired
    private ShowRepository showRepository;

    @GetMapping
    public ResponseEntity<List<Show>> getAllShows() {
        return ResponseEntity.ok(showRepository.findAll());
    }

    @GetMapping("/{id}")
    public ResponseEntity<Show> getShowById(@PathVariable Long id) {
        return ResponseEntity.ok(showRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Show not found")));
    }

    @GetMapping("/event/{eventId}")
    public ResponseEntity<List<Show>> getShowsByEventId(@PathVariable Long eventId) {
        return ResponseEntity.ok(showRepository.findByEventId(eventId));
    }

    @PostMapping
    public ResponseEntity<Show> createShow(@RequestBody ShowRequest request) {
        try {
            if (request.getEventId() == null) {
                throw new RuntimeException("Event ID is required");
            }
            if (request.getVenueId() == null) {
                throw new RuntimeException("Venue ID is required");
            }
            if (request.getShowTime() == null || request.getShowTime().isEmpty()) {
                throw new RuntimeException("Show time is required");
            }
            
            Show show = new Show();
            show.setEventId(request.getEventId());
            show.setVenueId(request.getVenueId());
            show.setShowTime(LocalDateTime.parse(request.getShowTime()));
            show.setAvailableSeats(request.getAvailableSeats());
            show.setIsActive(request.getIsActive() != null ? request.getIsActive() : true);
            
            return ResponseEntity.ok(showRepository.save(show));
        } catch (Exception e) {
            throw new RuntimeException("Failed to create show: " + e.getMessage());
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteShow(@PathVariable Long id) {
        showRepository.deleteById(id);
        return ResponseEntity.ok().build();
    }
}
