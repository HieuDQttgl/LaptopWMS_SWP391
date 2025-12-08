<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>My Profile</title>
        <style>
            :root {
                --primary-color: #2563eb;
                --primary-hover: #1d4ed8;
                --bg-color: #f3f4f6;
                --card-bg: #ffffff;
                --border-color: #e5e7eb;
                --text-main: #111827;
                --text-muted: #6b7280;
                --radius-lg: 12px;
                --shadow-soft: 0 10px 25px rgba(15, 23, 42, 0.12);
            }

            * {
                box-sizing: border-box;
            }

            body {
                margin: 0;
                font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
                background: radial-gradient(circle at top left, #dbeafe 0, #eff6ff 25%, #f9fafb 60%);
                display: flex;
                align-items: center;
                justify-content: center;
                min-height: 100vh;
                color: var(--text-main);
            }

            .profile-wrapper {
                width: 100%;
                max-width: 520px;
                padding: 16px;
            }

            .card {
                background: var(--card-bg);
                border-radius: var(--radius-lg);
                box-shadow: var(--shadow-soft);
                padding: 28px 26px 26px;
                border: 1px solid var(--border-color);
            }

            .card-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 18px;
            }

            .card-header-left h1 {
                margin: 0 0 4px;
                font-size: 22px;
                font-weight: 600;
            }

            .card-header-left p {
                margin: 0;
                font-size: 13px;
                color: var(--text-muted);
            }

            .badge {
                padding: 4px 10px;
                background-color: #e0f2fe;
                color: #0369a1;
                font-size: 12px;
                border-radius: 999px;
                border: 1px solid #bae6fd;
            }

            .profile-body {
                margin-top: 6px;
            }

            .field-group {
                display: flex;
                justify-content: space-between;
                padding: 8px 0;
                border-bottom: 1px solid #f3f4f6;
                font-size: 14px;
            }

            .field-label {
                color: var(--text-muted);
            }

            .field-value {
                font-weight: 500;
            }

            .field-value.muted {
                color: var(--text-muted);
                font-weight: 400;
            }

            .field-input {
                width: 200px;
                padding: 6px 10px;
                border: 1px solid var(--border-color);
                border-radius: 6px;
                font-size: 14px;
                font-family: inherit;
            }

            .field-input:focus {
                outline: none;
                border-color: var(--primary-color);
                box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
            }

            .field-select {
                width: 200px;
                padding: 6px 10px;
                border: 1px solid var(--border-color);
                border-radius: 6px;
                font-size: 14px;
                font-family: inherit;
                background: white;
            }

            .field-select:focus {
                outline: none;
                border-color: var(--primary-color);
                box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
            }

            .edit-mode {
                display: none;
            }

            .view-mode {
                display: flex;
            }

            .message {
                padding: 12px 16px;
                border-radius: 8px;
                margin-bottom: 16px;
                font-size: 14px;
            }

            .message.success {
                background-color: #d1fae5;
                color: #065f46;
                border: 1px solid #6ee7b7;
            }

            .message.error {
                background-color: #fee2e2;
                color: #991b1b;
                border: 1px solid #fca5a5;
            }

            .actions {
                margin-top: 18px;
                display: flex;
                justify-content: flex-end;
                gap: 8px;
            }

            .btn-secondary {
                padding: 7px 14px;
                border-radius: 999px;
                border: 1px solid var(--border-color);
                background: white;
                color: var(--text-main);
                font-weight: 500;
                font-size: 13px;
                cursor: pointer;
                transition: background 0.15s ease;
            }

            .btn-secondary:hover {
                background: var(--bg-color);
            }

            .btn-link {
                border: none;
                background: transparent;
                color: var(--text-muted);
                font-size: 13px;
                cursor: pointer;
                padding: 6px 10px;
            }

            .btn-primary {
                padding: 7px 14px;
                border-radius: 999px;
                border: none;
                background: linear-gradient(135deg, var(--primary-color), #3b82f6);
                color: #ffffff;
                font-weight: 500;
                font-size: 13px;
                cursor: pointer;
                transition: background 0.15s ease, transform 0.05s ease, box-shadow 0.05s ease;
                box-shadow: 0 8px 18px rgba(37, 99, 235, 0.3);
            }

            .btn-primary:hover {
                background: linear-gradient(135deg, var(--primary-hover), #2563eb);
                transform: translateY(-1px);
            }

            .btn-primary:active {
                transform: translateY(0);
                box-shadow: 0 6px 14px rgba(37, 99, 235, 0.25);
            }

            @media (max-width: 540px) {
                .card {
                    padding: 22px 18px 20px;
                }
            }
        </style>
        <script>
            function enableEditMode() {
                document.querySelectorAll('.view-mode').forEach(el => el.style.display = 'none');
                document.querySelectorAll('.edit-mode').forEach(el => {
                    if (el.classList.contains('field-group')) {
                        el.style.display = 'flex';
                    } else {
                        el.style.display = 'block';
                    }
                });
            }

            function cancelEdit() {
                document.querySelectorAll('.edit-mode').forEach(el => el.style.display = 'none');
                document.querySelectorAll('.view-mode').forEach(el => {
                    if (el.classList.contains('field-group')) {
                        el.style.display = 'flex';
                    } else {
                        el.style.display = 'block';
                    }
                });
            }
        </script>
    </head>
    <body>
        <div class="profile-wrapper">
            <div class="card">
                <div class="card-header">
                    <div class="card-header-left">
                        <h1>My profile</h1>
                        <p>Basic information about your account</p>
                    </div>
                    <span class="badge">Signed in</span>
                </div>

                <%
                    String successMsg = (String) request.getAttribute("success");
                    String errorMsg = (String) request.getAttribute("error");
                    Model.Users currentUser = (Model.Users) request.getSession().getAttribute("currentUser");
                    String fullName = currentUser != null ? (currentUser.getFullName() != null ? currentUser.getFullName() : "") : "";
                    String email = currentUser != null ? (currentUser.getEmail() != null ? currentUser.getEmail() : "") : "";
                    String phoneNumber = currentUser != null ? (currentUser.getPhoneNumber() != null ? currentUser.getPhoneNumber() : "") : "";
                    String gender = currentUser != null ? (currentUser.getGender() != null ? currentUser.getGender() : "") : "";
                %>

                <% if (successMsg != null) {%>
                <div class="message success"><%= successMsg%></div>
                <% } %>
                <% if (errorMsg != null) {%>
                <div class="message error"><%= errorMsg%></div>
                <% }%>

                <form method="post" action="<%= request.getContextPath()%>/profile" id="profileForm">
                    <div class="profile-body">
                        <div class="field-group view-mode">
                            <span class="field-label">Full name</span>
                            <span class="field-value"><%= fullName.isEmpty() ? "—" : fullName%></span>
                        </div>
                        <div class="field-group edit-mode">
                            <span class="field-label">Full name</span>
                            <input type="text" name="fullName" class="field-input" value="<%= fullName%>" required>
                        </div>

                        <div class="field-group">
                            <span class="field-label">Username</span>
                            <span class="field-value"><%= request.getSession().getAttribute("username")%></span>
                        </div>

                        <div class="field-group view-mode">
                            <span class="field-label">Email</span>
                            <span class="field-value"><%= email.isEmpty() ? "—" : email%></span>
                        </div>
                        <div class="field-group edit-mode">
                            <span class="field-label">Email</span>
                            <input type="email" name="email" class="field-input" value="<%= email%>" required>
                        </div>

                        <div class="field-group view-mode">
                            <span class="field-label">Phone</span>
                            <span class="field-value"><%= phoneNumber.isEmpty() ? "—" : phoneNumber%></span>
                        </div>
                        <div class="field-group edit-mode">
                            <span class="field-label">Phone</span>
                            <input type="text" name="phoneNumber" class="field-input" value="<%= phoneNumber%>" required>
                        </div>

                        <div class="field-group view-mode">
                            <span class="field-label">Gender</span>
                            <span class="field-value"><%= gender.isEmpty() ? "—" : gender%></span>
                        </div>
                        <div class="field-group edit-mode">
                            <span class="field-label">Gender</span>
                            <select name="gender" class="field-select">
                                <option value="" <%= gender.isEmpty() ? "selected" : ""%>>—</option>
                                <option value="Male" <%= "Male".equals(gender) ? "selected" : ""%>>Male</option>
                                <option value="Female" <%= "Female".equals(gender) ? "selected" : ""%>>Female</option>
                                <option value="Other" <%= "Other".equals(gender) ? "selected" : ""%>>Other</option>
                            </select>
                        </div>
                    </div>

                    <div class="actions edit-mode" style="display: none;">
                        <button type="button" onclick="cancelEdit()" class="btn-secondary">Cancel</button>
                        <button type="submit" class="btn-primary">Save Changes</button>
                    </div>
                </form>

                <div class="actions view-mode">
                    <form method="get" action="<%= request.getContextPath()%>/landing" style="display: inline;">
                        <button type="submit" class="btn-link">Back to home</button>
                    </form>
                    <button type="button" onclick="enableEditMode()" class="btn-primary">Edit Profile</button>
                    <form method="get" action="<%= request.getContextPath()%>/change-password" style="display: inline;">
                        <button type="submit" class="btn-primary">Change password</button>
                    </form>
                    <form method="get" action="<%= request.getContextPath()%>/logout" style="display: inline;">
                        <button type="submit" class="btn-primary">Sign out</button>
                    </form>
                </div>
            </div>
        </div>
    </body>
    <script>
        function validateProfileForm(event) {
            const email = document.querySelector('input[name="email"]').value.trim();
            const phone = document.querySelector('input[name="phoneNumber"]').value.trim();

            // Email regex (RFC-compliant simplified)
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

            // Vietnamese phone format: 10 digits starting with 03,05,07,08,09
            const phoneRegex = /^(03|05|07|08|09)\d{8}$/;

            // Validate email
            if (!emailRegex.test(email)) {
                alert("❌ Invalid email format.");
                event.preventDefault();
                return false;
            }

            // Validate phone (optional field)
            if (phone.length > 0 && !phoneRegex.test(phone)) {
                alert("❌ Phone number must be 10 digits and start with 03, 05, 07, 08 or 09.");
                event.preventDefault();
                return false;
            }

            return true;
        }

        window.onload = function () {
            document.getElementById("profileForm").addEventListener("submit", validateProfileForm);
        };
    </script>
</html>


