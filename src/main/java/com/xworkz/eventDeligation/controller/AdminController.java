package com.xworkz.eventDeligation.controller;

import com.xworkz.eventDeligation.dto.*;
import com.xworkz.eventDeligation.service.AdminLoginService;
import com.xworkz.eventDeligation.service.AdminService;
import com.xworkz.eventDeligation.service.CompanyService;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.MediaType;
import org.springframework.http.MediaTypeFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.io.*;
import java.util.Collections;
import java.util.List;

@Controller
@RequestMapping("/")
public class AdminController {

    @Autowired
    AdminService adminService;
    @Autowired
    AdminLoginService adminLoginService;
    @Autowired
    File profilePicDirectory;
    @Autowired
    CompanyService companyService;

    @GetMapping("admin/logout")
    public String adminLogout(HttpSession session) {

        session.invalidate();
        return "redirect:/loginPage";
    }

    @GetMapping("admin/editProfilePage")
    public String getEditProfilePage(HttpSession session, HttpServletResponse response,Model model){
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        String email = (String)session.getAttribute("loggedInEmail");
        if(email == null){
            return "redirect:/loginPage";
        }

        AdminDto admin = adminService.findByEmail(email);
        if (admin == null) {
            session.invalidate();
            return "redirect:/loginPage";
        }
        model.addAttribute("admin", admin);
        return "admin/adminEditProfile";
    }

    @GetMapping("resetPasswordPage")
    public String getRestPasswordPage(){
        return "admin/resetPassword";
    }

    @GetMapping("setNewPasswordPage")
    public String getSetNewPasswordPage(){
        return "admin/setNewPassword";
    }


    @GetMapping("adminProfilePage")
    public String getAdminProfilePage(HttpServletResponse response, HttpSession session, Model model) {
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        String email = (String) session.getAttribute("loggedInEmail");

        if (email == null) {
            return "redirect:/loginPage";
        }

        AdminDto admin = adminService.findByEmail(email);
        if (admin == null) {
            session.invalidate();
            return "redirect:/loginPage";
        }
        model.addAttribute("admin", admin);
        return "admin/adminProfile";
    }

//    @GetMapping("companyListPage")
//    public String getCompanyListPage(HttpSession session, HttpServletResponse response, Model model){
//        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
//        response.setHeader("Pragma", "no-cache");
//        response.setDateHeader("Expires", 0);
//
//        String email = (String) session.getAttribute("loggedInEmail");
//
//        if (email == null) {
//            return "redirect:/loginPage";
//        }
//
//        AdminDto admin = adminService.findByEmail(email);
//        if (admin == null) {
//            session.invalidate();
//            return "redirect:/loginPage";
//        }
//        model.addAttribute("admin", admin);
//        return "company/companyList";
//    }


    @PostMapping("register")
    public String saveAdmin(@Valid AdminDto adminDto, BindingResult binding, RedirectAttributes redirectAttributes){
        System.out.println(adminDto);

        if(binding.hasErrors()){
            List<ObjectError> allErrors = binding.getAllErrors();
            allErrors.stream().forEach(objectError -> System.out.println(objectError.getDefaultMessage()));
            redirectAttributes.addFlashAttribute("failure", "Enter a valid data");
            return "redirect:/registerPage";
        }

        String message = adminService.sveAdmin(adminDto);
        System.out.println(message);
        if(message.equalsIgnoreCase("Admin not saved")
                || message.equalsIgnoreCase("Password does not match with confirm Password")
                || message.equalsIgnoreCase("Phone already exist")
                || message.equalsIgnoreCase("Email is already exist")){
            redirectAttributes.addFlashAttribute("failure", message);
            return "redirect:/registerPage";
        }else {
            redirectAttributes.addFlashAttribute("success","Registered successfully. Continue with login");
            return "redirect:/loginPage";
        }
    }

