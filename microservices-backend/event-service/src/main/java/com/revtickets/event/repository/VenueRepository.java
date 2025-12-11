package com.revtickets.event.repository;

import com.revtickets.event.model.Venue;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface VenueRepository extends JpaRepository<Venue, Long> {
    List<Venue> findByCity(String city);
}
