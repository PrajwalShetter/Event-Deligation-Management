package com.xworkz.eventDeligation.service.impl;

import com.xworkz.eventDeligation.dto.AdminDto;
import com.xworkz.eventDeligation.dto.AdminEditProfileDto;
import com.xworkz.eventDeligation.entity.AdminEntity;
import com.xworkz.eventDeligation.repository.AdminRepo;
import com.xworkz.eventDeligation.service.AdminService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;

@Service
public class AdminServiceImpl implements AdminService {

    @Autowired
    AdminRepo adminRepo;

    @Autowired
    PasswordEncoder passwordEncoder;


    @Override
    public String sveAdmin(AdminDto adminDto) {
        if(adminDto == null){
            return "Please enter valid data";
        }
        if(findByEmail(adminDto.getEmail())==null){
            if(findByPhone(adminDto.getPhone())==null){
                if(adminDto.getPassword().equals(adminDto.getConfirmPassword())){
                   AdminEntity adminEntity = new AdminEntity();
                   BeanUtils.copyProperties(adminDto,adminEntity);
                    adminEntity.setFirstName(adminEntity.getFirstName().trim());
                    adminEntity.setLastname(adminEntity.getLastname().trim());
                    adminEntity.setPicName("pngegg.png");
                    adminEntity.setCount(0);
                    adminEntity.setStatus(true);
                    adminEntity.setOtp(null);
                    adminEntity.setPassword(passwordEncoder.encode(adminEntity.getPassword()));
                    boolean save = adminRepo.saveAdmin(adminEntity);
                    if(save){
                        return "Admin saved successfully";
                    }else{
                        return "Admin not saved";
                    }
                }
                return "Password does not match with confirm Password";
            }
            return "Phone already exist";
        }
        return "Email is already exist";
    }


    @Override
    public AdminDto findByEmail(String email) {
        if(email==null){
            return null;
        }
        AdminEntity admin = adminRepo.findByEmail(email);
        if(admin != null){
            AdminDto adminDto = new AdminDto();
            BeanUtils.copyProperties(admin, adminDto);
            return adminDto;
        }
        return  null;

    }

    @Override
    public AdminDto findByPhone(String phone) {
       if(phone == null){
           return null;
       }
       AdminEntity admin = adminRepo.findByPhone(phone);
       if(admin != null){
           AdminDto adminDto = new AdminDto();
           BeanUtils.copyProperties(admin,adminDto);
            return adminDto;
       }
       return null;
    }

    @Override
    public boolean updateAdmin(AdminDto adminDto) {
        if(adminDto == null){
            return false;
        }
        AdminEntity admin = new AdminEntity();
        BeanUtils.copyProperties(adminDto, admin);
        return adminRepo.updateAdmin(admin);
    }

    @Override
    public String uploadProfilePic(String email, String fileName) {
        AdminDto admin = findByEmail(email);
        if(admin == null){
            return "The email is not found";
        }
        admin.setPicName(fileName);
        boolean update = updateAdmin(admin);
        if(!update){
            return "Unable to update";
        }
        return "update successfully";
    }

    @Override
    public boolean updateAdminProfile(Integer id, AdminEditProfileDto editDto) {
        if (id == null || editDto == null) {
            return false;
        }
        AdminEntity admin = adminRepo.findById(id);
        if (admin == null) {
            return false;
        }
        admin.setFirstName(editDto.getFirstName().trim());
        admin.setLastname(editDto.getLastname().trim());
        admin.setEmail(editDto.getEmail().trim());
        admin.setPhone(editDto.getPhone());
        admin.setGender(editDto.getGender());
        admin.setAge(editDto.getAge());

        return adminRepo.updateAdmin(admin);
    }
}
