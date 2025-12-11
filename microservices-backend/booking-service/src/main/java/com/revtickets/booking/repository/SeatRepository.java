package com.revtickets.booking.repository;

import com.revtickets.booking.model.Seat;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface SeatRepository extends JpaRepository<Seat, Long> {
    List<Seat> findByShowId(Long showId);
    void deleteByShowId(Long showId);
}
