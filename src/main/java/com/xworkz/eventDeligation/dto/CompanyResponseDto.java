package com.xworkz.eventDeligation.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CompanyResponseDto {

    private Integer id;

    private String companyName;

    private String email;

    private String contactNumber;

    private String employeeSize;

    private String gstinNumber;

    private String address;

    private String country;

    private String state;

    private String city;

    private String pincode;

    private String mapLink;

    private String logoName;

    private String reviewStatus;
}
