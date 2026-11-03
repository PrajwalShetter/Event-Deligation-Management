<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>Admin Registration</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons for the eye toggle -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">

        <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

        <style>
            .registration-card {
                max-width: 850px;
                margin: auto;
            }

            .field-error {
                display: block;
                min-height: 20px;
                font-size: 0.85rem;
                color: #dc3545;
            }

            .required {
                color: #dc3545;
            }
        </style>
    </head>

    <body class="d-flex flex-column min-vh-100 bg-light">

        <%@ include file="/WEB-INF/views/common/navbar.jsp" %>

            <main class="flex-grow-1 py-5">
                <div class="container">
                    <div class="registration-card">

                        <div class="text-center mb-4">
                            <h2 class="fw-bold">Admin Registration</h2>
                            <p class="text-secondary">
                                Create an administrator account to manage events
                                and delegate information.
                            </p>
                        </div>

                        <div class="card border-0 shadow-sm rounded-4">
                            <div class="card-body p-4 p-md-5">

                                <form id="adminRegistrationForm" action="register" method="post" novalidate>

                                    <!-- First Name -->
                                    <div class="mb-3">
                                        <label for="firstName" class="form-label fw-semibold">
                                            First Name <span class="required">*</span>
                                        </label>
                                        <input type="text" class="form-control" id="firstName" name="firstName"
                                            placeholder="Enter first name" minlength="3" maxlength="20" required
                                            onchange="validateField('firstName')" oninput="clearError('firstName')">
                                        <span id="firstNameError" class="field-error"></span>
                                    </div>

                                    <!-- Last Name -->
                                    <div class="mb-3">
                                        <label for="lastname" class="form-label fw-semibold">
                                            Last Name <span class="required">*</span>
                                        </label>
                                        <input type="text" class="form-control" id="lastname" name="lastname"
                                            placeholder="Enter last name" minlength="3" maxlength="20" required
                                            onchange="validateField('lastname')" oninput="clearError('lastname')">
                                        <span id="lastnameError" class="field-error"></span>
                                    </div>

                                    <!-- Email -->
                                    <div class="mb-3">
                                        <label for="email" class="form-label fw-semibold">
                                            Email Address <span class="required">*</span>
                                        </label>
                                        <input type="email" class="form-control" id="email" name="email"
                                            placeholder="Enter your email" maxlength="100" required>
                                        <span id="emailError" class="field-error"></span>
                                    </div>

                                    <!-- Phone -->
                                    <div class="mb-3">
                                        <label for="phone" class="form-label fw-semibold">
                                            Mobile Number <span class="required">*</span>
                                        </label>
                                        <input type="tel" class="form-control" id="phone" name="phone"
                                            placeholder="Enter 10-digit mobile number" maxlength="10"
                                            inputmode="numeric" required>
                                        <span id="phoneError" class="field-error"></span>
                                    </div>

                                    <!-- Gender -->
                                    <div class="mb-3">
                                        <label class="form-label fw-semibold d-block">
                                            Gender <span class="required">*</span>
                                        </label>
                                        <div class="d-flex gap-4 flex-wrap">
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="gender" id="male"
                                                    value="MALE" required onchange="validateField('gender')">
                                                <label class="form-check-label" for="male">Male</label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="gender" id="female"
                                                    value="FEMALE" onchange="validateField('gender')">
                                                <label class="form-check-label" for="female">Female</label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="gender" id="other"
                                                    value="OTHER" onchange="validateField('gender')">
                                                <label class="form-check-label" for="other">Other</label>
                                            </div>
                                        </div>
                                        <span id="genderError" class="field-error"></span>
                                    </div>

                                    <!-- Age -->
                                    <div class="mb-3">
                                        <label for="age" class="form-label fw-semibold">Age</label>
                                        <input type="number" class="form-control" id="age" name="age"
                                            placeholder="Enter age" min="1" max="120"
                                            onchange="validateField('age')" oninput="clearError('age')">
                                        <span id="ageError" class="field-error"></span>
                                    </div>

                                    <!-- Password with Toggle Icon -->
                                    <div class="mb-3">
                                        <label for="password" class="form-label fw-semibold">
                                            Password <span class="required">*</span>
                                        </label>
                                        <div class="input-group">
                                            <input type="password" class="form-control border-end-0" id="password" name="password"
                                                placeholder="Create a password" minlength="8" maxlength="20"
                                                autocomplete="new-password" required onchange="validateField('password')"
                                                oninput="clearError('password'); clearError('confirmPassword')">
                                            <button class="btn btn-outline-secondary border-start-0 text-muted" type="button" id="togglePasswordBtn" tabindex="-1">
                                                <i class="bi bi-eye" id="togglePasswordIcon"></i>
                                            </button>
                                        </div>
                                        <div class="form-text">
                                            8–20 characters, including at least one uppercase letter and one symbol.
                                        </div>
                                        <span id="passwordError" class="field-error"></span>
                                    </div>

                                    <!-- Confirm Password with Toggle Icon -->
                                    <div class="mb-4">
                                        <label for="confirmPassword" class="form-label fw-semibold">
                                            Confirm Password <span class="required">*</span>
                                        </label>
                                        <div class="input-group">
                                            <input type="password" class="form-control border-end-0" id="confirmPassword"
                                                name="confirmPassword" placeholder="Re-enter your password"
                                                autocomplete="new-password" required
                                                onchange="validateField('confirmPassword')"
                                                oninput="clearError('confirmPassword')">
                                            <button class="btn btn-outline-secondary border-start-0 text-muted" type="button" id="toggleConfirmPasswordBtn" tabindex="-1">
                                                <i class="bi bi-eye" id="toggleConfirmPasswordIcon"></i>
                                            </button>
                                        </div>
                                        <span id="confirmPasswordError" class="field-error"></span>
                                    </div>

                                    <div class="d-grid">
                                        <button type="submit" class="btn btn-primary btn-lg">
                                            Register Admin
                                        </button>
                                    </div>

                                    <p class="text-center text-secondary mt-3 mb-0">
                                        Already registered?
                                        <a href="${pageContext.request.contextPath}/loginPage" class="text-decoration-none">
                                            Sign in
                                        </a>
                                    </p>

                                </form>

                            </div>
                        </div>

                    </div>
                </div>
            </main>

            <%@ include file="/WEB-INF/views/common/footer.jsp" %>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

            <script>
                const contextPath = "/event-deligation-Management";

                let emailCheckVersion = 0;
                let phoneCheckVersion = 0;

                function getValue(field) {
                    return document.getElementById(field)?.value.trim() || "";
                }

                function showError(field, message) {
                    const errorElement = document.getElementById(field + "Error");
                    if (errorElement) errorElement.textContent = message;

                    const input = document.getElementById(field);
                    if (input) {
                        input.classList.add("is-invalid");
                        input.classList.remove("is-valid");
                    }

                    if (field === "gender") {
                        document.querySelectorAll('input[name="gender"]').forEach(radio => {
                            radio.classList.add("is-invalid");
                            radio.classList.remove("is-valid");
                        });
                    }
                }

                function clearError(field) {
                    const errorElement = document.getElementById(field + "Error");
                    if (errorElement) errorElement.textContent = "";

                    const input = document.getElementById(field);
                    if (input) input.classList.remove("is-invalid", "is-valid");

                    if (field === "gender") {
                        document.querySelectorAll('input[name="gender"]').forEach(radio => {
                            radio.classList.remove("is-invalid", "is-valid");
                        });
                    }
                }

                function showValid(field) {
                    clearError(field);
                    const input = document.getElementById(field);
                    if (input) input.classList.add("is-valid");

                    if (field === "gender") {
                        document.querySelectorAll('input[name="gender"]').forEach(radio => {
                            radio.classList.add("is-valid");
                        });
                    }
                }

                function validateField(field) {
                    const value = getValue(field);
                    let message = "";

                    switch (field) {
                        case "email":
                            if (!value) message = "Email should not be blank";
                            else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value)) message = "Please enter a valid email address";
                            break;

                        case "firstName":
                        case "lastname":
                            const fieldNameLabel = field === "firstName" ? "First name" : "Last name";
                            if (!value) message = fieldNameLabel + " should not be blank";
                            else if (value.length < 3 || value.length > 20) message = fieldNameLabel + " must contain 3 to 20 characters";
                            else if (!/^[A-Za-z ]+$/.test(value)) message = fieldNameLabel + " can contain only letters and spaces";
                            break;

                        case "phone":
                            if (!value) message = "Phone number should not be blank";
                            else if (!/^[6-9][0-9]{9}$/.test(value)) message = "Enter a valid 10-digit Indian mobile number";
                            break;

                        case "gender":
                            if (!document.querySelector('input[name="gender"]:checked')) message = "Please select a gender";
                            break;

                        case "age":
                            if (!value) message = "Age should not be blank";
                            else if (!/^\d+$/.test(value) || Number(value) < 18 || Number(value) > 100) message = "Age must be between 18 and 100";
                            break;

                        case "password":
                            if (!value) message = "Password should not be blank";
                            else if (value.length < 8 || value.length > 20) message = "Password must contain 8 to 20 characters";
                            else if (!/[A-Z]/.test(value) || !/[^a-zA-Z0-9]/.test(value)) message = "Password must contain an uppercase letter and a symbol";
                            break;

                        case "confirmPassword":
                            if (!value) message = "Please confirm your password";
                            else if (value !== document.getElementById("password").value) message = "Passwords do not match";
                            break;
                    }

                    if (message) {
                        showError(field, message);
                        return false;
                    }

                    showValid(field);
                    return true;
                }

                async function checkEmailIsExist() {
                    const emailId = getValue("email");
                    const version = ++emailCheckVersion;

                    if (!validateField("email")) return false;

                    try {
                        const response = await axios.get(contextPath + "/checkEmail", { params: { email: emailId } });
                        if (version !== emailCheckVersion || emailId !== getValue("email")) return false;

                        if (response.data === "Email is already exist") {
                            showError("email", response.data);
                            return false;
                        }
                        showValid("email");
                        return true;
                    } catch (error) {
                        if (version === emailCheckVersion) showError("email", "Unable to check email. Please try again.");
                        return false;
                    }
                }

                async function checkPhoneNumberIsExist() {
                    const phoneId = getValue("phone");
                    const version = ++phoneCheckVersion;

                    if (!validateField("phone")) return false;

                    try {
                        const response = await axios.get(contextPath + "/checkPhone", { params: { phone: phoneId } });
                        if (version !== phoneCheckVersion || phoneId !== getValue("phone")) return false;

                        if (response.data === "Phone number is Exist") {
                            showError("phone", response.data);
                            return false;
                        }
                        showValid("phone");
                        return true;
                    } catch (error) {
                        if (version === phoneCheckVersion) showError("phone", "Unable to check phone number. Please try again.");
                        return false;
                    }
                }

                // Password show/hide toggle helper function
                function setupPasswordToggle(toggleBtnId, inputId, iconId) {
                    const btn = document.getElementById(toggleBtnId);
                    const input = document.getElementById(inputId);
                    const icon = document.getElementById(iconId);

                    if (btn && input && icon) {
                        btn.addEventListener("click", () => {
                            const isPassword = input.type === "password";
                            input.type = isPassword ? "text" : "password";
                            icon.classList.toggle("bi-eye", !isPassword);
                            icon.classList.toggle("bi-eye-slash", isPassword);
                        });
                    }
                }

                // Initialize toggles for both fields
                setupPasswordToggle("togglePasswordBtn", "password", "togglePasswordIcon");
                setupPasswordToggle("toggleConfirmPasswordBtn", "confirmPassword", "toggleConfirmPasswordIcon");

                // Attach listeners with automatic trimming on blur for text fields
                ["email", "firstName", "lastname", "phone", "gender", "age", "password", "confirmPassword"].forEach(field => {
                    const input = document.getElementById(field);
                    if (input) {
                        input.addEventListener("input", () => {
                            validateField(field);
                            if (field === "email") emailCheckVersion++;
                            if (field === "phone") phoneCheckVersion++;
                            if (field === "password") validateField("confirmPassword");
                        });

                        input.addEventListener("blur", () => {
                            if (input.type === "text" || input.type === "email") {
                                input.value = input.value.trim();
                            }
                            validateField(field);


                        });
                    }
                });

                document.getElementById("email").addEventListener("blur", checkEmailIsExist);
                document.getElementById("phone").addEventListener("blur", checkPhoneNumberIsExist);

                // Form submission handler
                document.getElementById("adminRegistrationForm").addEventListener("submit", async function (event) {
                    event.preventDefault();

                    ["firstName", "lastname"].forEach(field => {
                        const el = document.getElementById(field);
                        if (el) el.value = el.value.trim();
                    });

                    const fields = ["email", "firstName", "lastname", "phone", "gender", "age", "password", "confirmPassword"];
                    let formValid = true;

                    fields.forEach(field => {
                        if (!validateField(field)) formValid = false;
                    });

                    if (!formValid) {
                        document.querySelector(".is-invalid")?.focus();
                        return;
                    }

                    const submitButton = this.querySelector('[type="submit"]');
                    if (submitButton) submitButton.disabled = true;

                    try {
                        const results = await Promise.all([checkEmailIsExist(), checkPhoneNumberIsExist()]);
                        if (!results.every(Boolean)) {
                            document.querySelector(".is-invalid")?.focus();
                            return;
                        }

                        this.submit();
                    } finally {
                        if (submitButton) submitButton.disabled = false;
                    }
                });
            </script>

    </body>

    </html>