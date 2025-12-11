package com.revtickets.event.service;

import com.revtickets.event.model.Event;
import com.revtickets.event.repository.EventRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class EventService {
    @Autowired
    private EventRepository eventRepository;

    public List<Event> getAllEvents() {
        return eventRepository.findByIsActiveTrue();
    }

    public List<Event> getEventsByCategory(String category) {
        return eventRepository.findByCategoryAndIsActiveTrue(category);
    }

    public Event getEventById(Long id) {
        return eventRepository.findById(id).orElseThrow(() -> new RuntimeException("Event not found"));
    }

    public Event createEvent(Event event) {
        return eventRepository.save(event);
    }

    public Event updateEvent(Long id, Event eventDetails) {
        Event event = getEventById(id);
        event.setTitle(eventDetails.getTitle());
        event.setCategory(eventDetails.getCategory());
        event.setDescription(eventDetails.getDescription());
        event.setCity(eventDetails.getCity());
        event.setPrice(eventDetails.getPrice());
        return eventRepository.save(event);
    }

    public void deleteEvent(Long id) {
        Event event = getEventById(id);
        event.setIsActive(false);
        eventRepository.save(event);
    }
}
