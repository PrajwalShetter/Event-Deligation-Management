<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page isELIgnored="false" %>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
    <div class="container-fluid px-3 px-lg-4">

        <!-- Company Logo and Brand -->
        <a class="navbar-brand d-flex align-items-center gap-2"
           href="${pageContext.request.contextPath}/adminHome">

            <img src="${pageContext.request.contextPath}/assets/images/Xworkz.png"
                 alt="Xworkz Logo"
                 style="height: 42px; width: auto; object-fit: contain;">

            <i class="bi bi-shield-lock fs-5"></i>

            <span class="fw-bold">Event Delegation</span>
        </a>

        <!-- Mobile Toggle -->
        <button class="navbar-toggler"
                type="button"
                data-bs-toggle="collapse"
                data-bs-target="#adminNavbar"
                aria-controls="adminNavbar"
                aria-expanded="false"
                aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Navigation Links -->
        <div class="collapse navbar-collapse" id="adminNavbar">

            <ul class="navbar-nav ms-auto align-items-lg-center gap-lg-2">

                <li class="nav-item">
                    <a class="nav-link"
                       href="${pageContext.request.contextPath}/adminHome">
                        <i class="bi bi-speedometer2 me-1"></i>
                        Dashboard
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link"
                       href="${pageContext.request.contextPath}/admin/companies">
                        <i class="bi bi-building me-1"></i>
                        Companies
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link"
                       href="${pageContext.request.contextPath}/admin/events">
                        <i class="bi bi-calendar-event me-1"></i>
                        Events
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link"
                       href="${pageContext.request.contextPath}/admin/profile">
                        <i class="bi bi-person-circle me-1"></i>
                        Profile
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link"
                       href="${pageContext.request.contextPath}/admin/emails">
                        <i class="bi bi-envelope me-1"></i>
                        Email Activity
                    </a>
                </li>

                <li class="nav-item ms-lg-2">
                    <a class="nav-link d-flex align-items-center"
                       href="${pageContext.request.contextPath}/admin/profile"
                       title="My Profile">

                        <img src="${pageContext.request.contextPath}/admin/profile-picture"
                             alt="Admin Profile"
                             class="rounded-circle border border-2 border-light"
                             style="width: 38px; height: 38px; object-fit: cover;"
                             onerror="this.src='https://placehold.co/38x38/e9ecef/495057?text=A'">

                        <span class="ms-2 d-lg-none">My Profile</span>
                    </a>
                </li>

                <li class="nav-item ms-lg-2 mt-2 mt-lg-0">
                    <a class="btn btn-outline-light btn-sm rounded-pill px-3"
                       href="${pageContext.request.contextPath}/admin/logout">
                        <i class="bi bi-box-arrow-right me-1"></i>
                        Logout
                    </a>
                </li>

            </ul>
        </div>
    </div>
</nav>