<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

<footer class="bg-dark text-white py-3 mt-auto">
    <div class="container-fluid px-3 px-lg-4">
        <div class="row align-items-center">

            <!-- Empty left space -->
            <div class="col-md-3"></div>

            <!-- Center text -->
            <div class="col-md-6 text-center">
                <p class="mb-1">
                    &copy; All Rights Reserved ... Developed by Prajwal Shetter
                </p>
                <small class="text-white-50">
                    Simplifying Event and Delegate Management
                </small>
            </div>

            <!-- Timer and date on right -->
            <div class="col-md-3 text-center text-md-end">
                <div id="footerTime" class="fw-semibold"></div>
                <div id="footerDate" class="text-white-50 small"></div>
            </div>

        </div>
    </div>
</footer>

<script>
    function updateFooterClock() {
        const now = new Date();

        const time = now.toLocaleTimeString('en-US', {
            hour: '2-digit',
            minute: '2-digit',
            hour12: true
        });

        const day = String(now.getDate()).padStart(2, '0');
        const month = String(now.getMonth() + 1).padStart(2, '0');
        const year = now.getFullYear();

        document.getElementById('footerTime').textContent = time;
        document.getElementById('footerDate').textContent =
            day + '-' + month + '-' + year;
    }

    updateFooterClock();
    setInterval(updateFooterClock, 1000);
</script>