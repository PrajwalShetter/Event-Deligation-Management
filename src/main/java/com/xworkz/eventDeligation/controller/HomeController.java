package com.xworkz.eventDeligation.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @GetMapping("/")
    public String getHome(){
        return "index";
    }

    @GetMapping("loginPage")
    public String getLoginPage(){
        return "admin/login";
    }

    @GetMapping("registerPage")
    public String getAdminRegistrationPage(){
        return "admin/adminRegistration";
    }

    @GetMapping("companyRegisterPage")
    public String getCompanyRegistrationPage(){
        return "company/companyRegistration";
    }
}
