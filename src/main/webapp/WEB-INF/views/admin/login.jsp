<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Admin Login</title>

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
</head>

<body class="d-flex flex-column min-vh-100 bg-light">

    <%@ include file="/WEB-INF/views/common/navbar.jsp" %>

    <main class="flex-grow-1 d-flex flex-column align-items-center justify-content-center py-5 px-3">
    <div class="w-100" style="max-width: 430px;">
       <c:if test="${not empty success}">
           <div id="successMessage"
                class="alert alert-success text-center py-2 mb-3"
                role="alert">
               <c:out value="${success}"/>
           </div>
       </c:if>
    </div>
        <div class="card shadow-sm border-0 p-4"
             style="width: 100%; max-width: 430px;">

            <h3 class="text-center mb-2">Admin Login</h3>

            <p class="text-center text-secondary mb-4">
                Sign in to your admin account
            </p>

            <form action="${pageContext.request.contextPath}/admin/login"
                  method="post"
                  onsubmit="return prepareLogin();">

                <!-- Email -->
                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>

                    <input type="email"
                           class="form-control"
                           id="email"
                           name="email"
                           placeholder="Enter your email"
                           value="<c:out value='${email}'/>"
                           onchange="checkEmail()"
                           oninput="clearEmailError()"
                           required>

                    <span id="emailError" class="text-danger small"></span>
                </div>

                <!-- Password -->
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>

                    <input type="password"
                           class="form-control"
                           id="password"
                           name="password"
                           placeholder="Enter your password"
                           required>

                    <span id="passwordError" class="text-danger small">
                        <c:out value="${failure}" />
                    </span>
                </div>

                <!-- Hidden date and time -->
                <input type="hidden" id="date" name="date">
                <input type="hidden" id="time" name="time">

                <!-- Forgot Password -->
                <div class="text-end mb-3">
                    <a href="${pageContext.request.contextPath}/resetPasswordPage"
                       class="text-decoration-none small">
                        Forgot Password?
                    </a>
                </div>

                <button type="submit" class="btn btn-primary w-100">
                    Login
                </button>

                <p class="text-center mt-3 mb-0">
                    Don't have an admin account?
                    <a href="${pageContext.request.contextPath}/registerPage">
                        Register here
                    </a>
                </p>

            </form>
        </div>

    </main>

    <%@ include file="/WEB-INF/views/common/footer.jsp" %>

    <script>
        let emailExists = false;

        function showEmailError(message) {
            document.getElementById("emailError").textContent = message;
            document.getElementById("email").classList.add("is-invalid");
        }

        function clearEmailError() {
            document.getElementById("emailError").textContent = "";
            document.getElementById("email").classList.remove("is-invalid");
            emailExists = false;
        }

        async function checkEmail() {
            const emailInput = document.getElementById("email");
            const email = emailInput.value.trim();

            emailExists = false;

            if (!email || !emailInput.checkValidity()) {
                showEmailError("Please enter a valid email address.");
                return;
            }

            try {
                const response = await axios.get(
                    "${pageContext.request.contextPath}/checkEmail",
                    { params: { email: email } }
                );

                if (response.data === "Email is already exist") {
                    // Registered email: allow the admin to log in.
                    emailExists = true;
                    document.getElementById("emailError").textContent = "";
                    emailInput.classList.remove("is-invalid");
                } else {
                    emailExists = false;
                    showEmailError("No admin account found with this email.");
                }

            } catch (error) {
                console.error("Email check failed:", error);
                showEmailError("Unable to verify email right now. Please try again.");
            }
        }

        function prepareLogin() {
            const email = document.getElementById("email");
            const password = document.getElementById("password");
            const passwordError = document.getElementById("passwordError");

            passwordError.textContent = "";
            password.classList.remove("is-invalid");

            if (!email.value.trim() || !email.checkValidity()) {
                showEmailError("Please enter a valid email address.");
                return false;
            }

            if (!password.value.trim()) {
                passwordError.textContent = "Please enter your password.";
                password.classList.add("is-invalid");
                return false;
            }

            // Populate hidden date and time fields.
            const now = new Date();

            const year = now.getFullYear();
            const month = String(now.getMonth() + 1).padStart(2, "0");
            const day = String(now.getDate()).padStart(2, "0");

            const hours = String(now.getHours()).padStart(2, "0");
            const minutes = String(now.getMinutes()).padStart(2, "0");
            const seconds = String(now.getSeconds()).padStart(2, "0");

            document.getElementById("date").value =
                year + "-" + month + "-" + day;

            document.getElementById("time").value =
                hours + ":" + minutes + ":" + seconds;

            return true;
        }

        document.addEventListener("DOMContentLoaded", function () {
            const successMessage = document.getElementById("successMessage");

            if (successMessage) {
                setTimeout(function () {
                    successMessage.style.transition = "opacity 0.5s ease";
                    successMessage.style.opacity = "0";

                    setTimeout(function () {
                        successMessage.remove();
                    }, 500);

                }, 5000);
            }
        });
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
