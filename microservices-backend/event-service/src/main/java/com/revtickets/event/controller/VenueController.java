package com.revtickets.event.controller;

import com.revtickets.event.model.Venue;
import com.revtickets.event.repository.VenueRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/venues")
public class VenueController {
    @Autowired
    private VenueRepository venueRepository;

    @GetMapping
    public ResponseEntity<List<Venue>> getAllVenues() {
        return ResponseEntity.ok(venueRepository.findAll());
    }

    @GetMapping("/{id}")
    public ResponseEntity<Venue> getVenueById(@PathVariable Long id) {
        return ResponseEntity.ok(venueRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Venue not found")));
    }

    @PostMapping
    public ResponseEntity<Venue> createVenue(@RequestBody Venue venue) {
        if (venue.getIsActive() == null) {
            venue.setIsActive(true);
        }
        return ResponseEntity.ok(venueRepository.save(venue));
    }

    @PutMapping("/{id}")
    public ResponseEntity<Venue> updateVenue(@PathVariable Long id, @RequestBody Venue venue) {
        Venue existing = venueRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Venue not found"));
        existing.setName(venue.getName());
        existing.setCity(venue.getCity());
        existing.setAddress(venue.getAddress());
        existing.setTotalSeats(venue.getTotalSeats());
        existing.setType(venue.getType());
        return ResponseEntity.ok(venueRepository.save(existing));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteVenue(@PathVariable Long id) {
        venueRepository.deleteById(id);
        return ResponseEntity.ok().build();
    }
}
