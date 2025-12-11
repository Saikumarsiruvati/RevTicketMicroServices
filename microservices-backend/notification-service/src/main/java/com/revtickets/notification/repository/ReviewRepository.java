package com.revtickets.notification.repository;

import com.revtickets.notification.model.Review;
import org.springframework.data.mongodb.repository.MongoRepository;
import java.util.List;

public interface ReviewRepository extends MongoRepository<Review, String> {
    List<Review> findByEventId(Long eventId);
}
