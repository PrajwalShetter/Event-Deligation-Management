package com.xworkz.eventDeligation.utils;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ClassPathResource;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import javax.mail.internet.MimeMessage;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Random;

@Service
public class EmailService {

    @Value("${app.base-url:http://localhost:8080/event-deligation-Management}")
    private String appBaseUrl;

    @Autowired
    private JavaMailSender javaMailSender;

    public Integer getRandomNumber(){
        Random random = new Random();
        return 100000+random.nextInt(900000);
    }

    public void sendOtpEmail(String otp, String email){
        SimpleMailMessage message = new SimpleMailMessage();
        message.setSubject("Password Reset mail");
        message.setText("Your Otp For reset password is : "+otp);
        message.setTo(email);
        javaMailSender.send(message);
    }

    public void sendCompanyRegistrationEmail(String companyName, String email) {

        try {
            MimeMessage mimeMessage = javaMailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8");
            helper.setTo(email);
            helper.setSubject("Company Registration Received");
            ClassPathResource resource =
                    new ClassPathResource("templates/company-registration-review.html");

            String template;

            try (InputStream inputStream = resource.getInputStream()) {
                template = new String(
                        org.springframework.util.StreamUtils.copyToByteArray(inputStream),
                        StandardCharsets.UTF_8
                );
            }
            template = template.replace("${companyName}", companyName);
            helper.setText(template, true);
            javaMailSender.send(mimeMessage);

        } catch (Exception exception) {
            exception.printStackTrace();
            throw new RuntimeException("Failed to send company registration email", exception);
        }
    }

    public void sendCompanyRegistrationSimpleEmail(String companyName, String email) {

        SimpleMailMessage message = new SimpleMailMessage();

        message.setTo(email);
        message.setSubject("Company Registration Received");

        message.setText(
                "Dear " + companyName + ",\n\n" +
                        "Thank you for registering with our Event Delegation Management System. " +
                        "We appreciate your interest in being part of our platform.\n\n" +
                        "Your registration details are currently under review by our team. " +
                        "We will contact you soon with the next steps.\n\n" +
                        "Regards,\n" +
                        "Event Delegation Management Team"
        );

        javaMailSender.send(message);
    }

    public void sendCompanyApprovalEmail(String companyName, String email) {

        SimpleMailMessage message = new SimpleMailMessage();

        message.setTo(email);
        message.setSubject("Company Registration Approved");

        message.setText(
                "Dear " + companyName + ",\n\n" +
                        "Your company registration request has been reviewed " +
                        "and approved by our team.\n\n" +
                        "Thank you for registering with us."
        );

        javaMailSender.send(message);
    }

    public void sendCompanyRejectionEmail(
            String companyName,
            String email,
            String rejectFeedback,
            String updateToken) {

        String updateLink = appBaseUrl
                + "/company/update?token=" + updateToken;

        SimpleMailMessage message = new SimpleMailMessage();

        message.setTo(email);
        message.setSubject("Update Required – Company Registration Review");

        message.setText(
                "Dear " + companyName + ",\n\n" +

                        "Thank you for registering with Event Delegation Management System. " +
                        "Our team has reviewed your company registration details.\n\n" +

                        "Unfortunately, we are unable to approve your registration " +
                        "at this stage due to the following observations:\n\n" +

                        "Review Feedback:\n" +
                        rejectFeedback + "\n\n" +

                        "To address these concerns, please use the secure link below " +
                        "to review and update your existing registration details:\n\n" +

                        updateLink + "\n\n" +

                        "Important Information:\n" +
                        "- This update link is valid for 48 hours from the time it is issued.\n" +
                        "- Please complete the required corrections before the link expires.\n" +
                        "- If you require additional time, please contact our support team " +
                        "by email before the link expires. Our team can review your request " +
                        "and issue a new update link.\n\n" +

                        "Please note that you do not need to register again. " +
                        "You can update your existing company registration using the link above.\n\n" +

                        "Thank you for your understanding and cooperation.\n\n" +

                        "Regards,\n" +
                        "Event Delegation Management Team"
        );

        javaMailSender.send(message);
    }

}
