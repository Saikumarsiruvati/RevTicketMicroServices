package com.revtickets.booking.service;

import com.revtickets.booking.model.Booking;
import com.revtickets.booking.model.Seat;
import com.revtickets.booking.repository.BookingRepository;
import com.revtickets.booking.repository.SeatRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
public class BookingService {
    @Autowired
    private BookingRepository bookingRepository;
    
    @Autowired
    private SeatRepository seatRepository;

    public List<Booking> getAllBookings() {
        return bookingRepository.findAll();
    }

    @Transactional
    public Booking createBooking(Booking booking) {
        Booking savedBooking = bookingRepository.save(booking);
        
        // Mark seats as booked
        String[] seatNumbers = booking.getSeatNumbers().split(",");
        for (String seatNum : seatNumbers) {
            List<Seat> seats = seatRepository.findByShowId(booking.getShowId());
            for (Seat seat : seats) {
                if (seat.getSeatNumber().trim().equals(seatNum.trim())) {
                    seat.setIsBooked(true);
                    seat.setBookingId(savedBooking.getId());
                    seat.setStatus("BOOKED");
                    seatRepository.save(seat);
                    break;
                }
            }
        }
        
        return savedBooking;
    }

    public Booking getBookingById(Long id) {
        return bookingRepository.findById(id).orElseThrow(() -> new RuntimeException("Booking not found"));
    }

    public List<Booking> getBookingsByUserId(Long userId) {
        return bookingRepository.findByUserId(userId);
    }

    public Booking confirmBooking(Long id, String paymentId) {
        Booking booking = getBookingById(id);
        booking.setStatus(Booking.BookingStatus.CONFIRMED);
        booking.setPaymentId(paymentId);
        return bookingRepository.save(booking);
    }

    @Transactional
    public void cancelBooking(Long id) {
        Booking booking = getBookingById(id);
        booking.setStatus(Booking.BookingStatus.CANCELLED);
        bookingRepository.save(booking);
        
        // Release seats
        List<Seat> seats = seatRepository.findByShowId(booking.getShowId());
        for (Seat seat : seats) {
            if (seat.getBookingId() != null && seat.getBookingId().equals(id)) {
                seat.setIsBooked(false);
                seat.setBookingId(null);
                seat.setStatus("AVAILABLE");
                seatRepository.save(seat);
            }
        }
    }

    public void deleteBooking(Long id) {
        bookingRepository.deleteById(id);
    }
}
