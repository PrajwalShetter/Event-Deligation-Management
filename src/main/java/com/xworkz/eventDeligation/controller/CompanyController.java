package com.xworkz.eventDeligation.controller;

import com.xworkz.eventDeligation.dto.CompanyResponseDto;
import com.xworkz.eventDeligation.dto.CompanyUpdateDto;
import com.xworkz.eventDeligation.service.CompanyService;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.validation.Valid;

@Controller
public class CompanyController {

    private final CompanyService companyService;

    public CompanyController(CompanyService companyService) {
        this.companyService = companyService;
    }

    @GetMapping("company/update")
    public String getCompanyUpdatePage(@RequestParam("token") String token, Model model) {

        try {
            CompanyResponseDto company =
                    companyService.validateUpdateToken(token);

            model.addAttribute("company", company);
            model.addAttribute("token", token);

            return "company/updateCompany";

        } catch (IllegalArgumentException e) {
            model.addAttribute("error", e.getMessage());
            return "company/invalidUpdateLink";
        }
    }

    @PostMapping(value = "company/update", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public String updateCompany(@RequestParam("token") String token, @Valid @ModelAttribute CompanyUpdateDto requestDto, BindingResult bindingResult, Model model) {

        if (bindingResult.hasErrors()) {
            try {
                CompanyResponseDto company = companyService.validateUpdateToken(token);

                model.addAttribute("company", company);
                model.addAttribute("token", token);
                model.addAttribute("errors", bindingResult.getFieldErrors());

                return "company/updateCompany";

            } catch (IllegalArgumentException e) {
                model.addAttribute("error", e.getMessage());
                return "company/invalidUpdateLink";
            }
        }

        try {
            companyService.updateCompanyUsingToken(token, requestDto);
            model.addAttribute("success", "Company details updated successfully. Your details are under review.");
            return "company/updateSuccess";

        } catch (Exception e) {
            model.addAttribute("error", e.getMessage());

            try {
                CompanyResponseDto company = companyService.validateUpdateToken(token);
                model.addAttribute("company", company);
                model.addAttribute("token", token);
                return "company/updateCompany";

            } catch (IllegalArgumentException ex) {
                model.addAttribute("error", ex.getMessage());
                return "company/invalidUpdateLink";
            }
        }
    }
}