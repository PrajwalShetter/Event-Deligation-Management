<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Company Dashboard</title>

    <!-- Bootstrap 5 & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f4f7fb;
            color: #142b46;
        }
        .dashboard-card {
            border: 0;
            border-radius: 12px;
            box-shadow: 0 4px 14px rgba(20, 43, 70, 0.06);
            background: #ffffff;
        }
        .btn-primary-custom {
            background-color: #1769e8;
            border-color: #1769e8;
            color: #ffffff;
        }
        .btn-primary-custom:hover {
            background-color: #1255c2;
            border-color: #1255c2;
            color: #ffffff;
        }
    </style>
</head>
<body class="d-flex flex-column min-vh-100">

    <!-- Include Company Navbar -->
    <%@ include file="/WEB-INF/views/company/companyNavbar.jsp" %>

    <!-- Main Dashboard Container -->
    <main class="container-fluid px-4 px-lg-5 py-5 flex-grow-1">

        <!-- Welcome Banner Section -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="card dashboard-card p-4 p-md-5 bg-white border-0">
                    <div class="d-flex flex-wrap justify-content-between align-items-center gap-3">
                        <div>
                            <span class="badge bg-success-subtle text-success fw-bold px-3 py-2 mb-2 rounded-pill">
                                <i class="bi bi-check-circle-fill me-1"></i> Verified & Active Session
                            </span>
                            <h1 class="fw-bold display-6 mb-1">Welcome Back!</h1>
                            <p class="text-secondary mb-0">You are successfully logged in as <strong><c:out value="${sessionScope.loggedInCompanyEmail}"/></strong>.</p>
                        </div>
                        <div>
                            <a href="${pageContext.request.contextPath}/company/logout" class="btn btn-outline-danger px-4">
                                <i class="bi bi-box-arrow-right me-1"></i> Logout
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Quick Summary Metrics / Cards Grid -->
        <div class="row row-cols-1 row-cols-md-3 g-4">
            <!-- Card 1: Account Overview -->
            <div class="col">
                <div class="card dashboard-card h-100 p-4">
                    <div class="d-flex align-items-center gap-3 mb-3">
                        <div class="bg-primary-subtle text-primary p-3 rounded-4 fs-4">
                            <i class="bi bi-shield-check"></i>
                        </div>
                        <div>
                            <h5 class="fw-bold mb-0">Account Status</h5>
                            <small class="text-muted">Approved & Secure</small>
                        </div>
                    </div>
                    <p class="text-secondary small mb-3">Your organization profile has cleared all administrative reviews and has full access to platform features.</p>
                </div>
            </div>

            <!-- Card 2: Event Delegations -->
            <div class="col">
                <div class="card dashboard-card h-100 p-4">
                    <div class="d-flex align-items-center gap-3 mb-3">
                        <div class="bg-success-subtle text-success p-3 rounded-4 fs-4">
                            <i class="bi bi-calendar-event"></i>
                        </div>
                        <div>
                            <h5 class="fw-bold mb-0">Event Delegations</h5>
                            <small class="text-muted">Active Management</small>
                        </div>
                    </div>
                    <p class="text-secondary small mb-3">Manage your company representatives, schedules, and event allocations seamlessly from this portal.</p>
                </div>
            </div>

            <!-- Card 3: Security & Profile -->
            <div class="col">
                <div class="card dashboard-card h-100 p-4">
                    <div class="d-flex align-items-center gap-3 mb-3">
                        <div class="bg-warning-subtle text-warning-emphasis p-3 rounded-4 fs-4">
                            <i class="bi bi-key"></i>
                        </div>
                        <div>
                            <h5 class="fw-bold mb-0">Authentication</h5>
                            <small class="text-muted">OTP Secured</small>
                        </div>
                    </div>
                    <p class="text-secondary small mb-3">Your sessions are protected via time-sensitive 2-minute OTP verifications ensuring maximum enterprise safety.</p>
                </div>
            </div>
        </div>

    </main>

    <!-- Include Footer -->
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>

    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>