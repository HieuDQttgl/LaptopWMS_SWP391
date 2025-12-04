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

            .actions {
                margin-top: 18px;
                display: flex;
                justify-content: flex-end;
                gap: 8px;
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

                <div class="profile-body">
                    <div class="field-group">
                        <span class="field-label">Full name</span>
                        <span class="field-value"><%= request.getSession().getAttribute("fullName") != null ? request.getSession().getAttribute("fullName") : "—" %></span>
                    </div>
                    <div class="field-group">
                        <span class="field-label">Username</span>
                        <span class="field-value"><%= request.getSession().getAttribute("username") %></span>
                    </div>
                    <div class="field-group">
                        <span class="field-label">Email</span>
                        <span class="field-value">
                            <%= request.getSession().getAttribute("currentUser") != null 
                                    ? ((Model.Users) request.getSession().getAttribute("currentUser")).getEmail() 
                                    : "" %>
                        </span>
                    </div>
                    <div class="field-group">
                        <span class="field-label">Phone</span>
                        <span class="field-value">
                            <%= request.getSession().getAttribute("currentUser") != null 
                                    ? ((Model.Users) request.getSession().getAttribute("currentUser")).getPhoneNumber() 
                                    : "" %>
                        </span>
                    </div>
                </div>

                <div class="actions">
                    <form method="get" action="<%= request.getContextPath() %>/home">
                        <button type="submit" class="btn-link">Back to home</button>
                    </form>
                    <form method="get" action="<%= request.getContextPath() %>/change-password">
                        <button type="submit" class="btn-primary">Change password</button>
                    </form>

                    <form method="get" action="<%= request.getContextPath() %>/logout">
                        <button type="submit" class="btn-primary">Sign out</button>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>


