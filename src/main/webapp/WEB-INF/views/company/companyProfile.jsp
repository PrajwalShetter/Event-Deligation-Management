

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Company Dashboard & Profile</title>

    <!-- Bootstrap 5 & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f4f7fb;
            color: #142b46;
        }
        .profile-card {
            border: 0;
            border-radius: 16px;
            box-shadow: 0 4px 20px rgba(20, 43, 70, 0.08);
            background: #ffffff;
        }
        .profile-header-bg {
            background: linear-gradient(135deg, #1769e8, #1255c2);
            color: white;
            border-radius: 16px 16px 0 0;
            padding: 30px;
        }
        .company-logo-img {
            width: 70px;
            height: 70px;
            object-fit: cover;
            border-radius: 12px;
            border: 2px solid rgba(255, 255, 255, 0.8);
            background-color: #ffffff;
        }
        .badge-pending {
            background-color: #ffc107;
            color: #212529;
            font-weight: 600;
        }
        .badge-approved {
            background-color: #198754;
            color: #ffffff;
            font-weight: 600;
        }
        .badge-rejected {
            background-color: #dc3545;
            color: #ffffff;
            font-weight: 600;
        }
        .info-label {
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: #6c757d;
            font-weight: 600;
        }
        .info-value {
            font-size: 1.05rem;
            font-weight: 600;
            color: #142b46;
        }
    </style>
</head>
<body class="d-flex flex-column min-vh-100">

    <!-- Include Company Navbar -->
    <jsp:include page="companyNavbar.jsp"/>

    <!-- Main Content Area -->
    <main class="container py-5 flex-grow-1" style="max-width: 900px;">

        <!-- Page Header -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h2 class="fw-bold mb-1">Company Dashboard</h2>
                <p class="text-secondary mb-0">Overview of your registered business details and organization account.</p>
            </div>
            <div>
                <a href="${pageContext.request.contextPath}/company/logout" class="btn btn-outline-danger shadow-sm px-4">
                    <i class="bi bi-box-arrow-right me-1"></i> Logout
                </a>
            </div>
        </div>

        <!-- Main Profile Card -->
        <div class="card profile-card overflow-hidden">

            <!-- Header Section inside Card -->
            <div class="profile-header-bg d-flex flex-wrap justify-content-between align-items-center gap-3">
                <div class="d-flex align-items-center gap-3">
                    <!-- Logo Display Logic -->
                    <c:choose>
                        <c:when test="${not empty company.getLogoName()}">
                            <img src="${pageContext.request.contextPath}/admin/company/logo/${company.getLogoName()}"
                                 alt="Company Logo"
                                 class="company-logo-img shadow-sm cursor-pointer"
                                 title="Click to view full logo"
                                 data-bs-toggle="modal"
                                 data-bs-target="#logoPreviewModal">
                        </c:when>
                        <c:otherwise>
                            <div class="bg-white text-primary p-3 rounded-4 shadow-sm fs-2 d-flex align-items-center justify-content-center" style="width: 70px; height: 70px;">
                                <i class="bi bi-building"></i>
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <div>
                        <h3 class="fw-bold mb-1"><c:out value="${company.getCompanyName()}"/></h3>
                        <p class="mb-0 opacity-75"><i class="bi bi-envelope me-1"></i> <c:out value="${company.getEmail()}"/></p>
                    </div>
                </div>
                <div>
                    <span class="badge
                        <c:choose>
                            <c:when test='${company.getReviewStatus() == "APPROVED"}'>badge-approved</c:when>
                            <c:when test='${company.getReviewStatus() == "REJECTED"}'>badge-rejected</c:when>
                            <c:otherwise>badge-pending</c:otherwise>
                        </c:choose> px-3 py-2 fs-6 shadow-sm rounded-pill">
                        <c:out value="${company.getReviewStatus()}"/>
                    </span>
                </div>
            </div>

            <!-- Body Details Grid -->
            <div class="card-body p-4 p-md-5">
                <div class="row g-4">

                    <div class="col-md-6">
                        <div class="info-label mb-1">Contact Number</div>
                        <div class="info-value"><i class="bi bi-telephone text-primary me-2"></i><c:out value="${company.getContactNumber()}"/></div>
                    </div>

                    <div class="col-md-6">
                        <div class="info-label mb-1">Employee Size</div>
                        <div class="info-value"><i class="bi bi-people text-primary me-2"></i><c:out value="${company.getEmployeeSize()}"/></div>
                    </div>

                    <div class="col-md-6">
                        <div class="info-label mb-1">GSTIN Number</div>
                        <div class="info-value"><i class="bi bi-file-earmark-text text-primary me-2"></i><code><c:out value="${company.getGstinNumber()}"/></code></div>
                    </div>

                    <div class="col-md-6">
                        <div class="info-label mb-1">Location (City, State)</div>
                        <div class="info-value"><i class="bi bi-geo-alt text-primary me-2"></i><c:out value="${company.getCity()}"/>, <c:out value="${company.getState()}"/></div>
                    </div>

                    <div class="col-12">
                        <hr class="text-muted opacity-25 my-2">
                    </div>

                    <div class="col-md-8">
                        <div class="info-label mb-1">Street Address</div>
                        <div class="info-value text-secondary"><c:out value="${company.getAddress()}"/></div>
                    </div>

                    <div class="col-md-4">
                        <div class="info-label mb-1">Country & Pincode</div>
                        <div class="info-value"><c:out value="${company.getCountry()}"/> - <c:out value="${company.getPincode()}"/></div>
                    </div>

                    <c:if test="${not empty company.getMapLink()}">
                        <div class="col-12 mt-2">
                            <div class="info-label mb-1">Google Maps Location</div>
                            <div>
                                <a href="<c:out value='${company.getMapLink()}'/>" target="_blank" class="text-decoration-none fw-semibold">
                                    <i class="bi bi-map-fill text-primary me-1"></i> Open Location in Map <i class="bi bi-box-arrow-up-right small"></i>
                                </a>
                            </div>
                        </div>
                    </c:if>

                </div>
            </div>
        </div>

    </main>

    <!-- Logo Preview Modal -->
    <c:if test="${not empty company.getLogoName()}">
        <div class="modal fade" id="logoPreviewModal" tabindex="-1" aria-labelledby="logoModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content border-0 shadow text-center">
                    <div class="modal-header bg-light">
                        <h5 class="modal-title fw-bold" id="logoModalLabel">
                            <i class="bi bi-image me-2 text-primary"></i>Company Logo Preview
                        </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body p-4 text-center">
                        <img src="${pageContext.request.contextPath}/admin/company/logo/${company.getLogoName()}" alt="Company Logo" class="img-fluid rounded border shadow-sm" style="max-height: 350px;">
                    </div>
                    <div class="modal-footer bg-light">
                        <button type="button" class="btn btn-secondary px-4" data-bs-dismiss="modal">Close Preview</button>
                    </div>
                </div>
            </div>
        </div>
    </c:if>

    <!-- Include Footer -->
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>