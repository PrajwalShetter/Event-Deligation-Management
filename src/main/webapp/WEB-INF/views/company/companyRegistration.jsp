<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Company Registration</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

    <style>
        body {
            background: #f1f5fa;
            color: #142b46;
        }

        .registration-card {
            max-width: 900px;
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

        .form-control:focus, .form-select:focus {
            border-color: #1769e8;
            box-shadow: 0 0 0 .2rem rgba(23, 105, 232, .12);
        }

        .btn-primary {
            background: #1769e8;
            border-color: #1769e8;
        }
    </style>
</head>

<body class="d-flex flex-column min-vh-100">

    <%@ include file="/WEB-INF/views/common/navbar.jsp" %>

    <main class="flex-grow-1 py-5">
        <div class="container">
            <div class="registration-card">

                <div class="text-center mb-4">
                    <h2 class="fw-bold" style="color: #142b46;">Company Registration</h2>
                    <p class="text-secondary">
                        Register your organization to manage events and coordinate information seamlessly.
                    </p>
                    <div id="responseMessage" class="mt-3"></div>
                </div>

                <div class="card border-0 shadow-sm rounded-4">
                    <div class="card-body p-4 p-md-5">

                        <form id="companyRegistrationForm" action="${pageContext.request.contextPath}/company/register" method="post" enctype="multipart/form-data" novalidate>
                            <div class="row">
                                <!-- Company Name -->
                                <div class="col-md-6 mb-3">
                                    <label for="companyName" class="form-label fw-semibold">
                                        Company Name <span class="required">*</span>
                                    </label>
                                    <input type="text" class="form-control" id="companyName" name="companyName"
                                        placeholder="Enter company name" maxlength="150" required>
                                    <span id="companyNameError" class="field-error"></span>
                                </div>

                                <!-- Email -->
                                <div class="col-md-6 mb-3">
                                    <label for="email" class="form-label fw-semibold">
                                        Business Email <span class="required">*</span>
                                    </label>
                                    <input type="email" class="form-control" id="email" name="email"
                                        placeholder="Enter business email" maxlength="150" required>
                                    <span id="emailError" class="field-error"></span>
                                </div>
                            </div>

                            <div class="row">
                                <!-- Contact Number -->
                                <div class="col-md-6 mb-3">
                                    <label for="contactNumber" class="form-label fw-semibold">
                                        Contact Number <span class="required">*</span>
                                    </label>
                                    <input type="tel" class="form-control" id="contactNumber" name="contactNumber"
                                        placeholder="10-digit mobile number" maxlength="10" inputmode="numeric" required>
                                    <span id="contactNumberError" class="field-error"></span>
                                </div>

                                <!-- Employee Size -->
                                <div class="col-md-6 mb-3">
                                    <label for="employeeSize" class="form-label fw-semibold">
                                        Employee Size <span class="required">*</span>
                                    </label>
                                    <input type="text" class="form-control" id="employeeSize" name="employeeSize"
                                        placeholder="e.g. 10-50" required>
                                    <span id="employeeSizeError" class="field-error"></span>
                                </div>
                            </div>

                            <div class="row">
                                <!-- GSTIN Number -->
                                <div class="col-md-6 mb-3">
                                    <label for="gstinNumber" class="form-label fw-semibold">
                                        GSTIN Number <span class="required">*</span>
                                    </label>
                                    <input type="text" class="form-control text-uppercase" id="gstinNumber" name="gstinNumber"
                                        placeholder="e.g. 22AAAAA0000A1Z5" maxlength="15" required>
                                    <span id="gstinNumberError" class="field-error"></span>
                                </div>

                                <!-- Pincode -->
                                <div class="col-md-6 mb-3">
                                    <label for="pincode" class="form-label fw-semibold">
                                        Pincode <span class="required">*</span>
                                    </label>
                                    <input type="text" class="form-control" id="pincode" name="pincode"
                                        placeholder="6-digit pincode" maxlength="6" inputmode="numeric" required>
                                    <span id="pincodeError" class="field-error"></span>
                                </div>
                            </div>

                            <div class="row">
                                <!-- Country (Dropdown) -->
                                <div class="col-md-4 mb-3">
                                    <label for="country" class="form-label fw-semibold">
                                        Country <span class="required">*</span>
                                    </label>
                                    <select class="form-select" id="country" name="country" required>
                                        <option value="">Select Country</option>
                                    </select>
                                    <span id="countryError" class="field-error"></span>
                                </div>

                                <!-- State (Dropdown) -->
                                <div class="col-md-4 mb-3">
                                    <label for="state" class="form-label fw-semibold">
                                        State <span class="required">*</span>
                                    </label>
                                    <select class="form-select" id="state" name="state" required disabled>
                                        <option value="">Select State</option>
                                    </select>
                                    <span id="stateError" class="field-error"></span>
                                </div>

                                <!-- City (Dropdown) -->
                                <div class="col-md-4 mb-3">
                                    <label for="city" class="form-label fw-semibold">
                                        City <span class="required">*</span>
                                    </label>
                                    <select class="form-select" id="city" name="city" required disabled>
                                        <option value="">Select City</option>
                                    </select>
                                    <span id="cityError" class="field-error"></span>
                                </div>
                            </div>

                            <!-- Address -->
                            <div class="mb-3">
                                <label for="address" class="form-label fw-semibold">
                                    Address <span class="required">*</span>
                                </label>
                                <textarea class="form-control" id="address" name="address" rows="2"
                                    placeholder="Enter complete office address" maxlength="250" required></textarea>
                                <span id="addressError" class="field-error"></span>
                            </div>

                            <div class="row">
                                <!-- Map Link -->
                                <div class="col-md-7 mb-3">
                                    <label for="mapLink" class="form-label fw-semibold">
                                        Google Map Link <span class="required">*</span>
                                    </label>
                                    <input type="url" class="form-control" id="mapLink" name="mapLink"
                                        placeholder="https://maps.google.com/..." maxlength="2000" required>
                                    <span id="mapLinkError" class="field-error"></span>
                                </div>

                                <!-- Logo File -->
                                <div class="col-md-5 mb-3">
                                    <label for="logo" class="form-label fw-semibold">
                                        Company Logo <span class="required">*</span>
                                    </label>
                                    <input type="file" class="form-control" id="logo" name="logo" accept="image/*" required>
                                    <span id="logoError" class="field-error"></span>
                                </div>
                            </div>

                            <div class="d-grid mt-4">
                                <button type="submit" class="btn btn-primary btn-lg" id="submitBtn">
                                    Register Company
                                </button>
                            </div>

                        </form>

                    </div>
                </div>

            </div>
        </div>
    </main>

    <%@ include file="/WEB-INF/views/common/footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        const contextPath = "${pageContext.request.contextPath}";

        let emailCheckVersion = 0;
        let contactCheckVersion = 0;
        let gstinCheckVersion = 0;

        function getValue(field) {
            const el = document.getElementById(field);
            if (!el) return "";
            return el.value.trim();
        }

        function showError(field, message) {
            const errorElement = document.getElementById(field + "Error");
            if (errorElement) errorElement.textContent = message;

            const input = document.getElementById(field);
            if (input) {
                input.classList.add("is-invalid");
                input.classList.remove("is-valid");
            }
        }

        function clearError(field) {
            const errorElement = document.getElementById(field + "Error");
            if (errorElement) errorElement.textContent = "";

            const input = document.getElementById(field);
            if (input) {
                input.classList.remove("is-invalid", "is-valid");
            }
        }

        function showValid(field) {
            clearError(field);
            const input = document.getElementById(field);
            if (input) {
                input.classList.add("is-valid");
            }
        }

        // --- CountriesNow API Integration ---
        async function loadCountries() {
            try {
                const response = await axios.get('https://countriesnow.space/api/v0.1/countries');
                const countrySelect = document.getElementById('country');
                countrySelect.innerHTML = '<option value="">Select Country</option>';

                const countries = response.data.data || [];
                countries.forEach(c => {
                    const option = document.createElement('option');
                    option.value = c.country;
                    option.textContent = c.country;
                    countrySelect.appendChild(option);
                });
            } catch (error) {
                console.error("Failed to load countries", error);
            }
        }

        document.getElementById('country').addEventListener('change', async function() {
            const countryName = this.value;
            const stateSelect = document.getElementById('state');
            const citySelect = document.getElementById('city');

            stateSelect.innerHTML = '<option value="">Select State</option>';
            citySelect.innerHTML = '<option value="">Select City</option>';
            stateSelect.disabled = true;
            citySelect.disabled = true;

            validateField('country');

            if (!countryName) return;

            try {
                const response = await axios.post('https://countriesnow.space/api/v0.1/countries/states', {
                    country: countryName
                });

                const states = response.data.data.states || [];
                if (states.length > 0) {
                    states.forEach(s => {
                        const option = document.createElement('option');
                        option.value = s.name;
                        option.textContent = s.name;
                        stateSelect.appendChild(option);
                    });
                    stateSelect.disabled = false;
                }
            } catch (error) {
                console.error("Failed to load states", error);
            }
        });

        document.getElementById('state').addEventListener('change', async function() {
            const countryName = document.getElementById('country').value;
            const stateName = this.value;
            const citySelect = document.getElementById('city');

            citySelect.innerHTML = '<option value="">Select City</option>';
            citySelect.disabled = true;

            validateField('state');

            if (!countryName || !stateName) return;

            try {
                const response = await axios.post('https://countriesnow.space/api/v0.1/countries/state/cities', {
                    country: countryName,
                    state: stateName
                });

                const cities = response.data.data || [];
                if (cities.length > 0) {
                    cities.forEach(cityName => {
                        const option = document.createElement('option');
                        option.value = cityName;
                        option.textContent = cityName;
                        citySelect.appendChild(option);
                    });
                    citySelect.disabled = false;
                }
            } catch (error) {
                console.error("Failed to load cities", error);
            }
        });

        document.getElementById('city').addEventListener('change', function() {
            validateField('city');
        });

        document.addEventListener('DOMContentLoaded', loadCountries);


        function validateField(field) {
            const value = getValue(field);
            let message = "";

            switch (field) {
                case "companyName":
                    if (!value) message = "Company name is required";
                    else if (value.length < 2 || value.length > 30 ) message = "Company name must be between 2 and 30 characters";
                    break;

                case "email":
                    if (!value) message = "Email is required";
                    else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value)) message = "Enter a valid email address";
                    else if (value.length > 30) message = "Email cannot exceed 30 characters";
                    break;

                case "contactNumber":
                    if (!value) message = "Contact number is required";
                    else if (!/^[6-9][0-9]{9}$/.test(value)) message = "Contact number must contain exactly 10 digits";
                    break;

                case "employeeSize":
                    if (!value) message = "Employee size is required";
                    else if (!/^[0-9]+-[0-9]+$/.test(value)) message = "Employee size must be in range format, e.g. 10-15";
                    break;

                case "gstinNumber":
                    if (!value) message = "GSTIN is required";
                    else if (!/^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z][1-9A-Z]Z[0-9A-Z]$/.test(value)) message = "Enter a valid GSTIN format";
                    break;

                case "address":
                    if (!value) message = "Address is required";
                    else if (value.length > 250) message = "Address cannot exceed 250 characters";
                    break;

                case "country":
                    if (!value) message = "Country is required";
                    break;

                case "state":
                    if (!value) message = "State is required";
                    break;

                case "city":
                    if (!value) message = "City is required";
                    break;

                case "pincode":
                    if (!value) message = "Pincode is required";
                    else if (!/^[0-9]{6}$/.test(value)) message = "Pincode must contain exactly 6 numeric digits";
                    break;

                case "mapLink":
                    if (!value) message = "Map link is required";
                    else if (value.length > 2000) message = "Map link cannot exceed 2000 characters";
                    break;

                case "logo":
                    const fileInput = document.getElementById("logo");
                    if (!fileInput.files || fileInput.files.length === 0) {
                        message = "Company logo is required";
                    }
                    break;
            }

            if (message) {
                showError(field, message);
                return false;
            }

            showValid(field);
            return true;
        }

        // Axios Backend Uniqueness Checks
        async function checkEmailUnique() {
            const email = getValue("email");
            const version = ++emailCheckVersion;
            if (!validateField("email")) return false;

            try {
                const response = await axios.get(contextPath + "/checkCompanyEmail", { params: { email } });
                if (version !== emailCheckVersion || email !== getValue("email")) return false;

                if (response.data === "Email already exists") {
                    showError("email", "This email is already registered.");
                    return false;
                }
                showValid("email");
                return true;
            } catch (err) {
                return false;
            }
        }

        async function checkContactUnique() {
            const phone = getValue("contactNumber");
            const version = ++contactCheckVersion;
            if (!validateField("contactNumber")) return false;

            try {
                const response = await axios.get(contextPath + "/checkCompanyPhone", { params: { phone } });
                if (version !== contactCheckVersion || phone !== getValue("contactNumber")) return false;

                if (response.data === "Phone already exists") {
                    showError("contactNumber", "This contact number is already registered.");
                    return false;
                }
                showValid("contactNumber");
                return true;
            } catch (err) {
                return false;
            }
        }

        async function checkGstinUnique() {
            const gstin = getValue("gstinNumber");
            const version = ++gstinCheckVersion;
            if (!validateField("gstinNumber")) return false;

            try {
                const response = await axios.get(contextPath + "/checkCompanyGstin", { params: { gstin } });
                if (version !== gstinCheckVersion || gstin !== getValue("gstinNumber")) return false;

                if (response.data === "GSTIN already exists") {
                    showError("gstinNumber", "This GSTIN is already registered.");
                    return false;
                }
                showValid("gstinNumber");
                return true;
            } catch (err) {
                return false;
            }
        }

        // Field Listeners setup
        const fields = ["companyName", "email", "contactNumber", "employeeSize", "gstinNumber", "address", "country", "state", "city", "pincode", "mapLink", "logo"];

        fields.forEach(field => {
            const input = document.getElementById(field);
            if (input) {
                input.addEventListener("input", () => {
                    validateField(field);
                    if (field === "email") emailCheckVersion++;
                    if (field === "contactNumber") contactCheckVersion++;
                    if (field === "gstinNumber") gstinCheckVersion++;
                });

                input.addEventListener("change", () => {
                    validateField(field);
                });
            }
        });

        // Unique check blur triggers
        document.getElementById("email").addEventListener("blur", checkEmailUnique);
        document.getElementById("contactNumber").addEventListener("blur", checkContactUnique);
        document.getElementById("gstinNumber").addEventListener("blur", checkGstinUnique);

        // Master Form Submission via Axios (AJAX)
        document.getElementById("companyRegistrationForm").addEventListener("submit", async function (event) {
            event.preventDefault();

            let formValid = true;
            fields.forEach(field => {
                if (!validateField(field)) {
                    formValid = false;
                }
            });

            if (!formValid) {
                document.querySelector(".is-invalid")?.focus();
                return;
            }

            const submitBtn = document.getElementById("submitBtn");
            if (submitBtn) submitBtn.disabled = true;

            try {
                const results = await Promise.all([
                    checkEmailUnique(),
                    checkContactUnique(),
                    checkGstinUnique()
                ]);

                if (!results.every(Boolean)) {
                    if (submitBtn) submitBtn.disabled = false;
                    document.querySelector(".is-invalid")?.focus();
                    return;
                }

                const formElement = document.getElementById("companyRegistrationForm");
                const formData = new FormData(formElement);

                // Submit via Axios POST to prevent JSON page rendering issue
                await axios.post(formElement.action, formData, {
                    headers: { 'Content-Type': 'multipart/form-data' }
                });

                // Success Notification Banner
                const messageContainer = document.getElementById("responseMessage");
                messageContainer.innerHTML = `
                    <div class="alert alert-success alert-dismissible fade show shadow-sm text-start" role="alert">
                        <i class="bi bi-check-circle-fill me-2"></i>
                        <strong>Registration Successful!</strong> Your company registration request has been submitted successfully and review is in progress.
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                `;

                // Reset Form & Validation Classes
                formElement.reset();
                fields.forEach(field => {
                    const input = document.getElementById(field);
                    if (input) input.classList.remove("is-valid", "is-invalid");
                });

                // Reset dependent dropdowns
                document.getElementById('state').innerHTML = '<option value="">Select State</option>';
                document.getElementById('state').disabled = true;
                document.getElementById('city').innerHTML = '<option value="">Select City</option>';
                document.getElementById('city').disabled = true;

                window.scrollTo({ top: 0, behavior: 'smooth' });

                // Auto-dismiss success banner after 7 seconds
                setTimeout(() => {
                    const alertEl = messageContainer.querySelector('.alert');
                    if (alertEl) {
                        let bsAlert = new bootstrap.Alert(alertEl);
                        bsAlert.close();
                    }
                }, 7000);

            } catch (error) {
                console.error("Submission failed", error);
                const messageContainer = document.getElementById("responseMessage");
                messageContainer.innerHTML = `
                    <div class="alert alert-danger alert-dismissible fade show shadow-sm text-start" role="alert">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i>
                        <strong>Registration Failed!</strong> An error occurred while processing your request. Please try again.
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                `;
                window.scrollTo({ top: 0, behavior: 'smooth' });
            } finally {
                if (submitBtn) submitBtn.disabled = false;
            }
        });
    </script>

</body>
</html>