<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Event Delegation Management System</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
          rel="stylesheet">
</head>

<body class="d-flex flex-column min-vh-100 bg-light">

    <!-- Navbar -->
    <%@ include file="common/navbar.jsp" %>

    <main class="flex-grow-1">

        <!-- SECTION 1: HERO -->
        <section class="bg-dark text-white py-5">
            <div class="container py-5">
                <div class="row align-items-center g-5">

                    <div class="col-lg-7">
                        <span class="badge bg-primary mb-3 px-3 py-2">
                            EVENT DELEGATION MANAGEMENT
                        </span>

                        <h1 class="display-4 fw-bold mb-4">
                            Every Event Begins
                            <span class="text-info">With the Right Connection.</span>
                        </h1>

                        <p class="lead text-white-50 mb-4">
                            A centralized platform to connect companies,
                            manage event delegates, organize employee
                            information and simplify event communication.
                        </p>

                        <div class="d-flex flex-wrap gap-3">
                            <a href="${pageContext.request.contextPath}/company/register"
                               class="btn btn-primary btn-lg">
                                Register Your Company
                                <i class="bi bi-arrow-right ms-2"></i>
                            </a>

                            <a href="${pageContext.request.contextPath}/login"
                               class="btn btn-outline-light btn-lg">
                                Sign In
                            </a>
                        </div>
                    </div>

                    <div class="col-lg-5">
                        <!-- Add your hero image here -->
                        <div class="bg-secondary rounded-4 p-5 text-center">
                            <i class="bi bi-calendar2-event display-1 text-white"></i>
                            <h4 class="mt-3">Your Events. One Platform.</h4>
                            <p class="mb-0 text-white-50">
                                Plan, connect and communicate.
                            </p>
                        </div>
                    </div>

                </div>
            </div>
        </section>


        <!-- SECTION 2: INTRODUCTION -->
        <section class="py-5 bg-white">
            <div class="container py-4">

                <div class="text-center mb-5">
                    <span class="text-primary fw-semibold">ABOUT OUR PLATFORM</span>
                    <h2 class="fw-bold mt-2">Simplifying Event Coordination</h2>
                    <p class="text-secondary mx-auto mt-3"
                       style="max-width: 750px;">
                        Manage company participation and delegate information
                        through one organized system designed to reduce
                        manual work and improve communication.
                    </p>
                </div>

                <div class="row g-4">

                    <div class="col-md-4">
                        <div class="card h-100 border-0 shadow-sm rounded-4">
                            <div class="card-body p-4 text-center">
                                <i class="bi bi-building display-5 text-primary"></i>
                                <h5 class="fw-bold mt-3">Company Management</h5>
                                <p class="text-secondary mb-0">
                                    Maintain company information and manage
                                    company registration through a centralized
                                    platform.
                                </p>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="card h-100 border-0 shadow-sm rounded-4">
                            <div class="card-body p-4 text-center">
                                <i class="bi bi-people display-5 text-primary"></i>
                                <h5 class="fw-bold mt-3">Delegate Management</h5>
                                <p class="text-secondary mb-0">
                                    Organize employee information and process
                                    eligible delegate lists uploaded by
                                    participating companies.
                                </p>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="card h-100 border-0 shadow-sm rounded-4">
                            <div class="card-body p-4 text-center">
                                <i class="bi bi-envelope-check display-5 text-primary"></i>
                                <h5 class="fw-bold mt-3">Smart Communication</h5>
                                <p class="text-secondary mb-0">
                                    Simplify event invitations and scheduled
                                    follow-up communication with delegates.
                                </p>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </section>


        <!-- SECTION 3: HOW IT WORKS -->
        <section class="py-5 bg-light">
            <div class="container py-4">

                <div class="text-center mb-5">
                    <span class="text-primary fw-semibold">OUR PROCESS</span>
                    <h2 class="fw-bold mt-2">How It Works</h2>
                    <p class="text-secondary">
                        A simple workflow for companies and administrators.
                    </p>
                </div>

                <div class="row g-4">

                    <div class="col-md-3">
                        <div class="bg-white rounded-4 shadow-sm p-4 h-100">
                            <span class="badge bg-primary rounded-pill mb-3">01</span>
                            <h5 class="fw-bold">Company Registration</h5>
                            <p class="text-secondary mb-0">
                                Companies submit their details and wait for
                                administrator approval.
                            </p>
                        </div>
                    </div>

                    <div class="col-md-3">
                        <div class="bg-white rounded-4 shadow-sm p-4 h-100">
                            <span class="badge bg-primary rounded-pill mb-3">02</span>
                            <h5 class="fw-bold">Employee Upload</h5>
                            <p class="text-secondary mb-0">
                                Approved companies upload Excel files
                                containing eligible employees.
                            </p>
                        </div>
                    </div>

                    <div class="col-md-3">
                        <div class="bg-white rounded-4 shadow-sm p-4 h-100">
                            <span class="badge bg-primary rounded-pill mb-3">03</span>
                            <h5 class="fw-bold">Email Communication</h5>
                            <p class="text-secondary mb-0">
                                The system supports event invitations
                                and scheduled follow-up emails.
                            </p>
                        </div>
                    </div>

                    <div class="col-md-3">
                        <div class="bg-white rounded-4 shadow-sm p-4 h-100">
                            <span class="badge bg-primary rounded-pill mb-3">04</span>
                            <h5 class="fw-bold">Track Progress</h5>
                            <p class="text-secondary mb-0">
                                Administrators monitor company information,
                                uploaded records and email activity.
                            </p>
                        </div>
                    </div>

                </div>
            </div>
        </section>


        <!-- SECTION 4: BENEFITS -->
        <section class="py-5 bg-white">
            <div class="container py-4">
                <div class="row align-items-center g-5">

                    <div class="col-lg-6">
                        <!-- Add your own photo or illustration here -->
                        <div class="bg-light rounded-4 p-5 text-center">
                            <i class="bi bi-diagram-3 display-1 text-primary"></i>
                            <h5 class="mt-3">Connected. Organized. Efficient.</h5>
                        </div>
                    </div>

                    <div class="col-lg-6">
                        <span class="text-primary fw-semibold">
                            WHY CHOOSE OUR PLATFORM?
                        </span>

                        <h2 class="fw-bold mt-2 mb-4">
                            Everything Organized in One Place
                        </h2>

                        <div class="d-flex gap-3 mb-4">
                            <i class="bi bi-check-circle-fill text-success fs-4"></i>
                            <div>
                                <h6 class="fw-bold">Centralized Information</h6>
                                <p class="text-secondary mb-0">
                                    Keep company and delegate information
                                    organized in one system.
                                </p>
                            </div>
                        </div>

                        <div class="d-flex gap-3 mb-4">
                            <i class="bi bi-check-circle-fill text-success fs-4"></i>
                            <div>
                                <h6 class="fw-bold">Reduced Manual Work</h6>
                                <p class="text-secondary mb-0">
                                    Simplify employee data imports and
                                    recurring email communication.
                                </p>
                            </div>
                        </div>

                        <div class="d-flex gap-3">
                            <i class="bi bi-check-circle-fill text-success fs-4"></i>
                            <div>
                                <h6 class="fw-bold">Better Visibility</h6>
                                <p class="text-secondary mb-0">
                                    Make it easier for administrators to
                                    monitor ongoing event activities.
                                </p>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </section>


        <!-- SECTION 5: CALL TO ACTION -->
        <section class="bg-primary text-white py-5">
            <div class="container py-4 text-center">

                <i class="bi bi-calendar2-check display-3"></i>

                <h2 class="fw-bold mt-3">
                    Ready to Get Started?
                </h2>

                <p class="lead text-white-50 mx-auto my-3"
                   style="max-width: 650px;">
                    Join the platform to simplify company participation,
                    delegate management and event communication.
                </p>

                <div class="d-flex justify-content-center flex-wrap gap-3 mt-4">
                    <a href="${pageContext.request.contextPath}/company/register"
                       class="btn btn-light btn-lg">
                        Register Your Company
                    </a>

                    <a href="${pageContext.request.contextPath}/login"
                       class="btn btn-outline-light btn-lg">
                        Existing User Login
                    </a>
                </div>

            </div>
        </section>

    </main>

    <!-- Footer -->
    <%@ include file="common/footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>