package com.xworkz.eventDeligation.dto;

import com.xworkz.eventDeligation.constants.Gender;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.constraints.*;


@Data
@AllArgsConstructor
@NoArgsConstructor

public class AdminDto {

    private Integer id;

    @NotBlank(message = "Email should not be blank")
    @Email(message = "Please enter a valid email address")
    private String email;

    @NotBlank(message = "First name should not be blank")
    @Size(min = 3, max = 20,
            message = "First name must contain 3 to 20 characters")
    private String firstName;

    @NotBlank(message = "Last name should not be blank")
    @Size(min = 1, max = 20,
            message = "Last name must contain 1 to 20 characters")
    private String lastname;

    @NotBlank(message = "Phone number should not be blank")
    @Pattern(regexp = "^[6-9][0-9]{9}$",
            message = "Enter a valid 10-digit Indian mobile number")
    private String phone;

    @NotNull(message = "Please select a gender")
    private Gender gender;

    @NotNull(message = "Age is required")
    @Min(value = 18, message = "Minimum age is 18")
    @Max(value = 100, message = "Maximum age is 100")
    private Integer age;

    @NotBlank(message = "Password should not be blank")
    @Size(min = 8, max = 20, message = "Password must contain 8 to 20 characters")
    @Pattern(regexp = "^(?=.*[A-Z])(?=.*[^a-zA-Z0-9]).{8,20}$",
            message = "Password must contain at least one uppercase letter and one symbol")
    private String password;

    private String confirmPassword; // we need this for backed validation but dont need to save in bd
    private String otp;
    private Boolean status;
    private Integer count;

    private String picName;
    private MultipartFile profilePicFile;

}
