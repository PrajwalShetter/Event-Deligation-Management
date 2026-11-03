<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Update Successful</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
</head>
<body class="bg-light d-flex align-items-center justify-content-center vh-100">

    <div class="card border-0 shadow-sm p-4 text-center rounded-4" style="max-width: 450px; width: 100%;">
        <div class="card-body">
            <div class="mb-3 text-success">
                <i class="bi bi-check-circle-fill display-3"></i>
            </div>
            <h3 class="fw-bold mb-2">Update Successful!</h3>
            <p class="text-secondary mb-4">
                <c:out value="${success}"/>
            </p>
            <p class="text-muted small">Redirecting you back to your email inbox...</p>
            <div class="spinner-border spinner-border-sm text-primary" role="status"></div>
        </div>
    </div>

    <script>
        // Automatically close tab or redirect back to Gmail after 2.5 seconds
        setTimeout(() => {
            window.close();
            // Fallback if browser blocks window.close()
            window.location.href = "https://mail.google.com";
        }, 2500);
    </script>
</body>
</html>