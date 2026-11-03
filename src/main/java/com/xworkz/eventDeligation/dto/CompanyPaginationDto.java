package com.xworkz.eventDeligation.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor

public class CompanyPaginationDto {

    private List<CompanyResponseDto> companies;

    private int currentPage;

    private int totalPages;

    private long totalRecords;

    private int pageSize;
}