    @GetMapping("adminHome")
    public String getHomePage(HttpSession session, HttpServletResponse response,Model model){
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        String email = (String)session.getAttribute("loggedInEmail");
        if(email == null){
            return "redirect:/loginPage";
        }
        AdminDto admin = adminService.findByEmail(email);
        if (admin == null) {
            session.invalidate();
            return "redirect:/loginPage";
        }
        model.addAttribute("admin", admin);
        return "admin/index";
    }

    @PostMapping("admin/login")
    public String saveLogin(@Valid AdminLoginDto loginDto, BindingResult binding, HttpSession session, RedirectAttributes redirectAttributes){
        System.out.println(loginDto);
        if (binding.hasErrors()) {
            binding.getAllErrors().forEach(objectError -> {
                System.out.println("Validation Error: " + objectError.getDefaultMessage());
            });

            redirectAttributes.addFlashAttribute("failure", "Enter valid data");
            redirectAttributes.addFlashAttribute("email", loginDto.getEmail());

            return "redirect:/loginPage";
        }

        String message = adminLoginService.saveAdminLogin(loginDto);
        if(message.equalsIgnoreCase("Account is blocked. please reset your password")){
            redirectAttributes.addFlashAttribute("email",loginDto.getEmail());
            redirectAttributes.addFlashAttribute("blockMsg", "Your account has been blocked for attempting 3 times incorrect password");
            return "redirect:/resetPasswordPage";
        }
        if(message.equalsIgnoreCase("Login saved successfully")){
            session.setAttribute("loggedInEmail",loginDto.getEmail());
            return "redirect:/adminHome";
        }
        redirectAttributes.addFlashAttribute("failure",message);
        redirectAttributes.addFlashAttribute("email",loginDto.getEmail());
        return "redirect:/loginPage";
    }

    @GetMapping("sendOtp")
    public String sendOtp(@RequestParam String email, RedirectAttributes redirectAttributes){
        String result = adminLoginService.sendOtp(email);
        redirectAttributes.addFlashAttribute("email", email);
        if(result.equalsIgnoreCase("otp sent successfully")){
            redirectAttributes.addFlashAttribute("otpSent", true);
        } else {
            redirectAttributes.addFlashAttribute("otpSent", false);
            redirectAttributes.addFlashAttribute("failure", result);
        }
        return "redirect:/resetPasswordPage";

    }

    @PostMapping("admin/verifyOtp")
    public String verifyOtp(@RequestParam String email, String otp, RedirectAttributes redirectAttributes, HttpSession session){
        String result = adminLoginService.verifyOtp(email,otp);
        session.setAttribute("email",email);

        if(result.equalsIgnoreCase("OTP Matched")){
            redirectAttributes.addFlashAttribute("email",email);
            return "redirect:/setNewPasswordPage";
        }
        redirectAttributes.addFlashAttribute("failure", result);
        redirectAttributes.addFlashAttribute("otpSent", true);
        redirectAttributes.addFlashAttribute("email", email);
        return "redirect:/resetPasswordPage";
    }

    @PostMapping("admin/setNewPassword")
    public String setNewPassword(@RequestParam String email, @RequestParam String newPassword,
                                 @RequestParam String confirmPassword, RedirectAttributes redirectAttributes) {

        String result = adminLoginService.resetNewPassword(email, newPassword, confirmPassword);

        System.out.println("Result of new password: " + result);

        if (result.equalsIgnoreCase("Password Updated")) {
            redirectAttributes.addFlashAttribute("success", "Password updated successfully. Please login.");
            return "redirect:/loginPage";
        }
        redirectAttributes.addFlashAttribute("email", email);

        if (result.startsWith("Password must")) {
            redirectAttributes.addFlashAttribute("passwordError", result);
        } else if (result.equalsIgnoreCase("Passwords do not match.")) {
            redirectAttributes.addFlashAttribute("confirmPasswordError", result);
        } else {
            redirectAttributes.addFlashAttribute("failure", result);
        }

        return "redirect:/setNewPasswordPage";
    }

