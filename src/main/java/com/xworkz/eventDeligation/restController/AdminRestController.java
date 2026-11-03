package com.xworkz.eventDeligation.restController;

import com.xworkz.eventDeligation.dto.AdminDto;
import com.xworkz.eventDeligation.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/")
public class AdminRestController {

    @Autowired
    AdminService adminService;

    @GetMapping("checkEmail")
    @ResponseBody
    public String checkEmailIsExistOrNot(@RequestParam String email){
        if(email == null){
            return "Email is required";
        }
        AdminDto admin = adminService.findByEmail(email);
        if(admin !=null){
            return "Email is already exist";
        }
        else {
            return "Email is valid";
        }
    }

    @GetMapping("checkPhone")
    @ResponseBody
    public String checkPhoneIsExistOrNot(@RequestParam String phone){
        if(!phone.matches("^[6-9][0-9]{9}$")){
            return "Enter a valid 10 digit Indian Standard Number";
        }
        AdminDto admin = adminService.findByPhone(phone);
        if(admin != null){
            return "Phone number is Exist";
        }
        return "PhoneNumber is Valid";

    }
}
