<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page isELIgnored="false" %>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm"
     style="background-color: #142b46;">

    <div class="container-fluid px-3 px-lg-5">

        <!-- Company Logo -->
        <a class="navbar-brand d-flex align-items-center"
           href="${pageContext.request.contextPath}/">

            <img src="${pageContext.request.contextPath}/assets/images/Xworkz.png"
                 alt="Company Logo"
                 style="height: 48px; width: auto; object-fit: contain;">
        </a>

        <!-- Mobile Toggle -->
        <button class="navbar-toggler" type="button"
                data-bs-toggle="collapse"
                data-bs-target="#mainNavbar"
                aria-controls="mainNavbar"
                aria-expanded="false"
                aria-label="Toggle navigation">

            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Navigation Links -->
        <div class="collapse navbar-collapse" id="mainNavbar">

            <ul class="navbar-nav ms-auto align-items-lg-center gap-lg-3 py-2 py-lg-0">

                <li class="nav-item">
                    <a class="nav-link active"
                       href="${pageContext.request.contextPath}/">
                        <i class="bi bi-house-door me-1"></i>
                        Home
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link"
                       href="${pageContext.request.contextPath}/registerPage">
                        <i class="bi bi-person-plus me-1"></i>
                        Admin Register
                    </a>
                </li>

                <li class="nav-item">
                                    <a class="nav-link"
                                       href="${pageContext.request.contextPath}/companyRegisterPage">
                                        <i class="bi bi-person-plus me-1"></i>
                                        C-Registration
                                    </a>
                                </li>

                <li class="nav-item">
                    <a class="btn btn-light text-primary fw-semibold px-4 rounded-pill"
                       href="${pageContext.request.contextPath}/loginPage">
                        <i class="bi bi-box-arrow-in-right me-1"></i>
                        Login
                    </a>
                </li>

            </ul>
        </div>

    </div>
</nav>