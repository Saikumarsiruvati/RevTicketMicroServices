package com.revtickets.review.repository;

import com.revtickets.review.model.Review;
import org.springframework.data.mongodb.repository.MongoRepository;
import java.util.List;

public interface ReviewRepository extends MongoRepository<Review, String> {
    List<Review> findByEventId(Long eventId);
    List<Review> findByUserId(Long userId);
}
