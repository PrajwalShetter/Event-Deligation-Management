<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Admin Profile</title>

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css"
        rel="stylesheet">
</head>

<body class="d-flex flex-column min-vh-100 bg-light">

    <!-- Admin Navbar -->
    <%@ include file="adminNavbar.jsp" %>

    <main class="flex-grow-1 py-5">

        <div class="container">

            <!-- Page Heading -->
            <div class="mb-4">
                <h2 class="fw-bold mb-1">My Profile</h2>
                <p class="text-secondary mb-0">
                    View your personal and account information.
                </p>
            </div>

            <div class="card border-0 shadow-sm rounded-4 overflow-hidden">

                <!-- Profile Header -->
                <div class="bg-primary text-white p-4 p-md-5">
                    <div class="row align-items-center g-4">

                        <div class="col-auto">

                            <form action="${pageContext.request.contextPath}/admin/uploadProfilePic"
                                  method="post"
                                  enctype="multipart/form-data">

                                <label for="profilePhoto"
                                       class="position-relative d-inline-block"
                                       style="cursor: pointer;"
                                       title="Choose profile photo">

                                    <img id="photoPreview"
                                         src="${pageContext.request.contextPath}/admin/profile-picture"
                                         alt="Admin profile photo"
                                         class="rounded-circle border border-3 border-white shadow-sm"
                                         style="width: 130px; height: 130px; object-fit: cover;">

                                    <span class="position-absolute bottom-0 end-0
                                                 bg-white text-primary rounded-circle
                                                 d-flex align-items-center justify-content-center
                                                 shadow"
                                          style="width: 36px; height: 36px;">
                                        <i class="bi bi-camera-fill"></i>
                                    </span>
                                </label>

                                <input type="file"
                                       id="profilePhoto"
                                       name="profilePicFile"
                                       accept="image/jpeg,image/png,image/webp"
                                       class="d-none"
                                       onchange="previewPhoto(event); this.form.submit();">

                            </form>

                            <p class="small text-white-50 mt-2 mb-0">
                                Click photo to upload
                            </p>

                        </div>

                        <div class="col">
                            <h3 class="fw-bold mb-1">
                                ${not empty admin.firstName ? admin.firstName : 'Admin'}
                                ${not empty admin.lastname ? admin.lastname : ''}
                            </h3>

                            <p class="mb-2 text-white-50">
                                <i class="bi bi-shield-lock me-1"></i>
                                System Administrator
                            </p>

                            <span class="badge bg-light text-primary">
                                Admin Account
                            </span>

                            <p class="small mt-2 mb-0 text-white-50">
                                Click your photo to select a profile picture.
                            </p>
                        </div>

                    </div>
                </div>

                <!-- Profile Details -->
                <div class="p-4 p-md-5">

                    <h5 class="fw-bold mb-4">
                        <i class="bi bi-person-vcard text-primary me-2"></i>
                        Personal Information
                    </h5>

                    <div class="row g-4">

                        <!-- First Name -->
                        <div class="col-md-6">
                            <label class="form-label text-secondary small">
                                First Name
                            </label>
                            <div class="form-control bg-light">
                                ${admin.getFirstName()}
                            </div>
                        </div>

                        <!-- Last Name -->
                        <div class="col-md-6">
                            <label class="form-label text-secondary small">
                                Last Name
                            </label>
                            <div class="form-control bg-light">
                                ${admin.getLastname()}
                            </div>
                        </div>

                        <!-- Email -->
                        <div class="col-md-6">
                            <label class="form-label text-secondary small">
                                Email Address
                            </label>
                            <div class="form-control bg-light text-break">
                                ${admin.getEmail()}
                            </div>
                        </div>

                        <!-- Phone -->
                        <div class="col-md-6">
                            <label class="form-label text-secondary small">
                                Phone Number
                            </label>
                            <div class="form-control bg-light">
                                ${admin.getPhone()}
                            </div>
                        </div>

                        <!-- Gender -->
                        <div class="col-md-6">
                            <label class="form-label text-secondary small">
                                Gender
                            </label>
                            <div class="form-control bg-light">
                                ${admin.getGender()}
                            </div>
                        </div>

                        <!-- Age -->
                        <div class="col-md-6">
                            <label class="form-label text-secondary small">
                                Age
                            </label>
                            <div class="form-control bg-light">
                                ${admin.getAge()}
                            </div>
                        </div>

                        <!-- Account Status -->
                        <div class="col-md-6">
                            <label class="form-label text-secondary small">
                                Account Status
                            </label>
                            <div class="form-control bg-light">
                                <span class="${admin.status ? 'text-success' : 'text-danger'} fw-semibold">
                                    <i class="bi ${admin.status ? 'bi-check-circle-fill' : 'bi-x-circle-fill'} me-1"></i>
                                    ${admin.getStatus() ? 'Active' : 'Blocked'}
                                </span>
                            </div>
                        </div>

                    </div>

                    <hr class="my-4">

                    <!-- Action Buttons -->
                    <div class="d-flex flex-wrap gap-2 justify-content-between">

                        <a href="${pageContext.request.contextPath}/adminHome"
                           class="btn btn-outline-secondary">
                            <i class="bi bi-arrow-left me-1"></i>
                            Back to Home
                        </a>

                        <a href="${pageContext.request.contextPath}/admin/editProfile"
                           class="btn btn-primary">
                            <i class="bi bi-pencil-square me-1"></i>
                            Edit Profile
                        </a>

                    </div>

                </div>
            </div>

        </div>

    </main>

    <!-- Common Footer -->
    <%@ include file="/WEB-INF/views/common/footer.jsp" %>

    <script>
        function previewPhoto(event) {
            const file = event.target.files[0];

            if (!file) {
                return;
            }

            if (!file.type.startsWith("image/")) {
                event.target.value = "";
                return;
            }

            const reader = new FileReader();

            reader.onload = function (e) {
                document.getElementById("photoPreview").src = e.target.result;
            };

            reader.readAsDataURL(file);
        }
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>