package com.xworkz.eventDeligation.service.impl;

import com.xworkz.eventDeligation.dto.AdminDto;
import com.xworkz.eventDeligation.dto.AdminLoginDto;
import com.xworkz.eventDeligation.entity.AdminEntity;
import com.xworkz.eventDeligation.entity.AdminLoginEntity;
import com.xworkz.eventDeligation.repository.AdminLoginRepo;
import com.xworkz.eventDeligation.repository.AdminRepo;
import com.xworkz.eventDeligation.service.AdminLoginService;
import com.xworkz.eventDeligation.service.AdminService;
import com.xworkz.eventDeligation.utils.EmailService;
import lombok.NonNull;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import javax.validation.Valid;

@Service
public class AdminLoginServiceImpl implements AdminLoginService {

    @Autowired
    AdminLoginRepo adminLoginRepo;
    @Autowired
    AdminService adminService;
    @Autowired
    PasswordEncoder passwordEncoder;
    @Autowired
    AdminRepo adminRepo;
    @Autowired
    EmailService emailService;

    @Override
    public String saveAdminLogin(AdminLoginDto loginDto) {
        String result = passwordMatch(loginDto.getEmail(), loginDto.getPassword());
        if(result.equalsIgnoreCase("Password matched")){
            AdminEntity admin = adminRepo.findByEmail(loginDto.getEmail());

            if (admin == null) {
                return "Admin account not found";
            }

            AdminLoginEntity loginEntity = new AdminLoginEntity();
            loginEntity.setAdmin(admin);
            loginEntity.setDate(
                    loginDto.getDate() != null
                            ? loginDto.getDate()
                            : java.time.LocalDate.now()
            );

            loginEntity.setTime(
                    loginDto.getTime() != null
                            ? loginDto.getTime()
                            : java.time.LocalTime.now()
            );
            BeanUtils.copyProperties(loginDto,loginEntity);
            boolean save = adminLoginRepo.saveAdminLogin(loginEntity);
            if(save){
                return "Login saved successfully";
            }else {
                return "Login not saved";
            }
        }
        return result;
    }

    @Override
    public String passwordMatch(String email, String password){
        if(email == null && password == null){
            return "email and password should not be null";
        }
        AdminDto adminDto = adminService.findByEmail(email);
        if(adminDto == null){
            return "Email does not exist";
        }
        if(Boolean.FALSE.equals(adminDto.getStatus())){
            return "Account is blocked. please reset your password";
        }
        if(passwordEncoder.matches(password,adminDto.getPassword())){
                if(adminDto.getCount() != null && adminDto.getCount()>0){
                    adminDto.setCount(0);

                    boolean update = adminService.updateAdmin(adminDto);
                    if(!update){
                        return "Unable to update the account";
                    }
                }
                return "Password matched";
        }
        else {
            int count;

            if(adminDto.getCount()== null){
                count= 0;
            }else {
                count = adminDto.getCount();
            }
            if(count<3){
                count++;
            }
                adminDto.setCount(count);
                if(count>=3){
                    adminDto.setStatus(false);
                }
                boolean update = adminService.updateAdmin(adminDto);
                if(!update){
                    return "Unable to update the account";
                }
                if(count>=3){
                    return "Account is blocked. please reset your password";
                }
                return "Password is incorrect. Attempts remaining :"+(3-count);

        }
    }

    @Override
    public String sendOtp(String email) {
        AdminDto adminDto = adminService.findByEmail(email);

        if(adminDto == null){
            return "email  not found";
        }

        Integer randomNumber = emailService.getRandomNumber();
        String otp =  String.valueOf(randomNumber);
        String encodeOtp = passwordEncoder.encode(otp);
        adminDto.setOtp(encodeOtp);
        boolean update = adminService.updateAdmin(adminDto);
        if(!update){
            return "Unable to update";
        }
        emailService.sendOtpEmail(otp,adminDto.getEmail());
        return "otp sent successfully";
    }


    @Override
    public String verifyOtp(String email, String otp) {
        AdminEntity admin = adminRepo.findByEmail(email);

        if(admin ==null){
            return "email not found";
        }
        if (admin.getOtp() == null) {
            return "OTP not found. Please request a new OTP";
        }

        if(passwordEncoder.matches(otp, admin.getOtp())){
            return "OTP Matched";
        }
        return "Wrong OTP";
    }

    @Override
    public String resetNewPassword(String email, String password, String ConfirmPassword) {
        AdminDto adminDto = adminService.findByEmail(email);
        if(adminDto == null){
            return "Email not Exist";
        }
        if (password == null || password.trim().isEmpty()) {
            return "Password cannot be empty";
        }

        if (!password.matches("^(?=.*[A-Z])(?=.*[^a-zA-Z0-9]).{8,20}$")) {
            return "Password must contain 8–20 characters, "
                    + "1 uppercase letter and 1 symbol.";
        }
        if (!password.equals(ConfirmPassword)) {
            return "Passwords do not match.";
        }
        adminDto.setPassword(passwordEncoder.encode(password));
        adminDto.setStatus(true);
        adminDto.setCount(0);
        adminDto.setOtp(null);

        boolean update = adminService.updateAdmin(adminDto);

        if (!update) {
            return "Unable to update password";
        }

        return "Password Updated";
    }
}
