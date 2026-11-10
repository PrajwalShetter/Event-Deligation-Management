package com.xworkz.eventDeligation.service;

import com.xworkz.eventDeligation.dto.CompanyPaginationDto;
import com.xworkz.eventDeligation.dto.CompanyRegistrationDto;
import com.xworkz.eventDeligation.dto.CompanyResponseDto;
import com.xworkz.eventDeligation.dto.CompanyUpdateDto;
import com.xworkz.eventDeligation.entity.CompanyEntity;

import java.util.List;

public interface CompanyService {

    CompanyResponseDto registerCompany(CompanyRegistrationDto requestDto);
    CompanyResponseDto findByEmail(String email);
    CompanyResponseDto findByContactNumber(String contactNumber);
    CompanyResponseDto findByGstinNumber(String gstinNumber);
    CompanyResponseDto findById(Integer id);
    CompanyResponseDto updateCompany(CompanyEntity companyEntity);
    List<CompanyResponseDto> findAllCompanies();
    CompanyResponseDto approveCompany(Integer id);
    CompanyResponseDto rejectCompany(Integer id, String rejectFeedback);
    boolean existsByEmail(String email);
    boolean existsByPhone(String phone);
    boolean existsByGstin(String gstin);
    List<CompanyResponseDto> findFilteredCompanies(String search, String status);
    CompanyResponseDto validateUpdateToken(String token);
    CompanyResponseDto updateCompanyUsingToken(String token, CompanyUpdateDto requestDto);
    CompanyPaginationDto getCompaniesByPagination(int page, int size);
    CompanyPaginationDto getFilteredCompaniesByPagination(String search, String status, int page, int size);
    boolean sendCompanyLoginOtp(String email);
}
