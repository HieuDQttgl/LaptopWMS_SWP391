package Utils;

import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class SendMail {

    // Email configuration
    private static final String FROM_EMAIL = "phamquangtien1810@gmail.com";
    private static final String APP_PASSWORD = "ixiy wzlr rqru qhkg";

    /**
     * Send an email
     *
     * @param to Recipient email address
     * @param subject Email subject
     * @param content Email body content
     * @return true if email sent successfully, false otherwise
     */
    public static boolean send(String to, String subject, String content) {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props,
                new javax.mail.Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, APP_PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject(subject);
            message.setContent(content, "text/html; charset=utf-8");

            Transport.send(message);
            System.out.println("Email sent successfully to: " + to);
            return true;

        } catch (MessagingException e) {
            System.err.println("Failed to send email to: " + to);
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Send password reset email to user
     *
     * @param to Recipient email
     * @param username User's username
     * @param newPassword The new password
     * @return true if sent successfully
     */
    public static boolean sendPasswordResetEmail(String to, String username, String newPassword) {
        String subject = "Your Password Has Been Reset - Laptop WMS";

        String content = "<!DOCTYPE html>"
                + "<html>"
                + "<head><style>"
                + "body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }"
                + ".container { max-width: 600px; margin: 0 auto; padding: 20px; }"
                + ".header { background: #2563eb; color: white; padding: 20px; text-align: center; border-radius: 8px 8px 0 0; }"
                + ".body { background: #f8fafc; padding: 30px; border: 1px solid #e2e8f0; }"
                + ".password-box { background: #fff; border: 2px dashed #2563eb; padding: 15px; text-align: center; margin: 20px 0; border-radius: 8px; }"
                + ".password { font-size: 24px; font-weight: bold; color: #2563eb; letter-spacing: 2px; }"
                + ".footer { background: #1e293b; color: #94a3b8; padding: 15px; text-align: center; font-size: 12px; border-radius: 0 0 8px 8px; }"
                + ".warning { background: #fef3c7; border-left: 4px solid #f59e0b; padding: 10px 15px; margin: 15px 0; }"
                + "</style></head>"
                + "<body>"
                + "<div class='container'>"
                + "<div class='header'><h1>Password Reset</h1></div>"
                + "<div class='body'>"
                + "<p>Hello <strong>" + username + "</strong>,</p>"
                + "<p>Your password has been reset by an administrator. Here is your new temporary password:</p>"
                + "<div class='password-box'><span class='password'>" + newPassword + "</span></div>"
                + "<div class='warning'>"
                + "<strong>Important:</strong> For security reasons, please change this password immediately after logging in."
                + "</div>"
                + "<p>If you did not request this password reset, please contact the system administrator immediately.</p>"
                + "</div>"
                + "<div class='footer'>"
                + "<p>2025 Warehouse Management System</p>"
                + "<p>This is an automated message. Please do not reply.</p>"
                + "</div>"
                + "</div>"
                + "</body></html>";

        return send(to, subject, content);
    }
}
