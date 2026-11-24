<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm py-3">
    <div class="container-fluid px-4 px-lg-5">
        <!-- Brand / Logo -->
        <a class="navbar-brand fw-bold d-flex align-items-center gap-2" href="${pageContext.request.contextPath}/company/dashboard">
            <i class="bi bi-building-fill-check fs-4 text-primary"></i>
            <span>Company Portal</span>
        </a>

        <!-- Mobile Toggle Button -->
        <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#companyNavbarNav" aria-controls="companyNavbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Navbar Links -->
        <div class="collapse navbar-collapse justify-content-end" id="companyNavbarNav">
            <ul class="navbar-nav align-items-center gap-3">
                <li class="nav-item">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/company/dashboard">
                        <i class="bi bi-speedometer2 me-1"></i> Dashboard
                    </a>
                </li>


                <!-- Delegates link -->
                                <li class="nav-item">
                                    <a class="nav-link" href="${pageContext.request.contextPath}/company/delegates">
                                        <i class="bi bi-people-fill me-1"></i> Delegates
                                    </a>
                                </li>


                <!-- Display Logged-in Company Info / Logout -->
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle text-white fw-semibold d-flex align-items-center gap-1" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="bi bi-person-circle fs-5 text-secondary"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end shadow border-0 py-2">
                        <li>
                        <a  class="dropdown-item text-success fw-medium py-2" href="${pageContext.request.contextPath}/company/profile">
                           <i class="bi bi-box-arrow-right me-2"></i> My Profile
                        </a>
                            <a class="dropdown-item text-danger fw-medium py-2" href="${pageContext.request.contextPath}/company/logout">
                                <i class="bi bi-box-arrow-right me-2"></i> Logout
                            </a>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>