<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Edit Admin Profile</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            background: #f1f5fa;
            color: #142b46;
        }

        .page-heading {
            color: #142b46;
            font-weight: 700;
        }

        .profile-card {
            border: 0;
            border-radius: 12px;
            box-shadow: 0 3px 12px rgba(20, 43, 70, 0.10);
        }

        .profile-banner {
            background: #eaf3ff;
            border-radius: 10px;
        }

        .form-label {
            font-weight: 600;
            color: #172b45;
        }

        .form-control, .form-select {
            min-height: 46px;
            border-color: #cbd5e1;
        }

        .form-control:focus, .form-select:focus {
            border-color: #2878e8;
            box-shadow: 0 0 0 .2rem rgba(40, 120, 232, .12);
        }

        .readonly-field {
            background-color: #e9eef5 !important;
            color: #52647d;
        }

        .btn-primary {
            background: #1769e8;
        }

        .field-message {
            font-size: .875rem;
        }
    </style>
</head>

<body>

<%@ include file="adminNavbar.jsp" %>

<div class="container-fluid px-3 px-lg-5 py-4">

    <div class="card profile-card">
        <div class="card-body p-3 p-lg-4">

            <div class="profile-banner p-4 mb-4">
                <div class="d-flex align-items-center gap-4">
                    <img src="${pageContext.request.contextPath}/admin/profile-picture"
                         alt="Admin profile"
                         class="rounded-circle border border-3 border-white shadow-sm"
                         style="width:110px;height:110px;object-fit:cover;"
                         onerror="this.src='https://placehold.co/110x110/e9ecef/495057?text=Admin'">

                    <div>
                        <h3 class="h4 fw-bold mb-2">Edit Your Profile</h3>
                        <p class="text-secondary mb-0">
                            Update your personal details. Your profile picture can
                            be changed from the profile page.
                        </p>
                    </div>
                </div>
            </div>

            <c:if test="${not empty success}">
                <div class="alert alert-success" role="alert">
                    <i class="bi bi-check-circle me-2"></i>
                    <c:out value="${success}"/>
                </div>
            </c:if>

            <c:if test="${not empty failure}">
                <div class="alert alert-danger" role="alert">
                    <i class="bi bi-exclamation-circle me-2"></i>
                    <c:out value="${failure}"/>
                </div>
            </c:if>

            <c:set var="formData" value="${not empty editDto ? editDto : admin}"/>

            <form action="${pageContext.request.contextPath}/admin/updateProfile"
                  method="post" id="editProfileForm">

                <div class="row g-4">

                    <!-- First Name -->
                    <div class="col-md-6">
                        <label for="firstName" class="form-label">
                            <i class="bi bi-person me-2"></i>First Name
                            <span class="text-danger">*</span>
                        </label>

                        <input type="text" class="form-control"
                               id="firstName" name="firstName"
                               value="<c:out value='${formData.getFirstName()}'/>"
                               minlength="3" required>

                        <div class="text-danger field-message mt-1" id="firstNameError">
                            <c:forEach items="${validationErrors}" var="err">
                                <c:if test="${err.field eq 'firstName'}">
                                    <c:out value="${err.defaultMessage}"/>
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>

                    <!-- Last Name -->
                    <div class="col-md-6">
                        <label for="lastname" class="form-label">
                            <i class="bi bi-person me-2"></i>Last Name
                            <span class="text-danger">*</span>
                        </label>

                        <input type="text" class="form-control"
                               id="lastname" name="lastname"
                               value="<c:out value='${formData.getLastname()}'/>"
                               minlength="1" required>

                        <div class="text-danger field-message mt-1" id="lastnameError">
                            <c:forEach items="${validationErrors}" var="err">
                                <c:if test="${err.field eq 'lastname'}">
                                    <c:out value="${err.defaultMessage}"/>
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>

                    <!-- Email -->
                    <div class="col-md-6">
                        <label for="email" class="form-label">
                            <i class="bi bi-envelope me-2"></i>Email Address
                            <span class="text-danger">*</span>
                        </label>

                        <input type="email" class="form-control"
                               id="email" name="email"
                               value="<c:out value='${formData.getEmail()}'/>"
                               required>

                        <div class="field-message mt-1" id="emailStatus">
                            <c:if test="${not empty emailError}">
                                <span class="text-danger">
                                    <c:out value="${emailError}"/>
                                </span>
                            </c:if>
                        </div>
                        <small class="text-secondary">
                            Enter a valid email address. This email will be used for login.
                        </small>
                    </div>

                    <!-- Phone -->
                    <div class="col-md-6">
                        <label for="phone" class="form-label">
                            <i class="bi bi-telephone me-2"></i>Phone Number
                            <span class="text-danger">*</span>
                        </label>

                        <input type="tel" class="form-control"
                               id="phone" name="phone"
                               value="<c:out value='${formData.getPhone()}'/>"
                               pattern="[6-9][0-9]{9}" maxlength="10"
                               inputmode="numeric" required>

                        <div class="field-message mt-1" id="phoneStatus">
                            <c:if test="${not empty phoneError}">
                                <span class="text-danger">
                                    <c:out value="${phoneError}"/>
                                </span>
                            </c:if>
                            <c:forEach items="${validationErrors}" var="err">
                                <c:if test="${err.field eq 'phone'}">
                                    <span class="text-danger">
                                        <c:out value="${err.defaultMessage}"/>
                                    </span>
                                </c:if>
                            </c:forEach>
                        </div>
                        <small class="text-secondary">
                            Enter a 10-digit mobile number.
                        </small>
                    </div>

                    <!-- Gender -->
                    <div class="col-md-6">
                        <label for="gender" class="form-label">
                            <i class="bi bi-gender-ambiguous me-2"></i>Gender
                            <span class="text-danger">*</span>
                        </label>

                        <select class="form-select" id="gender" name="gender" required>
                            <option value="">Select gender</option>
                            <option value="MALE" ${formData.getGender() == 'MALE' ? 'selected' : ''}>Male</option>
                            <option value="FEMALE" ${formData.getGender() == 'FEMALE' ? 'selected' : ''}>Female</option>
                            <option value="OTHER" ${formData.getGender() == 'OTHER' ? 'selected' : ''}>Other</option>
                        </select>

                        <div class="text-danger field-message mt-1" id="genderError">
                            <c:forEach items="${validationErrors}" var="err">
                                <c:if test="${err.field eq 'gender'}">
                                    <c:out value="${err.defaultMessage}"/>
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>

                    <!-- Age -->
                    <div class="col-md-6">
                        <label for="age" class="form-label">
                            <i class="bi bi-calendar3 me-2"></i>Age
                            <span class="text-danger">*</span>
                        </label>

                        <input type="number" class="form-control"
                               id="age" name="age"
                               value="<c:out value='${formData.getAge()}'/>"
                               min="18" max="100" required>

                        <div class="text-danger field-message mt-1" id="ageError">
                            <c:forEach items="${validationErrors}" var="err">
                                <c:if test="${err.field eq 'age'}">
                                    <c:out value="${err.defaultMessage}"/>
                                </c:if>
                            </c:forEach>
                        </div>
                        <small class="text-secondary">Age must be between 18 and 100.</small>
                    </div>

                    <!-- Account Status: Read-only -->
                    <div class="col-12">
                        <label class="form-label">
                            <i class="bi bi-shield-lock me-2"></i>Account Status
                        </label>

                        <input type="text" class="form-control readonly-field"
                               value="${admin.getStatus() ? 'Active' : 'Inactive'}"
                               readonly>

                        <small class="text-secondary">
                            Account status cannot be changed here.
                        </small>
                    </div>

                </div>

                <div class="d-flex flex-wrap justify-content-between gap-3 mt-4">
                    <a href="${pageContext.request.contextPath}/admin/profile"
                       class="btn btn-outline-secondary px-4">
                        <i class="bi bi-arrow-left me-2"></i>Cancel
                    </a>

                    <button type="submit" class="btn btn-primary px-4">
                        <i class="bi bi-floppy me-2"></i>Save Changes
                    </button>
                </div>

            </form>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
    const contextPath = '${pageContext.request.contextPath}';
    const emailInput = document.getElementById('email');
    const phoneInput = document.getElementById('phone');
    const emailStatus = document.getElementById('emailStatus');
    const phoneStatus = document.getElementById('phoneStatus');

    // Currently stored values belong to this admin
    const originalEmail = emailInput.value.trim().toLowerCase();
    const originalPhone = phoneInput.value.trim();

    let emailTimer;
    let phoneTimer;
    let emailAvailable = true;
    let phoneAvailable = true;

    function showStatus(element, message, type) {
        element.textContent = message;
        element.className = 'field-message mt-1 text-' + type;
    }

    emailInput.addEventListener('input', function () {
        clearTimeout(emailTimer);
        const email = this.value.trim().toLowerCase();

        if (email === originalEmail) {
            emailAvailable = true;
            showStatus(emailStatus, '✓ Your current email', 'success');
            return;
        }

        if (!email || !emailInput.checkValidity()) {
            emailAvailable = false;
            showStatus(emailStatus, 'Enter a valid email address.', 'danger');
            return;
        }

        emailAvailable = false;
        showStatus(emailStatus, 'Checking email...', 'secondary');

        emailTimer = setTimeout(async function () {
            try {
                const response = await fetch(
                    contextPath + '/checkEmail?email=' + encodeURIComponent(email)
                );

                if (!response.ok) throw new Error('Email check failed');

                const message = (await response.text()).trim();

                if (message === 'Email is already exist') {
                    emailAvailable = false;
                    showStatus(emailStatus, 'This email is already registered.', 'danger');
                } else {
                    emailAvailable = true;
                    showStatus(emailStatus, '✓ Email is valid to proceed', 'success');
                }
            } catch (error) {
                emailAvailable = false;
                showStatus(emailStatus, 'Could not check email. Try again.', 'danger');
            }
        }, 400);
    });

    phoneInput.addEventListener('input', function () {
        clearTimeout(phoneTimer);
        const phone = this.value.trim();

        // Admin keeps original phone number
        if (phone === originalPhone) {
            phoneAvailable = true;
            phoneInput.classList.remove('is-invalid');
            phoneInput.classList.add('is-valid');
            showStatus(phoneStatus, '✓ Your current phone number', 'success');
            return;
        }

        // Validate Indian mobile number format
        if (!/^[6-9][0-9]{9}$/.test(phone)) {
            phoneAvailable = false;
            phoneInput.classList.add('is-invalid');
            phoneInput.classList.remove('is-valid');
            showStatus(
                phoneStatus,
                'Enter a valid 10-digit Indian mobile number.',
                'danger'
            );
            return;
        }

        phoneAvailable = false;
        phoneInput.classList.remove('is-valid', 'is-invalid');
        showStatus(phoneStatus, 'Checking phone number...', 'secondary');

        phoneTimer = setTimeout(async function () {
            try {
                const response = await fetch(
                    contextPath + '/checkPhone?phone=' + encodeURIComponent(phone)
                );

                if (!response.ok) {
                    throw new Error('Phone check failed');
                }

                const message = (await response.text()).trim();

                // Exactly matches your controller return: "Phone number is Exist"
                if (message === 'Phone number is Exist') {
                    phoneAvailable = false;
                    phoneInput.classList.add('is-invalid');
                    phoneInput.classList.remove('is-valid');

                    showStatus(
                        phoneStatus,
                        'This phone number is already registered .',
                        'danger'
                    );
                } else {
                    phoneAvailable = true;
                    phoneInput.classList.remove('is-invalid');
                    phoneInput.classList.add('is-valid');

                    showStatus(
                        phoneStatus,
                        '✓ Phone number is valid to proceed',
                        'success'
                    );
                }
            } catch (error) {
                phoneAvailable = false;
                phoneInput.classList.add('is-invalid');
                phoneInput.classList.remove('is-valid');

                showStatus(
                    phoneStatus,
                    'Unable to check phone number. Please try again.',
                    'danger'
                );
            }
        }, 400);
    });

    document.getElementById('editProfileForm').addEventListener('submit', function (event) {
        if (!this.checkValidity()) {
            event.preventDefault();
            this.reportValidity();
            return;
        }

        if (!emailAvailable || !phoneAvailable) {
            event.preventDefault();
            alert('Please correct the email or phone availability errors before saving.');
        }
    });
</script>

</body>
</html>