<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Company Login - Email Verification</title>

    <!-- Bootstrap 5 & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

    <style>
        body {
            background-color: #f1f5fa;
            color: #142b46;
        }
        .login-card {
            max-width: 480px;
            width: 100%;
            margin: auto;
        }
        .form-control:focus {
            border-color: #1769e8;
            box-shadow: 0 0 0 .2rem rgba(23, 105, 232, .12);
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

    <!-- Navbar Include -->
    <%@ include file="/WEB-INF/views/common/navbar.jsp" %>

    <!-- Main Content Area -->
    <main class="flex-grow-1 d-flex align-items-center justify-content-center py-5">
        <div class="container">
            <div class="login-card">
                <div class="card border-0 shadow-sm rounded-4 p-4 p-md-5 bg-white">

                    <!-- Card Header -->
                    <div class="text-center mb-4">
                        <div class="mb-3 text-primary">
                            <i class="bi bi-shield-lock-fill display-5"></i>
                        </div>
                        <h3 class="fw-bold">Company Login</h3>
                        <p class="text-secondary small">Enter your approved business email to receive an OTP verification code.</p>
                    </div>

                    <!-- Form Section -->
                    <form id="loginEmailForm" onsubmit="event.preventDefault();">
                        <div class="mb-3">
                            <label for="companyEmail" class="form-label fw-semibold">Business Email Address</label>
                            <div class="input-group">
                                <span class="input-group-text bg-light border-end-0"><i class="bi bi-envelope text-muted"></i></span>
                                <input type="email"
                                       class="form-control border-start-0 ps-0"
                                       id="companyEmail"
                                       name="email"
                                       placeholder="name@company.com"
                                       onblur="checkCompanyLoginEmail()"
                                       required>
                            </div>
                            <!-- Dynamic Feedback Message -->
                            <div id="emailMessage" class="form-text mt-2 fw-medium"></div>
                        </div>

                        <div class="d-grid mt-4">
                            <button type="button"
                                    class="btn btn-primary-custom btn-lg shadow-sm"
                                    id="sendOtpBtn"
                                    onclick="sendCompanyOtp()"
                                    disabled>
                                <i class="bi bi-send-fill me-2"></i> Send OTP Code
                            </button>
                        </div>
                    </form>

                </div>
            </div>
        </div>
    </main>

    <!-- Footer Include -->
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        function checkCompanyLoginEmail() {
            let emailInput = document.getElementById("companyEmail");
            let email = emailInput.value.trim();
            let sendOtpBtn = document.getElementById("sendOtpBtn");
            let emailMessage = document.getElementById("emailMessage");

            sendOtpBtn.disabled = true;
            emailMessage.innerHTML = "";
            emailInput.classList.remove("is-valid", "is-invalid");

            if (email === "") {
                emailInput.classList.add("is-invalid");
                emailMessage.innerHTML = "Please enter an email address.";
                emailMessage.className = "form-text mt-2 text-danger fw-medium";
                return;
            }

            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                emailInput.classList.add("is-invalid");
                emailMessage.innerHTML = "Please enter a valid email format.";
                emailMessage.className = "form-text mt-2 text-danger fw-medium";
                return;
            }

            axios.get("${pageContext.request.contextPath}/checkCompanyLoginEmail", {
                params: { email: email }
            })
            .then(function(response) {
                let data = response.data;

                emailMessage.innerHTML = data.message;

                if (data.exists && data.approved) {
                    sendOtpBtn.disabled = false;
                    emailInput.classList.add("is-valid");
                    emailMessage.className = "form-text mt-2 text-success fw-medium";
                } else {
                    sendOtpBtn.disabled = true;
                    emailInput.classList.add("is-invalid");
                    emailMessage.className = "form-text mt-2 text-danger fw-medium";
                }

            })
            .catch(function(error) {
                sendOtpBtn.disabled = true;
                emailInput.classList.add("is-invalid");
                emailMessage.innerHTML = "Unable to verify email right now. Try again.";
                emailMessage.className = "form-text mt-2 text-danger fw-medium";
            });
        }

        function sendCompanyOtp() {
            // Your OTP trigger logic goes here
        }
    </script>

</body>
</html>