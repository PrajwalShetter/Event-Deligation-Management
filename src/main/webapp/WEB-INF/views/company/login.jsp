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

                        <!-- OTP Input Section (Hidden initially) -->
                        <div id="otpSection" class="mt-4 pt-3 border-top d-none">
                            <label for="otpCode" class="form-label fw-semibold">Enter 6-Digit OTP</label>
                            <div class="input-group mb-3">
                                <span class="input-group-text bg-light border-end-0"><i class="bi bi-key-fill text-muted"></i></span>
                                <input type="text"
                                       class="form-control border-start-0 ps-0 text-center fw-bold fs-5"
                                       id="otpCode"
                                       maxlength="6"
                                       placeholder="------"
                                       inputmode="numeric">
                                <button class="btn btn-outline-success" type="button" id="verifyOtpBtn" onclick="verifyCompanyOtp()">
                                    Verify OTP
                                </button>
                            </div>

                            <!-- Timer & Resend Layout -->
                            <div class="d-flex justify-content-between align-items-center mb-2">
                                <span id="timerDisplay" class="text-muted small fw-semibold">
                                    <i class="bi bi-clock me-1"></i> OTP Expires in <span id="countdown">02:00</span>
                                </span>
                                <button type="button" class="btn btn-link btn-sm text-decoration-none p-0" id="resendOtpLink" onclick="sendCompanyOtp()" disabled>
                                    Resend OTP
                                </button>
                            </div>

                            <div id="otpMessage" class="form-text text-center mt-2"></div>
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
        let countdownTimer = null;

        function checkCompanyLoginEmail() {
            let emailInput = document.getElementById("companyEmail");
            let email = emailInput.value.trim();
            let sendOtpBtn = document.getElementById("sendOtpBtn");
            let emailMessage = document.getElementById("emailMessage");
            let otpSection = document.getElementById("otpSection");

            sendOtpBtn.disabled = true;
            otpSection.classList.add("d-none");
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

        function startOtpTimer() {
            let timeLeft = 120; // 2 minutes in seconds
            let timerDisplay = document.getElementById("timerDisplay");
            let resendLink = document.getElementById("resendOtpLink");

            resendLink.disabled = true;
            resendLink.classList.add("text-muted");

            // Re-render the original HTML structure with the countdown span intact
            timerDisplay.innerHTML = `<i class="bi bi-clock me-1"></i> Resend OTP in <span id="countdown">02:00</span>`;
            let countdownElement = document.getElementById("countdown");

            if (countdownTimer) clearInterval(countdownTimer);

            countdownTimer = setInterval(function () {
                let minutes = Math.floor(timeLeft / 60);
                let seconds = timeLeft % 60;

                minutes = minutes < 10 ? "0" + minutes : minutes;
                seconds = seconds < 10 ? "0" + seconds : seconds;

                if (countdownElement) {
                    countdownElement.innerHTML = minutes + ":" + seconds;
                }

                if (timeLeft <= 0) {
                    clearInterval(countdownTimer);
                    timerDisplay.innerHTML = "OTP expired or time limit reached.";
                    resendLink.disabled = false;
                    resendLink.classList.remove("text-muted");
                }
                timeLeft--;
            }, 1000);
        }

        function sendCompanyOtp() {
            let email = document.getElementById("companyEmail").value.trim();
            let sendOtpBtn = document.getElementById("sendOtpBtn");
            let emailMessage = document.getElementById("emailMessage");
            let otpSection = document.getElementById("otpSection");
            let otpCodeInput = document.getElementById("otpCode");
            let verifyOtpBtn = document.getElementById("verifyOtpBtn");

            sendOtpBtn.disabled = true;
            sendOtpBtn.innerHTML = `<span class="spinner-border spinner-border-sm me-2"></span> Sending OTP...`;

            axios.post("${pageContext.request.contextPath}/company/sendOtp", null, {
                params: { email: email }
            })
            .then(function(response) {
                sendOtpBtn.innerHTML = `<i class="bi bi-check-circle-fill me-2"></i> OTP Sent!`;
                sendOtpBtn.classList.remove("btn-primary-custom");
                sendOtpBtn.classList.add("btn-success");

                // Reset OTP field and state (re-enables fields if locked out previously)
                otpCodeInput.value = "";
                otpCodeInput.disabled = false;
                verifyOtpBtn.disabled = false;
                document.getElementById("otpMessage").innerHTML = "";

                // Reveal the OTP input block
                otpSection.classList.remove("d-none");
                otpCodeInput.focus();

                emailMessage.innerHTML = "OTP has been sent to your email. Please check your inbox.";
                emailMessage.className = "form-text mt-2 text-success fw-medium";

                // Restart the 2-minute countdown timer safely
                startOtpTimer();
            })
            .catch(function(error) {
                sendOtpBtn.disabled = false;
                sendOtpBtn.innerHTML = `<i class="bi bi-send-fill me-2"></i> Send OTP Code`;
                emailMessage.innerHTML = "Failed to send OTP. Please try again.";
                emailMessage.className = "form-text mt-2 text-danger fw-medium";
            });
        }

        function verifyCompanyOtp() {
            let email = document.getElementById("companyEmail").value.trim();
            let otp = document.getElementById("otpCode").value.trim();
            let otpMessage = document.getElementById("otpMessage");

            if (!/^\d{6}$/.test(otp)) {
                otpMessage.innerHTML = "Please enter a valid 6-digit OTP.";
                otpMessage.className = "form-text text-danger fw-medium";
                return;
            }

            axios.post(
                "${pageContext.request.contextPath}/company/verifyOtp",
                null,
                {
                    params: {
                        email: email,
                        otp: otp
                    }
                }
            )
            .then(function(response) {
                otpMessage.innerHTML = response.data;
                otpMessage.className = "form-text text-success fw-medium";

                document.getElementById("otpCode").disabled = true;
                document.getElementById("verifyOtpBtn").disabled = true;
                if (countdownTimer) clearInterval(countdownTimer);

                // Redirect to company dashboard after successful verification
                setTimeout(function() {
                    window.location.href = "${pageContext.request.contextPath}/company/dashboard";
                }, 1200);

            })
            .catch(function(error) {
                let message = "Verification failed. Please try again.";
                if (error.response && error.response.data) {
                    message = error.response.data;
                }
                otpMessage.innerHTML = message;
                otpMessage.className = "form-text text-danger fw-medium";
            });
        }
    </script>
</body>
</html>