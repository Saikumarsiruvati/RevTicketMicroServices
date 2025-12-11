package com.revtickets.booking.service;

import com.revtickets.booking.model.Seat;
import com.revtickets.booking.repository.SeatRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class SeatService {
    @Autowired
    private SeatRepository seatRepository;

    public List<Seat> getSeatsByShowId(Long showId) {
        return seatRepository.findByShowId(showId);
    }

    @org.springframework.transaction.annotation.Transactional
    public List<Seat> generateSeats(Long showId, Integer count) {
        seatRepository.deleteByShowId(showId);
        List<Seat> seats = new java.util.ArrayList<>();
        
        String[] rows = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O"};
        int seatsPerRow = (int) Math.ceil((double) count / rows.length);
        int seatCount = 0;
        
        for (String row : rows) {
            String category;
            Double price;
            
            // Rows A, B: Regular
            if (row.equals("A") || row.equals("B")) {
                category = "Regular";
                price = 150.0;
            }
            // Rows C-H: Silver
            else if (row.compareTo("C") >= 0 && row.compareTo("H") <= 0) {
                category = "Silver";
                price = 200.0;
            }
            // Rows I-M: Gold
            else if (row.compareTo("I") >= 0 && row.compareTo("M") <= 0) {
                category = "Gold";
                price = 250.0;
            }
            // Rows N, O: Premium
            else {
                category = "Premium";
                price = 300.0;
            }
            
            for (int i = 1; i <= seatsPerRow && seatCount < count; i++) {
                Seat seat = new Seat();
                seat.setShowId(showId);
                seat.setSeatNumber(row + i);
                seat.setSeatType(category);
                seat.setPrice(price);
                seat.setIsBooked(false);
                seat.setStatus("AVAILABLE");
                seats.add(seat);
                seatCount++;
            }
        }
        
        return seatRepository.saveAll(seats);
    }
}
