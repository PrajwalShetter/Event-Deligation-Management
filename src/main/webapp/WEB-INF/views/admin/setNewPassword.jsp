<%@ page isELIgnored="false" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Set New Password</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">
</head>

<body class="bg-light">
<%@ include file="/WEB-INF/views/common/navbar.jsp" %>

<div class="container min-vh-100 d-flex justify-content-center align-items-center py-5">

    <div class="card border-0 shadow rounded-4 w-100"
         style="max-width: 480px;">

        <div class="card-body p-4 p-md-5">

            <!-- Heading -->
            <div class="text-center mb-4">
                <div class="bg-primary-subtle text-primary rounded-circle
                            d-inline-flex align-items-center justify-content-center mb-3"
                     style="width: 70px; height: 70px;">
                    <span class="fs-2">&#128274;</span>
                </div>

                <h3 class="fw-bold">Set New Password</h3>

                <p class="text-secondary">
                    Create a new password for your account.
                </p>
            </div>

            <!-- Password Reset Form -->
            <form action="${pageContext.request.contextPath}/admin/setNewPassword"
                  method="post"
                  onsubmit="return validatePasswords()">

                <!-- Hidden Email -->
                <input type="hidden"
                       name="email"
                       value="${email}">

                <!-- New Password -->
                <div class="mb-3">
                    <label for="newPassword" class="form-label fw-semibold">
                        New Password
                    </label>

                    <input type="password"
                           class="form-control form-control-lg"
                           id="newPassword"
                           name="newPassword"
                           placeholder="Enter new password"
                           minlength="8"
                           oninput="validatePasswords()"
                           required>

                    <div id="newPasswordError" class="text-danger small mt-2"></div>
                </div>

                <!-- Confirm Password -->
                <div class="mb-3">
                    <label for="confirmPassword" class="form-label fw-semibold">
                        Confirm Password
                    </label>

                    <input type="password"
                           class="form-control form-control-lg"
                           id="confirmPassword"
                           name="confirmPassword"
                           placeholder="Confirm new password"
                           onchange ="validatePasswords()"
                           minlength="8"
                           required>

                    <div id="passwordError" class="text-danger small mt-2"></div>
                </div>

                <!-- Submit Button -->
                <button type="submit" class="btn btn-primary btn-lg w-100 mt-3">
                    Update Password
                </button>

            </form>

        </div>
    </div>
</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
<script>
   function validatePasswords() {

       var newPassword = document.getElementById("newPassword").value;
       var confirmPassword = document.getElementById("confirmPassword").value;

       var newPasswordError = document.getElementById("newPasswordError");
       var passwordError = document.getElementById("passwordError");

       var passwordPattern = /^(?=.*[A-Z])(?=.*[^a-zA-Z0-9]).{8,20}$/;

       if (newPassword.length > 0 && !passwordPattern.test(newPassword)) {
           newPasswordError.innerText =
               "Password must contain 8–20 characters, 1 uppercase letter and 1 symbol.";
       } else {
           newPasswordError.innerText = "";
       }

       if (confirmPassword.length > 0 && newPassword !== confirmPassword) {
           passwordError.innerText = "Passwords do not match.";
       } else {
           passwordError.innerText = "";
       }

       return passwordPattern.test(newPassword) &&
              newPassword === confirmPassword;
   }
</script>

</body>
</html>