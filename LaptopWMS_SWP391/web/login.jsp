<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login</title>
        <style>
            :root {
                --primary-color: #2563eb;
                --primary-hover: #1d4ed8;
                --danger-color: #dc2626;
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

            .auth-wrapper {
                width: 100%;
                max-width: 420px;
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
                margin-bottom: 20px;
                text-align: center;
            }

            .card-header h1 {
                margin: 0 0 6px;
                font-size: 24px;
                font-weight: 600;
            }

            .card-header p {
                margin: 0;
                font-size: 14px;
                color: var(--text-muted);
            }

            .form-group {
                margin-bottom: 14px;
            }

            label {
                display: block;
                margin-bottom: 4px;
                font-size: 13px;
                font-weight: 500;
                color: var(--text-muted);
            }

            .input-field {
                position: relative;
            }

            .input-field input[type="text"],
            .input-field input[type="password"] {
                width: 100%;
                padding: 9px 10px;
                border-radius: 8px;
                border: 1px solid var(--border-color);
                font-size: 14px;
                outline: none;
                transition: border-color 0.15s ease, box-shadow 0.15s ease, background-color 0.15s ease;
                background-color: #f9fafb;
            }

            .input-field input:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 1px rgba(37, 99, 235, 0.14);
                background-color: #ffffff;
            }

            .error-message {
                margin-bottom: 12px;
                padding: 8px 10px;
                border-radius: 8px;
                background-color: #fee2e2;
                border: 1px solid #fecaca;
                color: var(--danger-color);
                font-size: 13px;
            }

            .success-message {
                margin-bottom: 12px;
                padding: 8px 10px;
                border-radius: 8px;
                background-color: #dcfce7;
                border: 1px solid #bbf7d0;
                color: #16a34a;
                font-size: 13px;
            }

            .actions {
                margin-top: 6px;
            }

            .btn-primary {
                width: 100%;
                padding: 9px 12px;
                border-radius: 8px;
                border: none;
                background: linear-gradient(135deg, var(--primary-color), #3b82f6);
                color: #ffffff;
                font-weight: 600;
                font-size: 14px;
                cursor: pointer;
                transition: background 0.15s ease, transform 0.05s ease, box-shadow 0.05s ease;
                box-shadow: 0 8px 18px rgba(37, 99, 235, 0.35);
            }

            .btn-primary:hover {
                background: linear-gradient(135deg, var(--primary-hover), #2563eb);
                transform: translateY(-1px);
                box-shadow: 0 10px 22px rgba(37, 99, 235, 0.4);
            }

            .btn-primary:active {
                transform: translateY(0);
                box-shadow: 0 6px 14px rgba(37, 99, 235, 0.3);
            }

            .meta {
                margin-top: 10px;
                text-align: center;
                font-size: 12px;
                color: var(--text-muted);
            }

            @media (max-width: 480px) {
                .card {
                    padding: 22px 18px 20px;
                }
            }
        </style>
    </head>

    <body>
        <div class="auth-wrapper">
            <div class="card">
                <div class="card-header">
                    <h1>Welcome back</h1>
                    <p>Please sign in to continue</p>
                </div>

                <% String error = (String) request.getAttribute("error");
                    String usernameVal = (String) request.getAttribute("username");
                    String successMsg = (String) session.getAttribute("message");
                    if (successMsg != null) {
                        session.removeAttribute("message");
                    } %>

                <% if (successMsg != null) {%>
                <div class="success-message">
                    <%= successMsg%>
                </div>
                <% } %>

                <% if (error != null) {%>
                <div class="error-message">
                    <%= error%>
                </div>
                <% }%>

                <form method="post" action="<%= request.getContextPath()%>/login">
                    <div class="form-group">
                        <label for="username">Username</label>
                        <div class="input-field">
                            <input type="text" id="username" name="username"
                                   value="<%= usernameVal != null ? usernameVal : ""%>" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="password">Password</label>
                        <div class="input-field">
                            <input type="password" id="password" name="password" required>
                        </div>
                    </div>

                    <div class="actions">
                        <button type="submit" class="btn-primary">Sign in</button>
                    </div>
                    <div class="meta">
                        <a href="<%= request.getContextPath()%>/forgot"
                           style="color: var(--primary-color); text-decoration: none;">
                            Forgot password?
                        </a>
                    </div>


                </form>
            </div>
        </div>
    </body>

</html>