    @GetMapping("admin/profile")
    public String getAdminProfile( HttpSession session, RedirectAttributes directAttribute, HttpServletResponse response){

        String email = (String)session.getAttribute("loggedInEmail");
        if(email == null){
            return "redirect:/loginPage";
        }
        AdminDto admin = adminService.findByEmail(email);
        if(admin == null){
            session.invalidate();
            return "redirect:/loginPage";
        }
        directAttribute.addFlashAttribute("admin",admin);
        return "redirect:/adminProfilePage";

    }

    @PostMapping("admin/uploadProfilePic")
    public String uploadProfilePic(@RequestParam("profilePicFile") MultipartFile profilePicFile, HttpSession session, RedirectAttributes redirectAttributes, HttpServletResponse response) throws IOException{
            String email = (String)session.getAttribute("loggedInEmail");
            if(email==null){
                return "redirect:/loginPage";
            }

        String filename=profilePicFile.getOriginalFilename();
            if(filename==null || filename.trim().isEmpty()){
                redirectAttributes.addFlashAttribute("picNotUpload","Invalid FileName");
                return getAdminProfile(session,redirectAttributes,response);
            }

            File file =new File(profilePicDirectory,filename);
            profilePicFile.transferTo(file);
            String result = adminService.uploadProfilePic(email,filename);
            if(result.equalsIgnoreCase("update successfully")){
                redirectAttributes.addFlashAttribute("uploadPic","uploaded successfully");
            }else {
                redirectAttributes.addFlashAttribute("picNotUpload","unable upload Picture");
            }
            return getAdminProfile(session,redirectAttributes,response);
    }

