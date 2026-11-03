package com.xworkz.eventDeligation.service;

import com.xworkz.eventDeligation.dto.AdminLoginDto;

public interface AdminLoginService {

     String saveAdminLogin(AdminLoginDto loginDto);
     String passwordMatch(String email,String password);
    String sendOtp(String email);
    String verifyOtp(String email, String otp);
    String resetNewPassword(String email, String password, String confirmPassword);

}
