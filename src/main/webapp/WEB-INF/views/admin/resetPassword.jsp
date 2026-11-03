<%@ page isELIgnored="false" %>

    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <title>Reset Password</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>

    <body class="bg-light">
    <%@ include file="/WEB-INF/views/common/navbar.jsp" %>


        <div class="container min-vh-100 d-flex justify-content-center align-items-center py-5">

            <div class="card shadow border-0 rounded-4 w-100" style="max-width: 480px;">

                <div class="card-body p-4 p-md-5">

                    <!-- Heading -->
                    <div class="text-center mb-4">
                        <h2 class="fw-bold">Reset Password</h2>
                        <p class="text-danger">${blockMsg}</p>
                        <p class="text-secondary">Verify your email to continue.</p>
                    </div>

                    <!-- FORM 1: SEND OTP -->
                    <form action="sendOtp" method="get" id="sendOtpForm" onsubmit="return checkEmailIsExist(event)">

                        <div class="mb-3">
                            <label for="email" class="form-label fw-semibold">
                                Email Address
                            </label>

                            <input type="email" class="form-control" id="email" name="email" value="${email}"
                                placeholder="Enter your registered email" required>
                        </div>
                        <div id="emailError" class="mt-2"></div>

                        <button type="submit" id="sendOtpBtn" class="btn btn-primary w-100">
                            Send OTP
                        </button>
                    </form>

                    <!-- Message from backend -->
                    <div id="message" class="mt-3"></div>

                    <!-- FORM 2: VERIFY OTP (HIDDEN INITIALLY) -->
                    <form action="admin/verifyOtp" method="post" id="verifyOtpForm" class="mt-4 d-none">

                        <!-- Carry the email from Form 1 -->
                        <input type="hidden" name="email" value="${email}" id="verifyEmail">

                        <div class="mb-3">
                            <label for="otp" class="form-label fw-semibold">
                                Enter OTP
                            </label>

                            <input type="text" class="form-control" id="otp" name="otp"
                                placeholder="Enter the OTP sent to your email" maxlength="6" inputmode="numeric"
                                pattern="[0-9]{6}" required>
                        </div>

                         <c:if test="${not empty failure}">
                             <small class="text-danger">${failure}</small>
                         </c:if>

                        <button type="submit" class="btn btn-success w-100">
                            Verify OTP
                        </button>

                    </form>

                    <div class="text-center mt-4">
                        <a href="${pageContext.request.contextPath}/loginPage" class="text-decoration-none">
                            Back to Login
                        </a>
                    </div>

                </div>
            </div>
        </div>

           <%@ include file="/WEB-INF/views/common/footer.jsp" %>
        <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

        <script>
            async function checkEmailIsExist(event) {

                event.preventDefault();

                let emailId = document.getElementById("email").value.trim();
                let emailError = document.getElementById("emailError");
                let sendOtpBtn = document.getElementById("sendOtpBtn");

                emailError.innerHTML = "";

                if (emailId === "") {
                    emailError.innerHTML = "Email is required";
                    emailError.className = "mt-2 text-danger";
                    return false;
                }

                sendOtpBtn.disabled = true;

                try {
                    let response = await axios.get(
                        "${pageContext.request.contextPath}/checkEmail",
                        { params: { email: emailId } }
                    );

                    let data = response.data;
                    console.log(data);

                    if (data === "Email is already exist") {

                        document.getElementById("verifyEmail").value = emailId;

                        // Email exists; now submit the form to sendOtp
                        document.getElementById("sendOtpForm").submit();

                    } else {

                        emailError.innerHTML = "Email does not exist. Try again.";
                        emailError.className = "mt-2 text-danger";
                        sendOtpBtn.disabled = false;
                    }

                } catch (error) {

                    console.error(error);

                    emailError.innerHTML = "Unable to check email. Try again.";
                    emailError.className = "mt-2 text-danger";
                    sendOtpBtn.disabled = false;
                }

                return false;
            }

            function showVerifyForm() {
                document.getElementById("verifyOtpForm")
                    .classList.remove("d-none");
            }

            const otpSent = "${otpSent}";
            const failure = "${failure}";

            const emailError = document.getElementById("emailError");

            if (otpSent === "true") {

                emailError.textContent = "OTP sent to your email successfully";
                emailError.className = "mt-2 text-success";

                showVerifyForm();

            } else if (failure !== "") {

                emailError.textContent = failure;
                emailError.className = "mt-2 text-danger";
            }
        </script>

    </body>

    </html>