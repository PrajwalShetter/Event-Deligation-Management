
package com.xworkz.eventDeligation.entity;

import com.xworkz.eventDeligation.constants.CompanyReviewStatus;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "company_table",
        uniqueConstraints = {@UniqueConstraint(name = "uk_company_email", columnNames = "email"),
                @UniqueConstraint(name = "uk_company_contact", columnNames = "contact_number"),
                @UniqueConstraint(name = "uk_company_gstin", columnNames = "gstin_number")
        }
)
public class CompanyEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "company_name", nullable = false, length = 30)
    private String companyName;

    @Column(name = "email", nullable = false, length = 30)
    private String email;

    @Column(name = "contact_number", nullable = false, length = 10)
    private String contactNumber;

    @Column(name = "employee_size", nullable = false, length = 20)
    private String employeeSize;

    @Column(name = "gstin_number", nullable = false, length = 15)
    private String gstinNumber;

    @Column(name = "address", nullable = false, length = 250)
    private String address;

    @Column(name = "country", nullable = false, length = 30)
    private String country;

    @Column(name = "state", nullable = false, length = 30)
    private String state;

    @Column(name = "city", nullable = false, length = 30)
    private String city;

    @Column(name = "pincode", nullable = false, length = 6)
    private String pincode;

    @Column(name = "map_link", nullable = false, length = 2000)
    private String mapLink;

    // Store the filename only, not the image bytes.
    @Column(name = "logo_name", nullable = false, length = 50)
    private String logoName;

    @Enumerated(EnumType.STRING)
    @Column(name = "review_status", nullable = false, length = 30)
    private CompanyReviewStatus reviewStatus;

    @Column(name = "otp", length = 6)
    private String otp;

    @Column(name = "otp_expiry_time")
    private java.time.LocalDateTime otpExpiryTime;

    @Column(name = "reject_feedback", length = 1000)
    private String rejectFeedback;

    @Column(name = "update_token", length = 64, unique = true)
    private String updateToken;

    @Column(name = "update_token_expiry")
    private LocalDateTime updateTokenExpiry;

    @Column(name = "otp_attempts")
    private Integer otpAttempts = 0;
}
