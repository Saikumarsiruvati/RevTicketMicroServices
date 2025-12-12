package com.revtickets.auth.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailService {
    
    @Autowired(required = false)
    private JavaMailSender mailSender;
    
    @Value("${email.enabled:false}")
    private boolean emailEnabled;
    
    @Value("${spring.mail.username:noreply@revtickets.com}")
    private String fromEmail;
    
    public void sendPasswordResetEmail(String toEmail, String resetToken) {
        String resetLink = "http://localhost:4200/reset-password?token=" + resetToken;
        String emailBody = "Hello,\n\n" +
                "You have requested to reset your password for your RevTickets account.\n\n" +
                "Please click the link below to reset your password:\n" +
                resetLink + "\n\n" +
                "This link will expire in 1 hour.\n\n" +
                "If you did not request this password reset, please ignore this email.\n\n" +
                "Best regards,\n" +
                "RevTickets Team";
        
        if (!emailEnabled || mailSender == null) {
            System.out.println("\n========== EMAIL (Console Mode) ==========");
            System.out.println("To: " + toEmail);
            System.out.println("Subject: RevTickets - Password Reset Request");
            System.out.println("Body:\n" + emailBody);
            System.out.println("Reset Link: " + resetLink);
            System.out.println("==========================================\n");
            return;
        }
        
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom(fromEmail);
            message.setTo(toEmail);
            message.setSubject("RevTickets - Password Reset Request");
            message.setText(emailBody);
            mailSender.send(message);
            System.out.println("✅ Password reset email sent successfully to: " + toEmail);
        } catch (Exception e) {
            System.err.println("❌ Failed to send password reset email: " + e.getMessage());
            e.printStackTrace();
            System.out.println("\n========== EMAIL (Fallback - Console Mode) ==========");
            System.out.println("To: " + toEmail);
            System.out.println("Reset Link: " + resetLink);
            System.out.println("==========================================\n");
        }
    }
    
    public void sendBookingConfirmationEmail(String toEmail, String userName, String bookingId, 
                                            String movieName, String showTime, String seats, 
                                            String totalAmount) {
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom(fromEmail);
            message.setTo(toEmail);
            message.setSubject("RevTickets - Booking Confirmation #" + bookingId);
            
            String emailBody = "Dear " + userName + ",\n\n" +
                    "Your booking has been confirmed!\n\n" +
                    "Booking Details:\n" +
                    "Booking ID: " + bookingId + "\n" +
                    "Movie: " + movieName + "\n" +
                    "Show Time: " + showTime + "\n" +
                    "Seats: " + seats + "\n" +
                    "Total Amount: ₹" + totalAmount + "\n\n" +
                    "Please show this email or your booking ID at the venue.\n\n" +
                    "Enjoy your movie!\n\n" +
                    "Best regards,\n" +
                    "RevTickets Team";
            
            message.setText(emailBody);
            mailSender.send(message);
            System.out.println("Booking confirmation email sent to: " + toEmail);
        } catch (Exception e) {
            System.err.println("Failed to send booking confirmation email: " + e.getMessage());
        }
    }
    
    public void sendBookingCancellationEmail(String toEmail, String userName, String bookingId, 
                                            String movieName, String refundAmount) {
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom(fromEmail);
            message.setTo(toEmail);
            message.setSubject("RevTickets - Booking Cancelled #" + bookingId);
            
            String emailBody = "Dear " + userName + ",\n\n" +
                    "Your booking has been cancelled.\n\n" +
                    "Cancellation Details:\n" +
                    "Booking ID: " + bookingId + "\n" +
                    "Movie: " + movieName + "\n" +
                    "Refund Amount: ₹" + refundAmount + "\n\n" +
                    "The refund will be processed within 5-7 business days.\n\n" +
                    "If you have any questions, please contact our support team.\n\n" +
                    "Best regards,\n" +
                    "RevTickets Team";
            
            message.setText(emailBody);
            mailSender.send(message);
            System.out.println("Booking cancellation email sent to: " + toEmail);
        } catch (Exception e) {
            System.err.println("Failed to send cancellation email: " + e.getMessage());
        }
    }
}
