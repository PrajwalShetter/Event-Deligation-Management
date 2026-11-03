package com.xworkz.eventDeligation.service.impl;

import com.xworkz.eventDeligation.constants.CompanyReviewStatus;
import com.xworkz.eventDeligation.dto.CompanyPaginationDto;
import com.xworkz.eventDeligation.dto.CompanyRegistrationDto;
import com.xworkz.eventDeligation.dto.CompanyResponseDto;
import com.xworkz.eventDeligation.dto.CompanyUpdateDto;
import com.xworkz.eventDeligation.entity.CompanyEntity;
import com.xworkz.eventDeligation.event.CompanyRegistrationEvent;
import com.xworkz.eventDeligation.exception.CompanyRegistrationException;
import com.xworkz.eventDeligation.exception.DuplicateCompanyException;
import com.xworkz.eventDeligation.mapper.CompanyMapper;
import com.xworkz.eventDeligation.repository.CompanyRepo;
import com.xworkz.eventDeligation.service.CompanyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.time.LocalDateTime;
import java.util.Base64;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class CompanyServiceImpl implements CompanyService {

    @Autowired
    private File profilePicDirectory;
    private final CompanyRepo companyRepository;
    private final CompanyMapper companyMapper;
    private final ApplicationEventPublisher eventPublisher;

    public CompanyServiceImpl(CompanyRepo companyRepository, CompanyMapper companyMapper, ApplicationEventPublisher eventPublisher) {
        this.companyRepository = companyRepository;
        this.companyMapper = companyMapper;
        this.eventPublisher = eventPublisher;
    }


    @Override
    @Transactional
    public CompanyResponseDto registerCompany(CompanyRegistrationDto requestDto) {

        // Step 1: Check request
        if (requestDto == null) {
            throw new IllegalArgumentException("Company registration details are required");
        }

        // Step 2: Normalize input
        requestDto.setCompanyName(requestDto.getCompanyName().trim());
        requestDto.setEmail(requestDto.getEmail().trim().toLowerCase());
        requestDto.setContactNumber(requestDto.getContactNumber().trim());
        requestDto.setGstinNumber(requestDto.getGstinNumber().trim().toUpperCase());

        // Step 3: Check duplicate email
        if (companyRepository.findByEmail(requestDto.getEmail()) != null) {
            throw new DuplicateCompanyException("Company email already exists");
        }

        // Step 4: Check duplicate contact number
        if (companyRepository.findByContactNumber(requestDto.getContactNumber()) != null) {
            throw new DuplicateCompanyException("Company contact number already exists");
        }

        // Step 5: Check duplicate GSTIN
        if (companyRepository.findByGstinNumber(requestDto.getGstinNumber()) != null) {
            throw new DuplicateCompanyException("GSTIN already exists");
        }

        String logoName = saveCompanyLogo(requestDto.getLogo());

        // Step 6: Convert DTO into Entity
        CompanyEntity companyEntity = companyMapper.toEntity(requestDto);

        // Step 7: Set logo filename
        companyEntity.setLogoName(logoName);

        // Step 8: Set default review status
        companyEntity.setReviewStatus(CompanyReviewStatus.PENDING_REVIEW);

        // Step 9: Save company
        companyRepository.saveCompany(companyEntity);

        eventPublisher.publishEvent(new CompanyRegistrationEvent(companyEntity.getCompanyName(), companyEntity.getEmail()));

        // Step 10: Convert saved entity into Response DTO
        return companyMapper.toResponseDto(companyEntity);
    }

    @Override
    public CompanyResponseDto findByEmail(String email) {
        return null;
    }

    @Override
    public CompanyResponseDto findByContactNumber(String contactNumber) {
        return null;
    }

    @Override
    public CompanyResponseDto findByGstinNumber(String gstinNumber) {
        return null;
    }

    @Override
    public CompanyResponseDto findById(Integer id) {
        return null;
    }

    @Override
    @Transactional
    public CompanyResponseDto updateCompany(CompanyEntity companyEntity) {

        CompanyEntity updatedCompany =
                companyRepository.updateCompany(companyEntity);

        return companyMapper.toResponseDto(updatedCompany);
    }

    @Override
    public List<CompanyResponseDto> findAllCompanies() {

        List<CompanyEntity> companies = companyRepository.findAllCompanies();

        return companies.stream()
                .map(companyMapper::toResponseDto)
                .collect(Collectors.toList());
    }

    @Override
    @Transactional
    public CompanyResponseDto approveCompany(Integer id) {

        CompanyEntity companyEntity = companyRepository.findById(id);

        if (companyEntity == null) {
            throw new IllegalArgumentException("Company not found");
        }

        companyEntity.setReviewStatus(CompanyReviewStatus.APPROVED);
        companyEntity.setRejectFeedback(null);

        CompanyEntity updatedCompany =
                companyRepository.updateCompany(companyEntity);

        eventPublisher.publishEvent(new CompanyRegistrationEvent(
                        updatedCompany.getCompanyName(), updatedCompany.getEmail(), true));

        return companyMapper.toResponseDto(updatedCompany);
    }

    @Override
    @Transactional
    public CompanyResponseDto rejectCompany(Integer id, String rejectFeedback) {

        CompanyEntity companyEntity = companyRepository.findById(id);

        if (companyEntity == null) {
            throw new IllegalArgumentException("Company not found");
        }

        if (rejectFeedback == null || rejectFeedback.trim().isEmpty()) {
            throw new IllegalArgumentException("Rejection feedback is required");
        }

        // Generate secure update token
        String updateToken = generateSecureToken();

        // Store hashed token in database
        companyEntity.setUpdateToken(hashToken(updateToken));

        // Set expiry time to 48 hours
        companyEntity.setUpdateTokenExpiry(LocalDateTime.now().plusHours(48));

        // Update company status and feedback
        companyEntity.setReviewStatus(CompanyReviewStatus.REJECTED);
        companyEntity.setRejectFeedback(rejectFeedback.trim());

        CompanyEntity updatedCompany =
                companyRepository.updateCompany(companyEntity);

        // Publish rejection event
        eventPublisher.publishEvent(
                new CompanyRegistrationEvent(
                        updatedCompany.getCompanyName(),
                        updatedCompany.getEmail(),
                        false,
                        updatedCompany.getRejectFeedback(),
                        updateToken
                )
        );

        return companyMapper.toResponseDto(updatedCompany);
    }

    @Override
    public boolean existsByEmail(String email) {
        return companyRepository.findByEmail(email.trim().toLowerCase()) != null;
    }

    @Override
    public boolean existsByPhone(String phone) {
        return companyRepository.findByContactNumber(phone.trim()) != null;
    }

    @Override
    public boolean existsByGstin(String gstin) {
        return companyRepository.findByGstinNumber(gstin.trim().toUpperCase()) != null;
    }

    @Override
    public List<CompanyResponseDto> findFilteredCompanies(String search, String status) {
        List<CompanyEntity> companies = companyRepository.findFilteredCompanies(search, status);
        return companies.stream()
                .map(companyMapper::toResponseDto)
                .collect(Collectors.toList());
    }

    private String generateSecureToken() {

        SecureRandom secureRandom = new SecureRandom();

        byte[] tokenBytes = new byte[32];
        secureRandom.nextBytes(tokenBytes);

        return Base64.getUrlEncoder()
                .withoutPadding()
                .encodeToString(tokenBytes);
    }

    private String hashToken(String token) {

        try {
            MessageDigest messageDigest =
                    MessageDigest.getInstance("SHA-256");

            byte[] hashBytes = messageDigest.digest(
                    token.getBytes(java.nio.charset.StandardCharsets.UTF_8)
            );

            StringBuilder hash = new StringBuilder();

            for (byte b : hashBytes) {
                hash.append(String.format("%02x", b));
            }

            return hash.toString();

        } catch (NoSuchAlgorithmException e) {
            throw new IllegalStateException("Unable to hash update token", e);
        }
    }

    @Override
    public CompanyResponseDto validateUpdateToken(String token) {

        if (token == null || token.trim().isEmpty()) {
            throw new IllegalArgumentException("Invalid update link.");
        }

        // Convert the received token into its SHA-256 hash
        String tokenHash = hashToken(token);

        // Find company using the hashed token
        CompanyEntity companyEntity =
                companyRepository.findByUpdateToken(tokenHash);

        if (companyEntity == null) {
            throw new IllegalArgumentException("Invalid update link.");
        }

        // Check whether the token has expired
        if (companyEntity.getUpdateTokenExpiry() == null ||
                companyEntity.getUpdateTokenExpiry().isBefore(LocalDateTime.now())) {
            throw new IllegalArgumentException("Update link has expired.");
        }

        // Ensure the company is still rejected
        if (companyEntity.getReviewStatus() != CompanyReviewStatus.REJECTED) {
            throw new IllegalArgumentException("This update link is no longer valid.");
        }

        return companyMapper.toResponseDto(companyEntity);
    }

    private String saveCompanyLogo(MultipartFile logo) {

        if (logo == null || logo.isEmpty()) {
            return null;
        }

        String logoName = System.currentTimeMillis() + "_"
                + new File(logo.getOriginalFilename()).getName();

        File destination = new File(profilePicDirectory, logoName);

        try {
            logo.transferTo(destination);
        } catch (IOException exception) {
            throw new CompanyRegistrationException(
                    "Failed to upload company logo");
        }

        return logoName;
    }

    @Override
    @Transactional
    public CompanyResponseDto updateCompanyUsingToken(
            String token, CompanyUpdateDto requestDto) {

        // Step 1: Validate request
        if (requestDto == null) {
            throw new IllegalArgumentException("Company details are required");
        }

        // Step 2: Validate token
        CompanyResponseDto validatedCompany = validateUpdateToken(token);

        String tokenHash = hashToken(token);

        CompanyEntity companyEntity =
                companyRepository.findByUpdateToken(tokenHash);

        // Step 3: Normalize input
        requestDto.setCompanyName(requestDto.getCompanyName().trim());
        requestDto.setEmail(requestDto.getEmail().trim().toLowerCase());
        requestDto.setContactNumber(requestDto.getContactNumber().trim());
        requestDto.setGstinNumber(requestDto.getGstinNumber().trim().toUpperCase());

        // Step 4: Check duplicate email
        CompanyEntity emailCompany =
                companyRepository.findByEmail(requestDto.getEmail());

        if (emailCompany != null &&
                !emailCompany.getId().equals(companyEntity.getId())) {
            throw new DuplicateCompanyException("Company email already exists");
        }

        // Step 5: Check duplicate contact number
        CompanyEntity phoneCompany =
                companyRepository.findByContactNumber(requestDto.getContactNumber());

        if (phoneCompany != null &&
                !phoneCompany.getId().equals(companyEntity.getId())) {
            throw new DuplicateCompanyException("Company contact number already exists");
        }

        // Step 6: Check duplicate GSTIN
        CompanyEntity gstinCompany =
                companyRepository.findByGstinNumber(requestDto.getGstinNumber());

        if (gstinCompany != null &&
                !gstinCompany.getId().equals(companyEntity.getId())) {
            throw new DuplicateCompanyException("GSTIN already exists");
        }

        // Step 7: Update company fields
        companyEntity.setCompanyName(requestDto.getCompanyName());
        companyEntity.setEmail(requestDto.getEmail());
        companyEntity.setContactNumber(requestDto.getContactNumber());
        companyEntity.setEmployeeSize(requestDto.getEmployeeSize());
        companyEntity.setGstinNumber(requestDto.getGstinNumber());
        companyEntity.setAddress(requestDto.getAddress());
        companyEntity.setCountry(requestDto.getCountry());
        companyEntity.setState(requestDto.getState());
        companyEntity.setCity(requestDto.getCity());
        companyEntity.setPincode(requestDto.getPincode());
        companyEntity.setMapLink(requestDto.getMapLink());

        // Step 8: Update logo only if a new one is uploaded
        if (requestDto.getLogo() != null &&
                !requestDto.getLogo().isEmpty()) {

            String logoName = saveCompanyLogo(requestDto.getLogo());
            companyEntity.setLogoName(logoName);
        }

        // Step 9: Reset review status and invalidate token
        companyEntity.setReviewStatus(CompanyReviewStatus.PENDING_REVIEW);
        companyEntity.setRejectFeedback(null);
        companyEntity.setUpdateToken(null);
        companyEntity.setUpdateTokenExpiry(null);

        // Step 10: Update existing company
        CompanyEntity updatedCompany =
                companyRepository.updateCompany(companyEntity);

        return companyMapper.toResponseDto(updatedCompany);
    }

    @Override
    @Transactional(readOnly = true)
    public CompanyPaginationDto getCompaniesByPagination(int page, int size) {

        // Step 1: Validate pagination values
        if (page < 0) {
            page = 0;
        }

        if (size <= 0) {
            size = 10;
        }

        // Step 2: Get total number of companies
        long totalRecords = companyRepository.countAllCompanies();

        // Step 3: Calculate total pages
        int totalPages = (int) Math.ceil((double) totalRecords / size);

        // Step 4: Fetch companies for the requested page
        List<CompanyEntity> companyEntities =
                companyRepository.findCompaniesByPagination(page, size);

        // Step 5: Convert Entity list into Response DTO list
        List<CompanyResponseDto> companies = companyEntities.stream()
                .map(companyMapper::toResponseDto)
                .collect(Collectors.toList());

        // Step 6: Prepare pagination response
        return new CompanyPaginationDto(
                companies,
                page,
                totalPages,
                totalRecords,
                size
        );
    }

    @Override
    @Transactional(readOnly = true)
    public CompanyPaginationDto getFilteredCompaniesByPagination(
            String search, String status, int page, int size) {

        // Step 1: Validate pagination values
        if (page < 0) {
            page = 0;
        }

        if (size <= 0) {
            size = 10;
        }

        // Step 2: Count filtered companies
        long totalRecords =
                companyRepository.countFilteredCompanies(search, status);

        // Step 3: Calculate total pages
        int totalPages = (int) Math.ceil((double) totalRecords / size);

        // Step 4: Fetch filtered companies
        List<CompanyEntity> companyEntities =
                companyRepository.findFilteredCompaniesByPagination(
                        search, status, page, size);

        // Step 5: Convert entities into response DTOs
        List<CompanyResponseDto> companies = companyEntities.stream()
                .map(companyMapper::toResponseDto)
                .collect(Collectors.toList());

        // Step 6: Return pagination details
        return new CompanyPaginationDto(
                companies,
                page,
                totalPages,
                totalRecords,
                size
        );
    }
}


