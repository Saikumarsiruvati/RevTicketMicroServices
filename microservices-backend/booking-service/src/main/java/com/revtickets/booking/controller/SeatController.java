package com.revtickets.booking.controller;

import com.revtickets.booking.model.Seat;
import com.revtickets.booking.service.SeatService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/seats")
public class SeatController {
    @Autowired
    private SeatService seatService;

    @GetMapping("/show/{showId}")
    public ResponseEntity<List<Seat>> getSeatsByShowId(@PathVariable Long showId) {
        return ResponseEntity.ok(seatService.getSeatsByShowId(showId));
    }

    @PostMapping("/generate/{showId}/{count}")
    public ResponseEntity<List<Seat>> generateSeats(@PathVariable Long showId, @PathVariable Integer count) {
        return ResponseEntity.ok(seatService.generateSeats(showId, count));
    }
    
    @PutMapping("/regenerate/{showId}/{count}")
    public ResponseEntity<List<Seat>> regenerateSeats(@PathVariable Long showId, @PathVariable Integer count) {
        return ResponseEntity.ok(seatService.generateSeats(showId, count));
    }
}
