package com.xworkz.eventDeligation.repository;

import com.xworkz.eventDeligation.entity.AdminEntity;

public interface AdminRepo {

     boolean saveAdmin(AdminEntity adminEntity);
     AdminEntity findByEmail(String email);
     AdminEntity findByPhone(String phone);
    boolean updateAdmin(AdminEntity adminEntity);
    AdminEntity findById(Integer id);

}