    @GetMapping("admin/profile-picture")
    public void getProfilePic(HttpSession session, HttpServletResponse response, RedirectAttributes redirectAttributes){
        String email = (String) session.getAttribute("loggedInEmail");

        AdminDto admin = adminService.findByEmail(email);
        if(admin == null || admin.getPicName()== null){
            session.invalidate();
           return;
        }

        File file = new File(profilePicDirectory,admin.getPicName());

        try{
            FileInputStream fileInputStream = new FileInputStream(file);
            BufferedInputStream inputStream = new BufferedInputStream(fileInputStream);
            OutputStream outputStream =response.getOutputStream();

            IOUtils.copy(inputStream,outputStream);
            response.flushBuffer();

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    @GetMapping("admin/editProfile")
    public String editProfile(HttpSession session, RedirectAttributes redirectAttributes, HttpServletResponse response) {
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate, max-age=0");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);
        String email = (String) session.getAttribute("loggedInEmail");
        if (email == null) {
            return "redirect:/loginPage";
        }

        AdminDto admin = adminService.findByEmail(email);

        if (admin == null) {
            return "redirect:/loginPage";
        }
        redirectAttributes.addFlashAttribute("admin", admin);
        return "redirect:/admin/editProfilePage";
    }


    @PostMapping("admin/updateProfile")
    public String updateProfile(@Valid AdminEditProfileDto editDto, BindingResult binding, HttpSession session, RedirectAttributes redirectAttributes, HttpServletResponse response) {

        String loggedInEmail = (String) session.getAttribute("loggedInEmail");
        if (loggedInEmail == null) {
            return "redirect:/loginPage";
        }

        AdminDto existingAdmin = adminService.findByEmail(loggedInEmail);
        if (existingAdmin == null) {
            return "redirect:/loginPage";
        }

        if (binding.hasErrors()) {
            redirectAttributes.addFlashAttribute("editDto", editDto);
            redirectAttributes.addFlashAttribute("validationErrors", binding.getFieldErrors());
            return "redirect:/admin/editProfile";
        }

        AdminDto emailAdmin = adminService.findByEmail(editDto.getEmail());
        if (emailAdmin != null && !emailAdmin.getId().equals(existingAdmin.getId())) {
            redirectAttributes.addFlashAttribute("editDto", editDto);
            redirectAttributes.addFlashAttribute("emailError", "This email is already registered with another account.");
            return "redirect:/admin/editProfile";
        }

        AdminDto phoneAdmin = adminService.findByPhone(editDto.getPhone());
        if (phoneAdmin != null && !phoneAdmin.getId().equals(existingAdmin.getId())) {
            redirectAttributes.addFlashAttribute("editDto", editDto);
            redirectAttributes.addFlashAttribute("phoneError", "This phone number is already registered with another account.");
            return "redirect:/admin/editProfile";
        }

        boolean updated = adminService.updateAdminProfile(existingAdmin.getId(), editDto);
        if (!updated) {
            redirectAttributes.addFlashAttribute("failure", "Profile update failed.");
            redirectAttributes.addFlashAttribute("editDto", editDto);
            return "redirect:/admin/editProfile";
        }

        session.setAttribute("loggedInEmail", editDto.getEmail());
        redirectAttributes.addFlashAttribute("success", "Profile updated successfully.");
        return "redirect:/admin/profile";
    }


    @GetMapping("admin/companies")
    public String getAllCompanies(
            @RequestParam(required = false) String search,
            @RequestParam(required = false) String status,
            @RequestParam(defaultValue = "0") int page,
            HttpSession session,
            HttpServletResponse response,
            Model model,
            RedirectAttributes redirectAttributes) {

        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate, max-age=0");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        String email = (String) session.getAttribute("loggedInEmail");

        if (email == null) {
            return "redirect:/loginPage";
        }

        AdminDto admin = adminService.findByEmail(email);

        if (admin == null) {
            session.invalidate();
            return "redirect:/loginPage";
        }

        int size = 10;

        // Get filtered and paginated companies
        CompanyPaginationDto pagination = companyService.getFilteredCompaniesByPagination(search, status, page, size);

        // Handle page number beyond available pages
        if (pagination.getTotalPages() > 0 && page >= pagination.getTotalPages()) {

            redirectAttributes.addAttribute("page", pagination.getTotalPages() - 1);

            if (search != null && !search.trim().isEmpty()) {
                redirectAttributes.addAttribute("search", search);
            }

            if (status != null && !status.trim().isEmpty()) {
                redirectAttributes.addAttribute("status", status);
            }

            return "redirect:/admin/companies";
        }

        model.addAttribute("admin", admin);
        model.addAttribute("companies", pagination.getCompanies());
        model.addAttribute("pagination", pagination);

        model.addAttribute("search", search);
        model.addAttribute("status", status);

        return "company/companyList";
    }

    @PostMapping("admin/company/accept/{id}")
    public String approveCompany(@PathVariable Integer id,
                                 HttpSession session) {

        String email = (String) session.getAttribute("loggedInEmail");

        if (email == null) {
            return "redirect:/loginPage";
        }

        companyService.approveCompany(id);

        return "redirect:/admin/companies";
    }

    @PostMapping("admin/company/reject/{id}")
    public String rejectCompany(@PathVariable Integer id,
                                @RequestParam String rejectFeedback,
                                HttpSession session) {

        String email = (String) session.getAttribute("loggedInEmail");

        if (email == null) {
            return "redirect:/loginPage";
        }

        companyService.rejectCompany(id, rejectFeedback);

        return "redirect:/admin/companies";
    }

    @GetMapping("admin/company/logo/{logoName}")
    @ResponseBody
    public ResponseEntity<Resource> getCompanyLogo(@PathVariable String logoName) {

        try {
            File logoFile = new File(profilePicDirectory, logoName);

            if (!logoFile.exists() || !logoFile.isFile()) {
                return ResponseEntity.notFound().build();
            }

            Resource resource = new FileSystemResource(logoFile);

            return ResponseEntity.ok()
                    .contentType(MediaTypeFactory.getMediaType(resource)
                            .orElse(MediaType.APPLICATION_OCTET_STREAM))
                    .body(resource);

        } catch (Exception e) {
            return ResponseEntity.notFound().build();
        }
    }



}
