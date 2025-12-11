package com.revtickets.event.repository;

import com.revtickets.event.model.Event;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import java.util.List;

public interface EventRepository extends JpaRepository<Event, Long> {
    List<Event> findByIsActiveTrue();
    
    @Query("SELECT e FROM Event e WHERE UPPER(e.category) = UPPER(:category) AND e.isActive = true")
    List<Event> findByCategoryAndIsActiveTrue(@Param("category") String category);
    
    List<Event> findByCity(String city);
}
