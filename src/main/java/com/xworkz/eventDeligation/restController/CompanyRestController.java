package com.xworkz.eventDeligation.restController;

import com.xworkz.eventDeligation.dto.CompanyRegistrationDto;
import com.xworkz.eventDeligation.dto.CompanyResponseDto;
import com.xworkz.eventDeligation.dto.ResponseDto;
import com.xworkz.eventDeligation.service.CompanyService;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

@RestController
@RequestMapping("/")
@Validated
public class CompanyRestController {

    private final CompanyService companyService;

    public CompanyRestController(CompanyService companyService) {
        this.companyService = companyService;
    }

    @PostMapping(value = "company/register", consumes = MediaType.MULTIPART_FORM_DATA_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<ResponseDto<CompanyResponseDto>> registerCompany(@Valid @ModelAttribute CompanyRegistrationDto requestDto) {

        CompanyResponseDto companyResponse = companyService.registerCompany(requestDto);
        ResponseDto<CompanyResponseDto> response = new ResponseDto<>(true, "Company registered successfully. Your details are under review.", companyResponse);
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }

    @GetMapping("checkCompanyEmail")
    @ResponseBody
    public String checkEmail(@RequestParam String email) {
        return companyService.existsByEmail(email) ? "Email already exists" : "Email available";
    }

    @GetMapping("checkCompanyPhone")
    @ResponseBody
    public String checkPhone(@RequestParam String phone) {
        return companyService.existsByPhone(phone) ? "Phone already exists" : "Phone available";
    }

    @GetMapping("checkCompanyGstin")
    @ResponseBody
    public String checkGstin(@RequestParam String gstin) {
        return companyService.existsByGstin(gstin) ? "GSTIN already exists" : "GSTIN available";
    }
}
