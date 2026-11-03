package com.xworkz.eventDeligation.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.constraints.*;

@Data
@NoArgsConstructor
@AllArgsConstructor

public class CompanyRegistrationDto  {


        @NotBlank(message = "Company name is required")
        @Size(min = 2, max = 30,
                message = "Company name must be between 2 and 30 characters")
        private String companyName;

        @NotBlank(message = "Email is required")
        @Email(message = "Enter a valid email address")
        @Size(max = 30, message = "Email cannot exceed 30 characters")
        private String email;

        @NotBlank(message = "Contact number is required")
        @Pattern(regexp = "^[6-9][0-9]{9}$",
                message = "Contact number must contain exactly 10 digits")
        private String contactNumber;

        @NotBlank(message = "Employee size is required")
        @Pattern(regexp = "^[0-9]+-[0-9]+$",
                message = "Employee size must be in range format, e.g. 10-15")
        private String employeeSize;

        // GSTIN validation can be adjusted later for country-specific rules.
        @NotBlank(message = "GSTIN is required")
        @Pattern(
                regexp = "^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z][1-9A-Z]Z[0-9A-Z]$",
                message = "Enter a valid GSTIN format"
        )
        private String gstinNumber;

        @NotBlank(message = "Address is required")
        @Size(max = 250, message = "Address cannot exceed 250 characters")
        private String address;

        @NotBlank(message = "Country is required")
        @Size(max = 30, message = "Country cannot exceed 30 characters")
        private String country;

        @NotBlank(message = "State is required")
        @Size(max = 30, message = "State cannot exceed 30 characters")
        private String state;

        @NotBlank(message = "City is required")
        @Size(max = 30, message = "City cannot exceed 30 characters")
        private String city;

        @NotBlank(message = "Pincode is required")
        @Pattern(regexp = "^[0-9]{6}$",
                message = "Pincode must contain exactly 6 numeric digits")
        private String pincode;

        @NotBlank(message = "Google Maps link is required")
        @Pattern(
                regexp = "^https?://(www\\.)?(google\\.[a-z.]+/maps/.*|maps\\.app\\.goo\\.gl/.*)$",
                message = "Please enter a valid Google Maps link"
        )
        @Size(max = 2000, message = "Map link cannot exceed 2000 characters")
        private String mapLink;

        @NotNull(message = "Company logo is required")
        private MultipartFile logo;


    }


