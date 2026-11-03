package com.xworkz.eventDeligation.dto;

import com.xworkz.eventDeligation.constants.Gender;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.*;

@Data
@NoArgsConstructor
@AllArgsConstructor

public class AdminEditProfileDto {

    @NotBlank(message = "First name is required")
    @Size(min = 3,max=20, message = "First name must contain at least 4 characters")
    private String firstName;

    @NotBlank(message = "Last name is required")
    @Size(min = 1,max=20, message = "Last name must contain at least 1 characters")
    private String lastname;

    @NotBlank(message = "Email is required")
    @Email(message = "Enter a valid email address")
    private String email;

    @NotBlank(message = "Phone number is required")
    @Pattern(regexp = "^[6-9][0-9]{9}$",
            message = "Enter a valid 10-digit Indian mobile number")
    private String phone;

    @NotNull(message = "Gender is required")
    private Gender gender;

    @NotNull(message = "Age is required")
    @Min(value = 18, message = "Minimum age is 18")
    @Max(value = 100, message = "Maximum age is 100")
    private Integer age;
}
