<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Admin Dashboard</title>

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
        rel="stylesheet">
</head>

<body class="d-flex flex-column min-vh-100 bg-light">

    <!-- Common Navbar -->
    <%@ include file="/WEB-INF/views/admin/adminNavbar.jsp" %>

    <main class="flex-grow-1">

        <!-- Dashboard Header -->
        <section class="bg-primary text-white py-5">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-md-8">
                        <p class="text-white-50 mb-2">ADMIN PANEL</p>

                        <h1 class="fw-bold mb-3">
                            Welcome to Admin Dashboard
                        </h1>

                        <p class="mb-0">
                            Manage companies, events, employee eligibility
                            uploads, and email activities from one place.
                        </p>
                    </div>

                    <div class="col-md-4 text-md-end mt-4 mt-md-0">
                        <i class="bi bi-speedometer2"
                           style="font-size: 5rem;"></i>
                    </div>
                </div>
            </div>
        </section>

        <!-- Dashboard Content -->
        <section class="container py-5">

            <div class="mb-4">
                <h3 class="fw-bold">Dashboard Overview</h3>
                <p class="text-secondary">
                    Select a section to manage your system.
                </p>
            </div>

            <div class="row g-4">

                <!-- Companies -->
                <div class="col-md-6 col-lg-3">
                    <div class="card h-100 border-0 shadow-sm">
                        <div class="card-body p-4">
                            <div class="text-primary mb-3">
                                <i class="bi bi-buildings fs-1"></i>
                            </div>

                            <h5 class="fw-bold">Companies</h5>

                            <p class="text-secondary small">
                                View registered companies and manage
                                registration approvals.
                            </p>

                            <a href="${pageContext.request.contextPath}/admin/companies"
                               class="btn btn-outline-primary btn-sm mt-2">
                                Manage Companies
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Events -->
                <div class="col-md-6 col-lg-3">
                    <div class="card h-100 border-0 shadow-sm">
                        <div class="card-body p-4">
                            <div class="text-success mb-3">
                                <i class="bi bi-calendar-event fs-1"></i>
                            </div>

                            <h5 class="fw-bold">Events</h5>

                            <p class="text-secondary small">
                                Create and manage events and their
                                associated details.
                            </p>

                            <a href="${pageContext.request.contextPath}/admin/events"
                               class="btn btn-outline-success btn-sm mt-2">
                                Manage Events
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Employee Uploads -->
                <div class="col-md-6 col-lg-3">
                    <div class="card h-100 border-0 shadow-sm">
                        <div class="card-body p-4">
                            <div class="text-warning mb-3">
                                <i class="bi bi-file-earmark-spreadsheet fs-1"></i>
                            </div>

                            <h5 class="fw-bold">Employee Uploads</h5>

                            <p class="text-secondary small">
                                Review employee Excel uploads and
                                eligibility validation results.
                            </p>

                            <a href="${pageContext.request.contextPath}/admin/uploads"
                               class="btn btn-outline-warning btn-sm mt-2">
                                View Uploads
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Email Activity -->
                <div class="col-md-6 col-lg-3">
                    <div class="card h-100 border-0 shadow-sm">
                        <div class="card-body p-4">
                            <div class="text-info mb-3">
                                <i class="bi bi-envelope-check fs-1"></i>
                            </div>

                            <h5 class="fw-bold">Email Activity</h5>

                            <p class="text-secondary small">
                                Review automated email notifications
                                and follow-up activity.
                            </p>

                            <a href="${pageContext.request.contextPath}/admin/emails"
                               class="btn btn-outline-info btn-sm mt-2">
                                View Emails
                            </a>
                        </div>
                    </div>
                </div>

            </div>

            <!-- Quick Actions -->
            <div class="card border-0 shadow-sm mt-5">
                <div class="card-body p-4">
                    <h5 class="fw-bold mb-3">Quick Actions</h5>

                    <div class="d-flex flex-wrap gap-2">
                        <a href="${pageContext.request.contextPath}/admin/companies"
                           class="btn btn-primary">
                            <i class="bi bi-building-check me-1"></i>
                            Review Companies
                        </a>

                        <a href="${pageContext.request.contextPath}/admin/events"
                           class="btn btn-outline-primary">
                            <i class="bi bi-calendar-plus me-1"></i>
                            Manage Events
                        </a>

                        <a href="${pageContext.request.contextPath}/admin/uploads"
                           class="btn btn-outline-secondary">
                            <i class="bi bi-file-earmark-arrow-up me-1"></i>
                            Check Uploads
                        </a>
                    </div>
                </div>
            </div>

        </section>

    </main>

    <!-- Common Footer -->
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>