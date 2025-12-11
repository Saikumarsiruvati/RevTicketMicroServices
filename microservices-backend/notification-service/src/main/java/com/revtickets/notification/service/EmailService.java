package com.revtickets.notification.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import jakarta.mail.internet.MimeMessage;

@Service
public class EmailService {
    @Autowired
    private JavaMailSender mailSender;

    public void sendBookingConfirmation(String to, String userName, String movieName, 
                                       String venue, String showTime, int seats, 
                                       double amount, String bookingId) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
            
            helper.setTo(to);
            helper.setSubject("Booking Confirmed - " + movieName);
            
            String ticketLink = "http://localhost:4200/my-bookings/" + bookingId;
            
            String htmlContent = "<html>" +
                "<body style='font-family: Arial, sans-serif; padding: 20px; background-color: #f9f9f9;'>" +
                "<div style='max-width: 600px; margin: 0 auto; background: white; border-radius: 10px; overflow: hidden; box-shadow: 0 2px 10px rgba(0,0,0,0.1);'>" +
                "<div style='background: linear-gradient(135deg, #f84464 0%, #e63946 100%); padding: 30px; text-align: center;'>" +
                "<h1 style='color: white; margin: 0; font-size: 28px;'>🎬 Booking Confirmed!</h1>" +
                "</div>" +
                "<div style='padding: 30px;'>" +
                "<p style='font-size: 16px; color: #333;'>Dear <strong>" + userName + "</strong>,</p>" +
                "<p style='font-size: 16px; color: #333;'>Your movie ticket has been booked successfully! 🎉</p>" +
                "<div style='background: #f8f9fa; padding: 25px; border-radius: 8px; margin: 25px 0; border-left: 4px solid #f84464;'>" +
                "<h2 style='margin-top: 0; color: #f84464; font-size: 22px;'>" + movieName + "</h2>" +
                "<table style='width: 100%; border-collapse: collapse;'>" +
                "<tr><td style='padding: 8px 0; color: #666;'><strong>🎭 Venue:</strong></td><td style='padding: 8px 0; color: #333;'>" + venue + "</td></tr>" +
                "<tr><td style='padding: 8px 0; color: #666;'><strong>🕐 Show Time:</strong></td><td style='padding: 8px 0; color: #333;'>" + showTime + "</td></tr>" +
                "<tr><td style='padding: 8px 0; color: #666;'><strong>💺 Seats:</strong></td><td style='padding: 8px 0; color: #333;'>" + seats + "</td></tr>" +
                "<tr><td style='padding: 8px 0; color: #666;'><strong>💰 Total Amount:</strong></td><td style='padding: 8px 0; color: #333; font-size: 18px; font-weight: bold;'>₹" + String.format("%.2f", amount) + "</td></tr>" +
                "<tr><td style='padding: 8px 0; color: #666;'><strong>🎫 Booking ID:</strong></td><td style='padding: 8px 0; color: #333; font-family: monospace;'>" + bookingId + "</td></tr>" +
                "</table>" +
                "</div>" +
                "<div style='text-align: center; margin: 30px 0;'>" +
                "<a href='" + ticketLink + "' style='display: inline-block; background: linear-gradient(135deg, #f84464 0%, #e63946 100%); color: white; padding: 15px 40px; text-decoration: none; border-radius: 25px; font-size: 16px; font-weight: bold; box-shadow: 0 4px 15px rgba(248, 68, 100, 0.3);'>" +
                "🎟️ View Your Ticket" +
                "</a>" +
                "</div>" +
                "<p style='font-size: 14px; color: #999; text-align: center; margin-top: 30px; padding-top: 20px; border-top: 1px solid #eee;'>" +
                "Thank you for choosing RevTickets! Enjoy your movie! 🍿" +
                "</p>" +
                "</div>" +
                "</div>" +
                "</body>" +
                "</html>";
            
            helper.setText(htmlContent, true);
            mailSender.send(message);
        } catch (Exception e) {
            throw new RuntimeException("Failed to send email: " + e.getMessage());
        }
    }
}
