<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="Model.Users" %>
<%@ page import="Model.Role" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
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
                display: flex;
                align-items: center;
                justify-content: center;
                min-height: 100vh;
                color: var(--text-main);
            }

            .detail-wrapper {
                width: 100%;
                max-width: 600px;
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

            .actions {
                margin-top: 24px;
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
    </head>
    <body>
        <div class="detail-wrapper">
            <div class="card">
                <div class="card-header">
                    <div class="card-header-left">
                        <h1>User Details</h1>
                        <p>Detailed information about this user</p>
                    </div>
                    <%
                        Users user = (Users) request.getAttribute("user");
                        if (user != null && "active".equalsIgnoreCase(user.getStatus())) {
                    %>
                    <span class="badge active">Active</span>
                    <% } else { %>
                    <span class="badge inactive">Inactive</span>
                    <% } %>
                </div>

                <%
                    if (user != null) {
                        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
                        Role role = (Role) request.getAttribute("role");
                        Users creator = (Users) request.getAttribute("creator");
                %>

                <div class="detail-body">
                    <div class="field-group">
                        <span class="field-label">User ID</span>
                        <span class="field-value"><%= user.getUserId() %></span>
                    </div>

                    <div class="field-group">
                        <span class="field-label">Username</span>
                        <span class="field-value"><%= user.getUsername() != null ? user.getUsername() : "—" %></span>
                    </div>

                    <div class="field-group">
                        <span class="field-label">Full Name</span>
                        <span class="field-value"><%= user.getFullName() != null ? user.getFullName() : "—" %></span>
                    </div>

                    <div class="field-group">
                        <span class="field-label">Email</span>
                        <span class="field-value"><%= user.getEmail() != null ? user.getEmail() : "—" %></span>
                    </div>

                    <div class="field-group">
                        <span class="field-label">Phone Number</span>
                        <span class="field-value"><%= user.getPhoneNumber() != null ? user.getPhoneNumber() : "—" %></span>
                    </div>

                    <div class="field-group">
                        <span class="field-label">Gender</span>
                        <span class="field-value"><%= user.getGender() != null ? user.getGender() : "—" %></span>
                    </div>

                    <div class="field-group">
                        <span class="field-label">Role</span>
                        <span class="field-value"><%= role != null ? role.getRoleName() : "—" %></span>
                    </div>

                    <div class="field-group">
                        <span class="field-label">Status</span>
                        <span class="field-value"><%= user.getStatus() != null ? user.getStatus() : "—" %></span>
                    </div>

                    <div class="field-group">
                        <span class="field-label">Last Login</span>
                        <span class="field-value muted">
                            <%= user.getLastLoginAt() != null ? sdf.format(user.getLastLoginAt()) : "Never logged in" %>
                        </span>
                    </div>

                    <div class="field-group">
                        <span class="field-label">Created At</span>
                        <span class="field-value muted">
                            <%= user.getCreatedAt() != null ? sdf.format(user.getCreatedAt()) : "—" %>
                        </span>
                    </div>

                    <div class="field-group">
                        <span class="field-label">Updated At</span>
                        <span class="field-value muted">
                            <%= user.getUpdatedAt() != null ? sdf.format(user.getUpdatedAt()) : "—" %>
                        </span>
                    </div>

                    <div class="field-group">
                        <span class="field-label">Created By</span>
                        <span class="field-value muted">
                            <%= creator != null ? creator.getUsername() : (user.getCreatedBy() != null ? "User ID: " + user.getCreatedBy() : "—") %>
                        </span>
                    </div>
                </div>

                <div class="actions">
                    <a href="<%= request.getContextPath() %>/user-list" class="btn-secondary">Back to User List</a>
                    <a href="<%= request.getContextPath() %>/edit-role?id=<%= user.getUserId() %>" class="btn-primary">Edit Role</a>
                </div>

                <% } else { %>

                <div class="detail-body">
                    <p>User not found.</p>
                </div>

                <div class="actions">
                    <a href="<%= request.getContextPath() %>/user-list" class="btn-secondary">Back to User List</a>
                </div>

                <% } %>

            </div>
        </div>
    </body>
</html>

