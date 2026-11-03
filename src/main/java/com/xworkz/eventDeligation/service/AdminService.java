package com.xworkz.eventDeligation.service;

import com.xworkz.eventDeligation.dto.AdminDto;
import com.xworkz.eventDeligation.dto.AdminEditProfileDto;

public interface AdminService {

    String sveAdmin(AdminDto adminDto);
    AdminDto findByEmail(String email);
    AdminDto findByPhone(String phone);
    boolean updateAdmin(AdminDto adminDto);
    String uploadProfilePic(String email,String fileName);
    boolean updateAdminProfile(Integer id, AdminEditProfileDto editDto);
}
