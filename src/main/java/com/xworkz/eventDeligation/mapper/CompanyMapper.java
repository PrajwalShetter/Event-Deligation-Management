package com.xworkz.eventDeligation.mapper;

import com.xworkz.eventDeligation.dto.CompanyRegistrationDto;
import com.xworkz.eventDeligation.dto.CompanyResponseDto;
import com.xworkz.eventDeligation.entity.CompanyEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface CompanyMapper {

    // Convert registration request DTO to entity.
    // Logo is stored separately, so it must not be mapped automatically.
    @Mapping(target = "id", ignore = true)
    @Mapping(target = "logoName", ignore = true)
    @Mapping(target = "reviewStatus", ignore = true)
    @Mapping(target = "otp", ignore = true)
    @Mapping(target = "otpExpiryTime", ignore = true)
    CompanyEntity toEntity(CompanyRegistrationDto requestDto);

    // Convert entity to safe response DTO.
    @Mapping(target = "reviewStatus", expression = "java(entity.getReviewStatus().name())")
    CompanyResponseDto toResponseDto(CompanyEntity entity);
}
