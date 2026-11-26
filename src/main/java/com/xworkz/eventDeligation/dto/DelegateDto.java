package com.xworkz.eventDeligation.dto;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class DelegateDto {

    private Integer id;

    @NotBlank(message = "Delegate name is required")
    @Size(min = 3, max = 50, message = "Name must be between 3 and 50 characters")
    private String name;

    @NotBlank(message = "Email is required")
    @Email(message = "Enter a valid email")
    private String email;

    @NotBlank(message = "Contact number is required")
    @Pattern(regexp = "^[6-9][0-9]{9}$",
            message = "Enter a valid 10-digit mobile number")
    private String contactNumber;

    @NotBlank(message = "Designation is required")
    private String designation;

    @NotBlank(message = "Employment ID is required")
    private String employmentId;
}