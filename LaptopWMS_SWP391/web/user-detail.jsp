<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="Model.Users" %>
        <%@ page import="Model.Role" %>
            <%@ page import="java.util.List" %>
                <!DOCTYPE html>
                <html>

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>User Detail | Laptop WMS</title>
                    <link
                        href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap"
                        rel="stylesheet">
                    <style>
                        body {
                            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
                            background: linear-gradient(135deg, #f0f4ff 0%, #f8fafc 50%, #f0fdf4 100%);
                            margin: 0;
                            padding: 0;
                            min-height: 100vh;
                        }

                        .page-container {
                            max-width: 600px;
                            margin: 2rem auto;
                            padding: 2rem;
                        }

                        .card {
                            background: white;
                            border-radius: 1rem;
                            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
                            padding: 2rem;
                            border: 1px solid #f1f5f9;
                            animation: fadeIn 0.3s ease-out;
                        }

                        @keyframes fadeIn {
                            from {
                                opacity: 0;
                                transform: translateY(-10px);
                            }

                            to {
                                opacity: 1;
                                transform: translateY(0);
                            }
                        }

                        .card-header {
                            display: flex;
                            justify-content: space-between;
                            align-items: center;
                            margin-bottom: 1.5rem;
                            padding-bottom: 1rem;
                            border-bottom: 1px solid #f1f5f9;
                        }

                        .card-header h1 {
                            margin: 0;
                            font-size: 1.5rem;
                            font-weight: 700;
                            color: #1e293b;
                            display: flex;
                            align-items: center;
                            gap: 0.5rem;
                        }

                        .card-header p {
                            margin: 0.25rem 0 0;
                            font-size: 0.875rem;
                            color: #64748b;
                        }

                        .badge {
                            display: inline-flex;
                            align-items: center;
                            gap: 0.25rem;
                            padding: 0.375rem 0.875rem;
                            border-radius: 2rem;
                            font-size: 0.6875rem;
                            font-weight: 600;
                            text-transform: uppercase;
                        }

                        .badge.active {
                            background: linear-gradient(135deg, #dcfce7 0%, #bbf7d0 100%);
                            color: #16a34a;
                        }

                        .badge.inactive {
                            background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
                            color: #dc2626;
                        }

                        .message {
                            display: flex;
                            align-items: center;
                            gap: 0.5rem;
                            padding: 1rem 1.25rem;
                            border-radius: 0.75rem;
                            margin-bottom: 1.5rem;
                            font-weight: 500;
                        }

                        .message.success {
                            background: linear-gradient(135deg, #dcfce7 0%, #bbf7d0 100%);
                            color: #16a34a;
                            border: 1px solid #86efac;
                        }

                        .message.error {
                            background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
                            color: #dc2626;
                            border: 1px solid #fca5a5;
                        }

                        .detail-body {
                            margin-top: 0.5rem;
                        }

                        .field-group {
                            display: flex;
                            justify-content: space-between;
                            align-items: center;
                            padding: 0.875rem 0;
                            border-bottom: 1px solid #f1f5f9;
                        }

                        .field-label {
                            font-size: 0.875rem;
                            color: #64748b;
                            font-weight: 500;
                        }

                        .field-value {
                            font-size: 0.9375rem;
                            font-weight: 600;
                            color: #1e293b;
                            text-align: right;
                            max-width: 60%;
                            word-break: break-word;
                        }

                        .field-input {
                            width: 220px;
                            padding: 0.625rem 0.875rem;
                            border: 2px solid #e2e8f0;
                            border-radius: 0.5rem;
                            font-size: 0.875rem;
                            font-family: inherit;
                            outline: none;
                            transition: all 0.2s ease;
                        }

                        .field-input:focus {
                            border-color: #667eea;
                            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.15);
                        }

                        .field-select {
                            width: 220px;
                            padding: 0.625rem 0.875rem;
                            border: 2px solid #e2e8f0;
                            border-radius: 0.5rem;
                            font-size: 0.875rem;
                            font-family: inherit;
                            background: white;
                            outline: none;
                            transition: all 0.2s ease;
                        }

                        .field-select:focus {
                            border-color: #667eea;
                            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.15);
                        }

                        .edit-mode {
                            display: none;
                        }

                        .view-mode {
                            display: flex;
                        }

                        .actions {
                            margin-top: 1.5rem;
                            padding-top: 1rem;
                            display: flex;
                            justify-content: flex-end;
                            gap: 0.75rem;
                            flex-wrap: wrap;
                        }

                        .btn {
                            padding: 0.625rem 1.25rem;
                            border-radius: 0.5rem;
                            font-weight: 600;
                            font-size: 0.8125rem;
                            cursor: pointer;
                            transition: all 0.2s ease;
                            text-decoration: none;
                            display: inline-flex;
                            align-items: center;
                            gap: 0.5rem;
                            border: none;
                        }

                        .btn-secondary {
                            background: #e2e8f0;
                            color: #475569;
                        }

                        .btn-secondary:hover {
                            background: #cbd5e1;
                            color: #475569;
                        }

                        .btn-primary {
                            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                            color: white;
                            box-shadow: 0 4px 14px rgba(102, 126, 234, 0.4);
                        }

                        .btn-primary:hover {
                            transform: translateY(-1px);
                            box-shadow: 0 6px 18px rgba(102, 126, 234, 0.5);
                        }

                        .btn-danger {
                            background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
                            color: white;
                            box-shadow: 0 4px 14px rgba(239, 68, 68, 0.4);
                        }

                        .btn-danger:hover {
                            transform: translateY(-1px);
                            box-shadow: 0 6px 18px rgba(239, 68, 68, 0.5);
                        }

                        .back-link {
                            display: inline-flex;
                            align-items: center;
                            gap: 0.5rem;
                            margin-bottom: 1.5rem;
                            font-size: 0.875rem;
                            color: #64748b;
                            text-decoration: none;
                            font-weight: 500;
                        }

                        .back-link:hover {
                            color: #667eea;
                        }

                        @media (max-width: 540px) {
                            .page-container {
                                padding: 1rem;
                                margin: 1rem;
                            }

                            .card {
                                padding: 1.5rem;
                            }

                            .field-group {
                                flex-direction: column;
                                align-items: flex-start;
                                gap: 0.5rem;
                            }

                            .field-value {
                                text-align: left;
                                max-width: 100%;
                            }

                            .field-input,
                            .field-select {
                                width: 100%;
                            }

                            .actions {
                                flex-direction: column;
                            }

                            .btn {
                                width: 100%;
                                justify-content: center;
                            }
                        }
                    </style>
                </head>

                <body>
                    <jsp:include page="header.jsp" />

                    <div class="page-container">
                        <a href="<%= request.getContextPath()%>/user-list" class="back-link">← Back to User List</a>

                        <div class="card">
                            <% Users user=(Users) request.getAttribute("user"); Users currentUser=(Users)
                                request.getAttribute("currentUser"); boolean isAdmin=currentUser !=null &&
                                currentUser.getRoleId()==1; %>

                                <div class="card-header">
                                    <div>
                                        <h1>👤 User Details</h1>
                                        <p>Detailed information about this user</p>
                                    </div>
                                    <% if (user !=null && "active" .equalsIgnoreCase(user.getStatus())) { %>
                                        <span class="badge active">● Active</span>
                                        <% } else if (user !=null) { %>
                                            <span class="badge inactive">● Inactive</span>
                                            <% } %>
                                </div>

                                <% String successMsg=(String) request.getAttribute("success"); String errorMsg=(String)
                                    request.getAttribute("error"); if (successMsg !=null) { %>
                                    <div class="message success">✓ <%= successMsg%>
                                    </div>
                                    <% } %>
                                        <% if (errorMsg !=null) { %>
                                            <div class="message error">⚠ <%= errorMsg%>
                                            </div>
                                            <% } %>

                                                <% if (user !=null) { Role role=(Role) request.getAttribute("role");
                                                    String username=user.getUsername() !=null ? user.getUsername() : ""
                                                    ; String fullName=user.getFullName() !=null ? user.getFullName()
                                                    : "" ; String email=user.getEmail() !=null ? user.getEmail() : "" ;
                                                    %>

                                                    <form method="post"
                                                        action="<%= request.getContextPath()%>/user-detail"
                                                        id="userForm">
                                                        <input type="hidden" name="userId"
                                                            value="<%= user.getUserId()%>">

                                                        <div class="detail-body">
                                                            <div class="field-group">
                                                                <span class="field-label">User ID</span>
                                                                <span class="field-value">#<%= user.getUserId()%></span>
                                                            </div>

                                                            <div class="field-group view-mode">
                                                                <span class="field-label">Username</span>
                                                                <span class="field-value">
                                                                    <%= username.isEmpty() ? "—" : username%>
                                                                </span>
                                                            </div>
                                                            <% if (isAdmin) { %>
                                                                <div class="field-group edit-mode">
                                                                    <span class="field-label">Username</span>
                                                                    <input type="text" name="username"
                                                                        class="field-input" value="<%= username%>"
                                                                        required>
                                                                </div>
                                                                <% } %>

                                                                    <div class="field-group view-mode">
                                                                        <span class="field-label">Full Name</span>
                                                                        <span class="field-value">
                                                                            <%= fullName.isEmpty() ? "—" : fullName%>
                                                                        </span>
                                                                    </div>
                                                                    <% if (isAdmin) { %>
                                                                        <div class="field-group edit-mode">
                                                                            <span class="field-label">Full Name</span>
                                                                            <input type="text" name="fullName"
                                                                                class="field-input"
                                                                                value="<%= fullName%>">
                                                                        </div>
                                                                        <% } %>

                                                                            <div class="field-group view-mode">
                                                                                <span class="field-label">Email</span>
                                                                                <span class="field-value">
                                                                                    <%= email.isEmpty() ? "—" : email%>
                                                                                </span>
                                                                            </div>
                                                                            <% if (isAdmin) { %>
                                                                                <div class="field-group edit-mode">
                                                                                    <span
                                                                                        class="field-label">Email</span>
                                                                                    <input type="email" name="email"
                                                                                        class="field-input"
                                                                                        value="<%= email%>">
                                                                                </div>
                                                                                <% } %>

                                                                                    <div class="field-group view-mode">
                                                                                        <span
                                                                                            class="field-label">Role</span>
                                                                                        <span class="field-value">
                                                                                            <%= role !=null ?
                                                                                                role.getRoleName() : "—"
                                                                                                %>
                                                                                        </span>
                                                                                    </div>
                                                                                    <% List<Role> roles = (List<Role>)
                                                                                            request.getAttribute("roles");
                                                                                            boolean canEditRole =
                                                                                            isAdmin && user.getRoleId()
                                                                                            != 1 &&
                                                                                            currentUser.getUserId() !=
                                                                                            user.getUserId();
                                                                                            if (canEditRole && roles !=
                                                                                            null) { %>
                                                                                            <div
                                                                                                class="field-group edit-mode">
                                                                                                <span
                                                                                                    class="field-label">Role</span>
                                                                                                <select name="roleId"
                                                                                                    class="field-select">
                                                                                                    <% for (Role r :
                                                                                                        roles) { if
                                                                                                        (r.getRoleId()
                                                                                                        !=1) { %>
                                                                                                        <option
                                                                                                            value="<%= r.getRoleId()%>"
                                                                                                            <%=r.getRoleId()==user.getRoleId()
                                                                                                            ? "selected"
                                                                                                            : "" %>><%=
                                                                                                                r.getRoleName()%>
                                                                                                        </option>
                                                                                                        <% } } %>
                                                                                                </select>
                                                                                            </div>
                                                                                            <% } else if (isAdmin) { %>
                                                                                                <div
                                                                                                    class="field-group edit-mode">
                                                                                                    <span
                                                                                                        class="field-label">Role</span>
                                                                                                    <span
                                                                                                        class="field-value"
                                                                                                        style="color: #64748b; font-style: italic;">
                                                                                                        <%= role !=null
                                                                                                            ?
                                                                                                            role.getRoleName()
                                                                                                            : "—" %>
                                                                                                            <% if
                                                                                                                (user.getRoleId()==1)
                                                                                                                { %>
                                                                                                                (Cannot
                                                                                                                change
                                                                                                                admin
                                                                                                                role)<%
                                                                                                                    }
                                                                                                                    else
                                                                                                                    if
                                                                                                                    (currentUser.getUserId()==user.getUserId())
                                                                                                                    { %>
                                                                                                                    (Cannot
                                                                                                                    change
                                                                                                                    own
                                                                                                                    role)
                                                                                                                    <% }
                                                                                                                        %>
                                                                                                    </span>
                                                                                                </div>
                                                                                                <% } %>

                                                                                                    <div
                                                                                                        class="field-group">
                                                                                                        <span
                                                                                                            class="field-label">Status</span>
                                                                                                        <span
                                                                                                            class="field-value">
                                                                                                            <%= user.getStatus()
                                                                                                                !=null ?
                                                                                                                user.getStatus()
                                                                                                                : "—" %>
                                                                                                        </span>
                                                                                                    </div>
                                                        </div>

                                                        <% if (isAdmin) { %>
                                                            <div class="actions edit-mode" style="display: none;">
                                                                <button type="button" onclick="cancelEdit()"
                                                                    class="btn btn-secondary">Cancel</button>
                                                                <button type="submit" class="btn btn-primary">Save
                                                                    Changes</button>
                                                            </div>
                                                            <% } %>
                                                    </form>

                                                    <div class="actions view-mode">
                                                        <a href="<%= request.getContextPath()%>/user-list"
                                                            class="btn btn-secondary">Back to List</a>
                                                        <% if (isAdmin) { %>
                                                            <button type="button" onclick="enableEditMode()"
                                                                class="btn btn-primary">Edit User</button>
                                                            <% if (user.getRoleId() !=1 && user.getEmail() !=null &&
                                                                !user.getEmail().isEmpty()) { %>
                                                                <button type="button" onclick="confirmResetPassword()"
                                                                    class="btn btn-danger">Reset Password</button>
                                                                <% } } %>
                                                    </div>

                                                    <% if (isAdmin && user.getRoleId() !=1) { %>
                                                        <form id="resetPasswordForm" method="post"
                                                            action="<%= request.getContextPath()%>/admin-reset-password"
                                                            style="display:none;">
                                                            <input type="hidden" name="userId"
                                                                value="<%= user.getUserId()%>">
                                                        </form>
                                                        <% } %>

                                                            <% } else { %>
                                                                <div class="detail-body"
                                                                    style="text-align: center; padding: 2rem; color: #64748b;">
                                                                    <p>User not found.</p>
                                                                </div>
                                                                <div class="actions" style="justify-content: center;">
                                                                    <a href="<%= request.getContextPath()%>/user-list"
                                                                        class="btn btn-secondary">Back to User List</a>
                                                                </div>
                                                                <% } %>
                        </div>
                    </div>

                    <script>
                        function enableEditMode() {
                            document.querySelectorAll('.view-mode').forEach(el => el.style.display = 'none');
                            document.querySelectorAll('.edit-mode').forEach(el => {
                                el.style.display = el.classList.contains('field-group') ? 'flex' : 'block';
                            });
                        }

                        function cancelEdit() {
                            document.querySelectorAll('.edit-mode').forEach(el => el.style.display = 'none');
                            document.querySelectorAll('.view-mode').forEach(el => {
                                el.style.display = el.classList.contains('field-group') ? 'flex' : 'block';
                            });
                        }

                        function confirmResetPassword() {
                            showConfirm({
                                icon: '🔑',
                                title: 'Reset Password?',
                                message: 'A new password will be sent to their email.',
                                confirmText: 'Reset Password',
                                type: 'danger',
                                onConfirm: function () {
                                    document.getElementById('resetPasswordForm').submit();
                                }
                            });
                        }
                    </script>

                    <%@include file="common-dialogs.jsp" %>
                        <jsp:include page="footer.jsp" />
                </body>

                </html>