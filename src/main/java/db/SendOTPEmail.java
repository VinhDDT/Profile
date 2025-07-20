/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package db;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;

/**
 *
 * @author Kiều Hoàng Mạnh Khang - ce180749
 */
public class SendOTPEmail {
     public static void send(String toEmail, String otp) {
        final String fromEmail = "prokhang66@gmail.com"; // Email của bạn
        final String appPassword = "xtqoxbwttfcxwqgt"; // Mật khẩu ứng dụng Gmail

        // Thiết lập thông số SMTP
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        // Tạo phiên gửi mail có xác thực
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, appPassword);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail));
            message.setRecipients(
                    Message.RecipientType.TO,
                    InternetAddress.parse(toEmail)
            );
            message.setSubject("Xác thực đăng ký tài khoản");
            message.setText("Mã OTP của bạn là: " + otp);

            Transport.send(message);
            System.out.println("✅ Gửi mail OTP thành công!");

        } catch (MessagingException e) {
            e.printStackTrace();
            System.out.println("❌ Gửi mail OTP thất bại.");
        }
    }
}
