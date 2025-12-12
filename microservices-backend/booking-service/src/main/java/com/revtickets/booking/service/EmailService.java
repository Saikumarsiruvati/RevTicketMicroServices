package com.revtickets.booking.service;

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
    
    public void sendBookingConfirmationEmail(String toEmail, String userName, String bookingId, 
                                            String movieName, String showTime, String seats, 
                                            String totalAmount, String venueName, String language, String genre) {
        System.out.println("\n========== EMAIL SERVICE ==========");
        System.out.println("To: " + toEmail);
        System.out.println("Movie: " + movieName);
        System.out.println("Email Enabled: " + emailEnabled);
        System.out.println("Mail Sender: " + (mailSender != null ? "CONFIGURED" : "NULL"));
        System.out.println("From Email: " + fromEmail);
        
        if (!emailEnabled || mailSender == null) {
            System.out.println("⚠️ Email disabled or mail sender not configured. Skipping email.");
            System.out.println("========== EMAIL SERVICE END ==========\n");
            return;
        }
        
        String ticketLink = "http://localhost:4200/ticket/" + bookingId;
        
        String emailBody = "Dear " + userName + ",\n\n" +
                "🎉 Your movie ticket has been booked successfully!\n\n" +
                "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n" +
                "🎬 MOVIE DETAILS\n" +
                "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n" +
                "Movie Name: " + movieName + "\n" +
                "Language: " + language + "\n" +
                "Genre: " + genre + "\n" +
                "\n🎟️ VIEW DIGITAL TICKET:\n" +
                ticketLink + "\n\n" +
                "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n" +
                "🎫 BOOKING DETAILS\n" +
                "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n" +
                "Booking ID: " + bookingId + "\n" +
                "Venue: " + venueName + "\n" +
                "Show Time: " + showTime + "\n" +
                "Seats: " + seats + "\n" +
                "Total Amount: ₹" + totalAmount + "\n\n" +
                "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n" +
                "Click the ticket link above to view and download your digital ticket.\n" +
                "Please show this ticket at the venue counter.\n\n" +
                "🍿 Enjoy your movie!\n\n" +
                "Best regards,\n" +
                "RevTickets Team";
        
        if (mailSender == null) {
            System.err.println("❌ CRITICAL: Mail sender is NULL! Check application.properties and dependencies.");
            return;
        }
        
        try {
            System.out.println("Creating email message...");
            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom(fromEmail);
            message.setTo(toEmail);
            message.setSubject("🎬 Booking Confirmed - " + movieName + " | RevTickets");
            message.setText(emailBody);
            
            System.out.println("Sending email via SMTP...");
            mailSender.send(message);
            System.out.println("✅✅✅ EMAIL SENT SUCCESSFULLY to: " + toEmail + " ✅✅✅");
        } catch (Exception e) {
            System.err.println("❌❌❌ EMAIL FAILED: " + e.getMessage());
            e.printStackTrace();
        }
        System.out.println("========== EMAIL SERVICE END ==========\n");
    }
    
    public void sendBookingCancellationEmail(String toEmail, String userName, String bookingId, 
                                            String movieName, String refundAmount, String showTime, 
                                            String seats, String venueName) {
        System.out.println("\n========== CANCELLATION EMAIL SERVICE ==========");
        System.out.println("To: " + toEmail);
        System.out.println("Movie: " + movieName);
        
        if (!emailEnabled || mailSender == null) {
            System.out.println("⚠️ Email disabled or mail sender not configured. Skipping email.");
            System.out.println("========== CANCELLATION EMAIL END ==========\n");
            return;
        }
        
        String emailBody = "Dear " + userName + ",\n\n" +
                "❌ Your movie booking has been cancelled.\n\n" +
                "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n" +
                "📋 CANCELLED BOOKING DETAILS\n" +
                "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n" +
                "Booking ID: " + bookingId + "\n" +
                "Movie: " + movieName + "\n" +
                "Venue: " + venueName + "\n" +
                "Show Time: " + showTime + "\n" +
                "Seats: " + seats + "\n" +
                "Refund Amount: ₹" + refundAmount + "\n\n" +
                "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n" +
                "💰 REFUND INFORMATION:\n" +
                "The refund will be processed within 5-7 business days.\n" +
                "Amount will be credited to your original payment method.\n\n" +
                "If you have any questions, please contact our support team.\n\n" +
                "Best regards,\n" +
                "RevTickets Team";
        
        if (mailSender == null) {
            System.err.println("❌ CRITICAL: Mail sender is NULL!");
            return;
        }
        
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom(fromEmail);
            message.setTo(toEmail);
            message.setSubject("❌ Booking Cancelled - " + movieName + " | RevTickets");
            message.setText(emailBody);
            mailSender.send(message);
            System.out.println("✅✅✅ CANCELLATION EMAIL SENT to: " + toEmail + " ✅✅✅");
        } catch (Exception e) {
            System.err.println("❌ Failed to send cancellation email: " + e.getMessage());
            e.printStackTrace();
        }
        System.out.println("========== CANCELLATION EMAIL END ==========\n");
    }
}
