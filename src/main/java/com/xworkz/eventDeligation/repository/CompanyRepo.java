package com.xworkz.eventDeligation.repository;

import com.xworkz.eventDeligation.constants.CompanyReviewStatus;
import com.xworkz.eventDeligation.entity.CompanyEntity;

import java.util.List;

public interface CompanyRepo {

    boolean saveCompany(CompanyEntity companyEntity);
    CompanyEntity findByEmail(String email);
    CompanyEntity findByContactNumber(String contactNumber);
    CompanyEntity findByGstinNumber(String gstinNumber);
    CompanyEntity findById(Integer id);
    CompanyEntity updateCompany(CompanyEntity companyEntity);
    List<CompanyEntity> findAllCompanies();
    List<CompanyEntity> findFilteredCompanies(String search, String status);
    CompanyEntity findByUpdateToken(String updateToken);
    List<CompanyEntity> findCompaniesByPagination(int page, int size);
    long countAllCompanies();
    List<CompanyEntity> findFilteredCompaniesByPagination(String search, String status, int page, int size);
    long countFilteredCompanies(String search, String status);

}
