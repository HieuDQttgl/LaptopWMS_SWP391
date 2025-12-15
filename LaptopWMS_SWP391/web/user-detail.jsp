<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Model.Users" %>
<%@ page import="Model.Role" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
    <jsp:include page="header.jsp" />

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>User Details</title>

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
                min-height: 100vh;
                color: var(--text-main);
            }

            .detail-wrapper {
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 40px 16px;
            }

            .card {
                width: 100%;
                max-width: 600px;
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
                font-size: 12px;
                border-radius: 999px;
                border: 1px solid;
            }

            .badge.active {
                background-color: #d1fae5;
                color: #065f46;
                border-color: #6ee7b7;
            }

            .badge.inactive {
                background-color: #fee2e2;
                color: #991b1b;
                border-color: #fca5a5;
            }

            .detail-body {
                margin-top: 6px;
            }

            .field-group {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 8px 0;
                border-bottom: 1px solid #f3f4f6;
                font-size: 14px;
            }

            .field-label {
                color: var(--text-muted);
            }

            .field-value {
                font-weight: 500;
                text-align: right;
                max-width: 60%;
                word-break: break-word;
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
                margin-top: 24px;
                display: flex;
                justify-content: flex-end;
                gap: 8px;
                flex-wrap: wrap;
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
                text-decoration: none;
                display: inline-block;
            }

            .btn-secondary:hover {
                background: var(--bg-color);
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
                text-decoration: none;
                display: inline-block;
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
        <div class="detail-wrapper">
            <div class="card">
                <div class="card-header">
                    <div class="card-header-left">
                        <h1>User Details</h1>
                        <p>Detailed information about this user</p>
                    </div>
                    <% Users user = (Users) request.getAttribute("user");
                        Users currentUser = (Users) request.getAttribute("currentUser");
                        boolean isAdmin = currentUser != null
                                && currentUser.getRoleId() == 1;
                        if (user != null && "active"
                                .equalsIgnoreCase(user.getStatus())) { %>
                    <span class="badge active">Active</span>
                    <% } else if (user != null) { %>
                    <span class="badge inactive">Inactive</span>
                    <% } %>
                </div>

                <% String successMsg = (String) request.getAttribute("success");
                    String errorMsg = (String) request.getAttribute("error");
                    if (successMsg != null) {%>
                <div class="message success">
                    <%= successMsg%>
                </div>
                <% } %>
                <% if (errorMsg != null) {%>
                <div class="message error">
                    <%= errorMsg%>
                </div>
                <% } %>

                <% if (user != null) {
                        SimpleDateFormat sdf = new SimpleDateFormat(
                                "dd/MM/yyyy HH:mm:ss");
                        Role role = (Role) request.getAttribute("role");
                        Users creator = (Users) request.getAttribute("creator");
                        String username = user.getUsername() != null ? user.getUsername() : "";
                        String fullName = user.getFullName() != null ? user.getFullName() : "";
                        String email = user.getEmail() != null ? user.getEmail() : "";
                        String phoneNumber = user.getPhoneNumber() != null ? user.getPhoneNumber() : "";
                        String gender = user.getGender() != null ? user.getGender() : "";%>

                <form method="post" action="<%= request.getContextPath()%>/user-detail"
                      id="userForm">
                    <input type="hidden" name="userId" value="<%= user.getUserId()%>">

                    <div class="detail-body">
                        <div class="field-group">
                            <span class="field-label">User ID</span>
                            <span class="field-value">
                                <%= user.getUserId()%>
                            </span>
                        </div>

                        <!-- Username -->
                        <div class="field-group view-mode">
                            <span class="field-label">Username</span>
                            <span class="field-value">
                                <%= username.isEmpty() ? "—" : username%>
                            </span>
                        </div>
                        <% if (isAdmin) {%>
                        <div class="field-group edit-mode">
                            <span class="field-label">Username</span>
                            <input type="text" name="username" class="field-input"
                                   value="<%= username%>" required>
                        </div>
                        <% }%>

                        <!-- Full Name -->
                        <div class="field-group view-mode">
                            <span class="field-label">Full Name</span>
                            <span class="field-value">
                                <%= fullName.isEmpty() ? "—" : fullName%>
                            </span>
                        </div>
                        <% if (isAdmin) {%>
                        <div class="field-group edit-mode">
                            <span class="field-label">Full Name</span>
                            <input type="text" name="fullName"
                                   class="field-input" value="<%= fullName%>">
                        </div>
                        <% }%>

                        <!-- Email -->
                        <div class="field-group view-mode">
                            <span class="field-label">Email</span>
                            <span class="field-value">
                                <%= email.isEmpty() ? "—" : email%>
                            </span>
                        </div>
                        <% if (isAdmin) {%>
                        <div class="field-group edit-mode">
                            <span class="field-label">Email</span>
                            <input type="email" name="email"
                                   class="field-input"
                                   value="<%= email%>">
                        </div>
                        <% }%>

                        <!-- Phone Number -->
                        <div class="field-group view-mode">
                            <span class="field-label">Phone
                                Number</span>
                            <span class="field-value">
                                <%= phoneNumber.isEmpty() ? "—"
                                        : phoneNumber%>
                            </span>
                        </div>
                        <% if (isAdmin) {%>
                        <div class="field-group edit-mode">
                            <span class="field-label">Phone
                                Number</span>
                            <input type="text"
                                   name="phoneNumber"
                                   class="field-input"
                                   value="<%= phoneNumber%>">
                        </div>
                        <% }%>

                        <!-- Gender -->
                        <div
                            class="field-group view-mode">
                            <span
                                class="field-label">Gender</span>
                            <span class="field-value">
                                <%= gender.isEmpty()
                                        ? "—" : gender%>
                            </span>
                        </div>
                        <% if (isAdmin) {%>
                        <div
                            class="field-group edit-mode">
                            <span
                                class="field-label">Gender</span>
                            <select name="gender"
                                    class="field-select">
                                    <option value=""
                                    <%=gender.isEmpty()
                                                ? "selected"
                                                : ""%>>—
                                </option>
                                        <option value="Male"
                                    <%="Male"
                                                .equals(gender)
                                                ? "selected"
                                                : ""%>>Male
                                </option>
                                <option
                                    value="Female"
                                    <%="Female"
                                            .equals(gender)
                                            ? "selected"
                                            : ""%>>Female
                                </option>
                                <option
                                    value="Other"
                                    <%="Other"
                                            .equals(gender)
                                            ? "selected"
                                            : ""%>>Other
                                </option>
                            </select>
                        </div>
                        <% }%>

                        <!-- Role (View Only) -->
                        <div
                            class="field-group">
                            <span
                                class="field-label">Role</span>
                            <span
                                class="field-value">
                                <%= role != null
                                        ? role.getRoleName()
                                        : "—"%>
                            </span>
                        </div>

                        <div
                            class="field-group">
                            <span
                                class="field-label">Status</span>
                            <span
                                class="field-value">
                                <%= user.getStatus()
                                        != null
                                                ? user.getStatus()
                                                : "—"%>
                            </span>
                        </div>

                        <div
                            class="field-group">
                            <span
                                class="field-label">Last
                                Login</span>
                            <span
                                class="field-value muted">
                                <%= user.getLastLoginAt()
                                        != null
                                                ? sdf.format(user.getLastLoginAt())
                                                : "Never logged in"%>
                            </span>
                        </div>

                        <div
                            class="field-group">
                            <span
                                class="field-label">Created
                                At</span>
                            <span
                                class="field-value muted">
                                <%= user.getCreatedAt()
                                        != null
                                                ? sdf.format(user.getCreatedAt())
                                                : "—"%>
                            </span>
                        </div>

                        <div
                            class="field-group">
                            <span
                                class="field-label">Updated
                                At</span>
                            <span
                                class="field-value muted">
                                <%= user.getUpdatedAt()
                                        != null
                                                ? sdf.format(user.getUpdatedAt())
                                                : "—"%>
                            </span>
                        </div>

                        <div
                            class="field-group">
                            <span
                                class="field-label">Created
                                By</span>
                            <span
                                class="field-value muted">
                                <%= creator
                                        != null
                                                ? creator.getUsername()
                                                : (user.getCreatedBy()
                                                != null
                                                        ? "User ID: "
                                                        + user.getCreatedBy()
                                                        : "—")%>
                            </span>
                        </div>
                    </div>

                    <% if (isAdmin) { %>
                    <div class="actions edit-mode" style="display: none;">
                        <button type="button" onclick="cancelEdit()"
                                class="btn-secondary">Cancel</button>
                        <button type="submit" class="btn-primary">Save
                            Changes</button>
                    </div>
                    <% }%>
                </form>

                <div class="actions view-mode">
                    <a href="<%= request.getContextPath()%>/user-list"
                       class="btn-secondary">Back to User List</a>
                    <% if (isAdmin) {%>
                    <a href="<%= request.getContextPath()%>/edit-role?id=<%= user.getUserId()%>"
                       class="btn-secondary">Edit Role</a>
                    <button type="button" onclick="enableEditMode()"
                            class="btn-primary">Edit User</button>
                    <% } %>
                </div>

                <% } else {%>

                <div class="detail-body">
                    <p>User not found.</p>
                </div>

                <div class="actions">
                    <a href="<%= request.getContextPath()%>/user-list"
                       class="btn-secondary">Back to User List</a>
                </div>

                <% }%>

            </div>
        </div>
        <jsp:include page="footer.jsp" />
    </body>

</html>