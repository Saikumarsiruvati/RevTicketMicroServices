package com.revtickets.payment.service;

import com.revtickets.payment.model.Payment;
import com.revtickets.payment.repository.PaymentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.UUID;

@Service
public class PaymentService {
    @Autowired
    private PaymentRepository paymentRepository;

    public Payment processPayment(Payment payment) {
        payment.setPaymentId("PAY-" + UUID.randomUUID().toString());
        payment.setStatus(Payment.PaymentStatus.SUCCESS);
        return paymentRepository.save(payment);
    }

    public Payment getPaymentById(String paymentId) {
        return paymentRepository.findByPaymentId(paymentId)
                .orElseThrow(() -> new RuntimeException("Payment not found"));
    }

    public Payment getPaymentByBookingId(Long bookingId) {
        return paymentRepository.findByBookingId(bookingId)
                .orElseThrow(() -> new RuntimeException("Payment not found"));
    }
}
