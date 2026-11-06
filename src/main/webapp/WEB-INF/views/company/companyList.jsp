<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Registered Companies Management</title>

    <!-- Bootstrap 5 & Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f4f7fb;
            color: #142b46;
        }

        .card-table {
            border: 0;
            border-radius: 12px;
            box-shadow: 0 4px 14px rgba(20, 43, 70, 0.08);
            background: #ffffff;
        }

        .table th {
            background-color: #eaf3ff;
            color: #142b46;
            font-weight: 600;
            padding-top: 14px;
            padding-bottom: 14px;
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

    <!-- Admin Navbar Header -->
    <%@ include file="/WEB-INF/views/admin/adminNavbar.jsp" %>

    <div class="container-fluid px-4 px-lg-5 py-4 flex-grow-1">

        <!-- Header Section -->
        <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 gap-3">
            <div>
                <h2 class="fw-bold mb-1" style="color: #142b46;">Registered Companies</h2>
                <p class="text-secondary mb-0">Review, filter, and approve event delegation registration requests.</p>
            </div>

            <!-- View Toggle & Search/Filter Header Group -->
            <div class="d-flex gap-3 align-items-center flex-wrap">
                <!-- View Mode Toggle Buttons -->
                <div class="btn-group shadow-sm" role="group" aria-label="View Mode Toggle">
                    <button type="button" class="btn btn-outline-primary active" id="tableViewBtn" onclick="switchView('table')">
                        <i class="bi bi-table"></i> Table
                    </button>
                    <button type="button" class="btn btn-outline-primary" id="cardViewBtn" onclick="switchView('card')">
                        <i class="bi bi-grid-3x3-gap-fill"></i> Cards
                    </button>
                </div>

                <!-- Backend Search and Filter Form -->
                <form action="${pageContext.request.contextPath}/admin/companies" method="get" class="d-flex gap-2 flex-wrap align-items-center">
                    <div class="input-group" style="width: 260px;">
                        <span class="input-group-text bg-white border-end-0"><i class="bi bi-search text-muted"></i></span>
                        <input type="text" name="search" value="<c:out value='${search}'/>" class="form-control border-start-0 ps-0" placeholder="Search name, email, city...">
                    </div>

                    <div style="width: 150px;">
                        <select name="status" class="form-select" onchange="this.form.submit()">
                            <option value="">All Status</option>
                            <option value="PENDING_REVIEW" ${status == 'PENDING_REVIEW' ? 'selected' : ''}>Pending Review</option>
                            <option value="APPROVED" ${status == 'APPROVED' ? 'selected' : ''}>Approved</option>
                            <option value="REJECTED" ${status == 'REJECTED' ? 'selected' : ''}>Rejected</option>
                        </select>
                    </div>

                    <button type="submit" class="btn btn-primary-custom">
                        <i class="bi bi-funnel-fill me-1"></i> Filter
                    </button>
                    <a href="${pageContext.request.contextPath}/admin/companies" class="btn btn-outline-secondary">
                        Reset
                    </a>
                </form>
            </div>
        </div>

        <!-- 1. TABLE VIEW CONTAINER -->
        <div id="tableViewContainer" class="card card-table overflow-hidden mb-4">
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead>
                            <tr>
                                <th class="ps-4" style="width: 80px;">Sl. No.</th>
                                <th>Company Name</th>
                                <th>Email</th>
                                <th>Contact Number</th>
                                <th>GSTIN</th>
                                <th>City</th>
                                <th>Status</th>
                                <th class="text-center pe-4" style="width: 140px;">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty companies}">
                                    <c:forEach var="comp" items="${companies}" varStatus="statusVar">
                                        <c:set var="isProcessed" value="${comp.getReviewStatus() == 'APPROVED' || comp.getReviewStatus() == 'REJECTED'}" />
                                        <tr>
                                            <td class="ps-4 fw-semibold text-secondary">${statusVar.count}</td>
                                            <td>
                                                <div class="fw-bold"><c:out value="${comp.getCompanyName()}"/></div>
                                                <c:if test="${not empty comp.getEmployeeSize()}">
                                                    <small class="text-muted">Size: ${comp.getEmployeeSize()}</small>
                                                </c:if>
                                            </td>
                                            <td><c:out value="${comp.getEmail()}"/></td>
                                            <td><c:out value="${comp.getContactNumber()}"/></td>
                                            <td><code><c:out value="${comp.getGstinNumber()}"/></code></td>
                                            <td><c:out value="${comp.getCity()}"/><c:if test="${not empty comp.getState()}">, <c:out value="${comp.getState()}"/></c:if></td>
                                            <td>
                                                <span class="badge
                                                    <c:choose>
                                                        <c:when test='${comp.getReviewStatus() == "APPROVED"}'>badge-approved</c:when>
                                                        <c:when test='${comp.getReviewStatus() == "REJECTED"}'>badge-rejected</c:when>
                                                        <c:otherwise>badge-pending</c:otherwise>
                                                    </c:choose> px-2 py-1">
                                                    <c:out value="${comp.getReviewStatus()}"/>
                                                </span>
                                            </td>
                                            <td class="text-center pe-4">
                                                <div class="d-flex justify-content-center gap-1">
                                                    <!-- 1. Eye View Details Button -->
                                                    <button type="button" class="btn btn-sm btn-outline-info" title="View Full Details"
                                                            onclick="openDetailsModal('${comp.getId()}', '${comp.getCompanyName()}', '${comp.getEmail()}', '${comp.getContactNumber()}', '${comp.getEmployeeSize()}', '${comp.getGstinNumber()}', '${comp.getAddress()}', '${comp.getCountry()}', '${comp.getState()}', '${comp.getCity()}', '${comp.getPincode()}', '${comp.getMapLink()}', '${comp.getLogoName()}', '${comp.getReviewStatus()}')">
                                                        <i class="bi bi-eye"></i>
                                                    </button>

                                                    <!-- 2. Approve Button -->
                                                    <form action="${pageContext.request.contextPath}/admin/company/accept/${comp.getId()}" method="post" class="d-inline">
                                                        <button type="submit" class="btn btn-sm btn-outline-success ${isProcessed ? 'disabled' : ''}" title="Approve Request" ${isProcessed ? 'disabled' : ''}>
                                                            <i class="bi bi-check-lg"></i>
                                                        </button>
                                                    </form>

                                                    <!-- 3. Reject Button -->
                                                    <button type="button" class="btn btn-sm btn-outline-danger ${isProcessed ? 'disabled' : ''}" title="Reject Request"
                                                            <c:if test="${isProcessed}">disabled</c:if>
                                                            <c:if test="${!isProcessed}">onclick="handleReject('${comp.getId()}')"</c:if>>
                                                        <i class="bi bi-x-lg"></i>
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="8" class="text-center py-5 text-secondary">
                                            <i class="bi bi-inbox fs-2 d-block mb-2 text-muted"></i>
                                            No registered companies found.
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- 2. CARD / GRID VIEW CONTAINER (Hidden by default) -->
        <div id="cardViewContainer" class="row row-cols-1 row-cols-md-2 row-cols-xl-3 g-4 mb-4 d-none">
            <c:choose>
                <c:when test="${not empty companies}">
                    <c:forEach var="comp" items="${companies}">
                        <c:set var="isProcessed" value="${comp.getReviewStatus() == 'APPROVED' || comp.getReviewStatus() == 'REJECTED'}" />
                        <div class="col">
                            <div class="card border-0 shadow-sm rounded-4 h-100 position-relative bg-white">
                                <div class="card-body p-4">
                                    <div class="d-flex justify-content-between align-items-start mb-3">
                                        <div>
                                            <h5 class="fw-bold mb-1"><c:out value="${comp.getCompanyName()}"/></h5>
                                            <span class="badge
                                                <c:choose>
                                                    <c:when test='${comp.getReviewStatus() == "APPROVED"}'>badge-approved</c:when>
                                                    <c:when test='${comp.getReviewStatus() == "REJECTED"}'>badge-rejected</c:when>
                                                    <c:otherwise>badge-pending</c:otherwise>
                                                </c:choose> px-2 py-1">
                                                <c:out value="${comp.getReviewStatus()}"/>
                                            </span>
                                        </div>
                                        <c:if test="${not empty comp.getEmployeeSize()}">
                                            <span class="badge bg-light text-secondary border">Size: ${comp.getEmployeeSize()}</span>
                                        </c:if>
                                    </div>

                                    <p class="text-secondary small mb-2"><i class="bi bi-envelope me-1"></i> <c:out value="${comp.getEmail()}"/></p>
                                    <p class="text-secondary small mb-2"><i class="bi bi-telephone me-1"></i> <c:out value="${comp.getContactNumber()}"/></p>
                                    <p class="text-secondary small mb-2"><i class="bi bi-geo-alt me-1"></i> <c:out value="${comp.getCity()}"/><c:if test="${not empty comp.getState()}">, <c:out value="${comp.getState()}"/></c:if></p>
                                    <p class="text-secondary small mb-3"><strong>GSTIN:</strong> <code><c:out value="${comp.getGstinNumber()}"/></code></p>

                                    <div class="d-flex justify-content-between align-items-center pt-3 border-top">
                                        <button type="button" class="btn btn-sm btn-outline-info px-3"
                                                onclick="openDetailsModal('${comp.getId()}', '${comp.getCompanyName()}', '${comp.getEmail()}', '${comp.getContactNumber()}', '${comp.getEmployeeSize()}', '${comp.getGstinNumber()}', '${comp.getAddress()}', '${comp.getCountry()}', '${comp.getState()}', '${comp.getCity()}', '${comp.getPincode()}', '${comp.getMapLink()}', '${comp.getLogoName()}', '${comp.getReviewStatus()}')">
                                            <i class="bi bi-eye me-1"></i> View Details
                                        </button>

                                        <div class="d-flex gap-1">
                                            <form action="${pageContext.request.contextPath}/admin/company/accept/${comp.getId()}" method="post" class="d-inline">
                                                <button type="submit" class="btn btn-sm btn-outline-success ${isProcessed ? 'disabled' : ''}" title="Approve" ${isProcessed ? 'disabled' : ''}>
                                                    <i class="bi bi-check-lg"></i>
                                                </button>
                                            </form>
                                            <button type="button" class="btn btn-sm btn-outline-danger ${isProcessed ? 'disabled' : ''}" title="Reject"
                                                    <c:if test="${isProcessed}">disabled</c:if>
                                                    <c:if test="${!isProcessed}">onclick="handleReject('${comp.getId()}')"</c:if>>
                                                <i class="bi bi-x-lg"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="col-12 text-center py-5 text-secondary">
                        <i class="bi bi-inbox fs-2 d-block mb-2 text-muted"></i>
                        No registered companies found.
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- 3. Smart Compact Pagination Component (Prevents 10k items horizontal overflow) -->
        <c:if test="${pagination.totalPages > 1}">
            <nav class="mt-4">
                <ul class="pagination justify-content-center">

                    <!-- Previous Button -->
                    <li class="page-item ${pagination.currentPage == 0 ? 'disabled' : ''}">
                        <a class="page-link" href="?page=${pagination.currentPage - 1}&search=${search}&status=${status}">
                            <i class="bi bi-chevron-left"></i> Previous
                        </a>
                    </li>

                    <c:set var="curr" value="${pagination.currentPage}" />
                    <c:set var="total" value="${pagination.totalPages}" />

                    <!-- First Page & Ellipsis -->
                    <c:if test="${curr > 2}">
                        <li class="page-item">
                            <a class="page-link" href="?page=0&search=${search}&status=${status}">1</a>
                        </li>
                        <c:if test="${curr > 3}">
                            <li class="page-item disabled"><span class="page-link">...</span></li>
                        </c:if>
                    </c:if>

                    <!-- Surrounding Pages Window -->
                    <c:forEach begin="0" end="${total - 1}" var="i">
                        <c:if test="${i >= curr - 2 && i <= curr + 2}">
                            <li class="page-item ${curr == i ? 'active' : ''}">
                                <a class="page-link" href="?page=${i}&search=${search}&status=${status}">${i + 1}</a>
                            </li>
                        </c:if>
                    </c:forEach>

                    <!-- Ellipsis & Last Page -->
                    <c:if test="${curr < total - 3}">
                        <li class="page-item disabled"><span class="page-link">...</span></li>
                        <li class="page-item">
                            <a class="page-link" href="?page=${total - 1}&search=${search}&status=${status}">${total}</a>
                        </li>
                    </c:if>

                    <!-- Next Button -->
                    <li class="page-item ${pagination.currentPage == pagination.totalPages - 1 ? 'disabled' : ''}">
                        <a class="page-link" href="?page=${pagination.currentPage + 1}&search=${search}&status=${status}">
                            Next <i class="bi bi-chevron-right"></i>
                        </a>
                    </li>

                </ul>
            </nav>
        </c:if>

    </div>

    <!-- Company Full Details Modal -->
    <div class="modal fade" id="companyDetailsModal" tabindex="-1" aria-labelledby="companyModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content border-0 shadow">
                <div class="modal-header bg-light">
                    <h5 class="modal-title fw-bold" id="companyModalLabel">
                        <i class="bi bi-building me-2 text-primary"></i>Company Full Details
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-4">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="text-secondary small fw-semibold">Company Name</label>
                            <div id="mCompanyName" class="fw-bold fs-5"></div>
                        </div>
                        <div class="col-md-6">
                            <label class="text-secondary small fw-semibold">Review Status</label>
                            <div><span id="mReviewStatus" class="badge"></span></div>
                        </div>

                        <div class="col-md-6">
                            <label class="text-secondary small fw-semibold">Email Address</label>
                            <div id="mEmail" class="fw-semibold"></div>
                        </div>
                        <div class="col-md-6">
                            <label class="text-secondary small fw-semibold">Contact Number</label>
                            <div id="mContactNumber" class="fw-semibold"></div>
                        </div>

                        <div class="col-md-6">
                            <label class="text-secondary small fw-semibold">GSTIN Number</label>
                            <div><code id="mGstinNumber" class="fs-6"></code></div>
                        </div>
                        <div class="col-md-6">
                            <label class="text-secondary small fw-semibold">Employee Size</label>
                            <div id="mEmployeeSize"></div>
                        </div>

                        <div class="col-12">
                            <label class="text-secondary small fw-semibold">Street Address</label>
                            <div id="mAddress"></div>
                        </div>

                        <div class="col-md-4">
                            <label class="text-secondary small fw-semibold">Country</label>
                            <div id="mCountry"></div>
                        </div>
                        <div class="col-md-4">
                            <label class="text-secondary small fw-semibold">State</label>
                            <div id="mState"></div>
                        </div>
                        <div class="col-md-4">
                            <label class="text-secondary small fw-semibold">City & Pincode</label>
                            <div id="mCityPincode"></div>
                        </div>

                        <div class="col-md-6">
                            <label class="text-secondary small fw-semibold">Google Map Location</label>
                            <div><a id="mMapLink" href="#" target="_blank" class="text-decoration-none">Open Map <i class="bi bi-box-arrow-up-right small"></i></a></div>
                        </div>
                        <div class="col-md-6">
                            <label class="text-secondary small fw-semibold">Logo Filename</label>
                            <div>
                                <span id="mLogoName" class="text-muted"></span>
                                <a id="mViewLogoLink" href="#" class="btn btn-sm btn-outline-primary ms-2 d-none" onclick="openLogoImageModal(event)">
                                    <i class="bi bi-image me-1"></i>View Logo
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer bg-light d-flex justify-content-between">
                    <button type="button" class="btn btn-secondary px-4" data-bs-dismiss="modal">Close</button>
                    <div class="d-flex gap-2">
                        <button type="button" class="btn btn-danger px-4" id="modalRejectBtn">Reject</button>
                        <form id="modalApproveForm" method="post">
                            <button type="submit" class="btn btn-success px-4" id="modalApproveBtn">Approve</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Separate Logo Preview Modal -->
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
                    <img id="modalLogoImage" src="" alt="Company Logo" class="img-fluid rounded border shadow-sm" style="max-height: 350px;">
                </div>
                <div class="modal-footer bg-light">
                    <button type="button" class="btn btn-secondary px-4" data-bs-dismiss="modal">Close Preview</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Rejection Feedback Modal -->
    <div class="modal fade" id="rejectFeedbackModal" tabindex="-1" aria-labelledby="rejectModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content border-0 shadow">
                <div class="modal-header bg-danger text-white">
                    <h5 class="modal-title fw-bold" id="rejectModalLabel">
                        <i class="bi bi-x-circle-fill me-2"></i>Reject Company Registration
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form id="rejectForm" method="post">
                    <div class="modal-body p-4">
                        <p class="text-secondary small mb-3">
                            Please provide a reason for rejecting this company. This feedback will be recorded.
                        </p>
                       <div class="mb-3">
                           <label for="rejectFeedback" class="form-label fw-semibold">Rejection Reason <span class="text-danger">*</span></label>
                           <textarea class="form-control" id="rejectFeedback" name="rejectFeedback" rows="4" placeholder="Enter reason for rejection (min 8 characters)..." minlength="8" maxlength="1000" required></textarea>
                           <div class="invalid-feedback" id="feedbackErrorMsg">Rejection feedback must be between 8 and 1000 characters.</div>
                       </div>
                    </div>
                    <div class="modal-footer bg-light">
                        <button type="button" class="btn btn-secondary px-4" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-danger px-4">Confirm Rejection</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Common Footer Include -->
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>

    <!-- Bootstrap 5 JavaScript Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        const contextPath = "${pageContext.request.contextPath}";
        let currentLogoUrl = "";

        // View Mode Switcher Function
        function switchView(mode) {
            const tableView = document.getElementById('tableViewContainer');
            const cardView = document.getElementById('cardViewContainer');
            const tableBtn = document.getElementById('tableViewBtn');
            const cardBtn = document.getElementById('cardViewBtn');

            if (mode === 'card') {
                tableView.classList.add('d-none');
                cardView.classList.remove('d-none');
                cardBtn.classList.add('active');
                tableBtn.classList.remove('active');
                localStorage.setItem('adminCompanyViewPreference', 'card');
            } else {
                cardView.classList.add('d-none');
                tableView.classList.remove('d-none');
                tableBtn.classList.add('active');
                cardBtn.classList.remove('active');
                localStorage.setItem('adminCompanyViewPreference', 'table');
            }
        }

        // Restore view preference on page load
        document.addEventListener('DOMContentLoaded', () => {
            const savedPref = localStorage.getItem('adminCompanyViewPreference');
            if (savedPref === 'card') {
                switchView('card');
            }
        });

        function openDetailsModal(id, name, email, contact, empSize, gstin, address, country, state, city, pincode, mapLink, logoName, status) {
            document.getElementById('mCompanyName').textContent = name;
            document.getElementById('mEmail').textContent = email;
            document.getElementById('mContactNumber').textContent = contact;
            document.getElementById('mEmployeeSize').textContent = empSize ? empSize : 'N/A';
            document.getElementById('mGstinNumber').textContent = gstin ? gstin : 'N/A';
            document.getElementById('mAddress').textContent = address ? address : 'N/A';
            document.getElementById('mCountry').textContent = country ? country : 'N/A';
            document.getElementById('mState').textContent = state ? state : 'N/A';
            document.getElementById('mCityPincode').textContent = (city ? city : '') + (pincode ? ' - ' + pincode : '');

            const mapA = document.getElementById('mMapLink');
            if (mapLink && mapLink !== 'null' && mapLink !== '') {
                mapA.href = mapLink;
                mapA.textContent = 'View Location';
                mapA.style.pointerEvents = 'auto';
            } else {
                mapA.href = '#';
                mapA.textContent = 'N/A';
                mapA.style.pointerEvents = 'none';
            }

            const logoSpan = document.getElementById('mLogoName');
            const viewLogoBtn = document.getElementById('mViewLogoLink');

            if (logoName && logoName !== 'null' && logoName !== '') {
                logoSpan.textContent = logoName;
                currentLogoUrl = contextPath + '/admin/company/logo/' + logoName;
                viewLogoBtn.classList.remove('d-none');
            } else {
                logoSpan.textContent = 'No logo uploaded';
                currentLogoUrl = "";
                viewLogoBtn.classList.add('d-none');
            }

            const statusBadge = document.getElementById('mReviewStatus');
            statusBadge.textContent = status ? status : 'PENDING_REVIEW';
            statusBadge.className = 'badge ' + (status === 'APPROVED' ? 'badge-approved' : (status === 'REJECTED' ? 'badge-rejected' : 'badge-pending'));

            const approveBtn = document.getElementById('modalApproveBtn');
            const rejectBtn = document.getElementById('modalRejectBtn');

            if (status === 'APPROVED' || status === 'REJECTED') {
                approveBtn.disabled = true;
                approveBtn.classList.add('disabled');
                rejectBtn.disabled = true;
                rejectBtn.classList.add('disabled');
            } else {
                approveBtn.disabled = false;
                approveBtn.classList.remove('disabled');
                rejectBtn.disabled = false;
                rejectBtn.classList.remove('disabled');
            }

            document.getElementById('modalApproveForm').action = contextPath + '/admin/company/accept/' + id;

            document.getElementById('modalRejectBtn').onclick = function() {
                var detailsModalEl = document.getElementById('companyDetailsModal');
                var detailsModal = bootstrap.Modal.getInstance(detailsModalEl);
                if (detailsModal) detailsModal.hide();
                handleReject(id);
            };

            var myModal = new bootstrap.Modal(document.getElementById('companyDetailsModal'));
            myModal.show();
        }

        function openLogoImageModal(event) {
            event.preventDefault();
            if (currentLogoUrl) {
                document.getElementById('modalLogoImage').src = currentLogoUrl;
                var logoModal = new bootstrap.Modal(document.getElementById('logoPreviewModal'));
                logoModal.show();
            }
        }

        function handleReject(companyId) {
            const rejectForm = document.getElementById('rejectForm');
            const feedbackInput = document.getElementById('rejectFeedback');

            rejectForm.action = contextPath + '/admin/company/reject/' + companyId;

            feedbackInput.value = '';
            feedbackInput.classList.remove('is-invalid');

            var rejectModal = new bootstrap.Modal(document.getElementById('rejectFeedbackModal'));
            rejectModal.show();
        }

        document.getElementById('rejectForm').addEventListener('submit', function(event) {
            const feedbackInput = document.getElementById('rejectFeedback');
            const value = feedbackInput.value.trim();
            const errorMsg = document.getElementById('feedbackErrorMsg');

            if (!value || value.length < 8 || value.length > 1000) {
                event.preventDefault();
                feedbackInput.classList.add('is-invalid');

                if (!value) {
                    errorMsg.textContent = "Rejection feedback is required.";
                } else if (value.length < 8) {
                    errorMsg.textContent = "Rejection reason must be at least 8 characters long.";
                } else {
                    errorMsg.textContent = "Rejection reason cannot exceed 1000 characters.";
                }

                feedbackInput.focus();
            } else {
                feedbackInput.classList.remove('is-invalid');
            }
        });
    </script>
</body>
</html>