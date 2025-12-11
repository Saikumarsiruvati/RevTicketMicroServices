package com.revtickets.booking.model;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "seats")
@Data
public class Seat {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(name = "show_id", nullable = false)
    private Long showId;
    
    @Column(name = "seat_number", nullable = false)
    private String seatNumber;
    
    @Column(name = "seat_type", nullable = false)
    private String seatType = "Regular";
    
    private Double price = 200.0;
    
    @Column(name = "is_booked", nullable = false)
    private Boolean isBooked = false;
    
    @Column(name = "booking_id")
    private Long bookingId;
    
    @Column(nullable = false)
    private String status = "AVAILABLE";
}
