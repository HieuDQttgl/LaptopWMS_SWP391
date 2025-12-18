<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
    <jsp:include page="header.jsp" />

    <head>
        <title>Laptop Warehouse Management System</title>

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

            .change-password-wrapper {
                display: flex;
                align-items: center;
                justify-content: center;
                flex: 1;
                padding: 40px 16px;
            }

            .container {
                background: var(--card-bg);
                padding: 35px 40px;
                border-radius: var(--radius-lg);
                box-shadow: var(--shadow-soft);
                width: 100%;
                max-width: 400px;
                border: 1px solid var(--border-color);
            }

            h2 {
                margin: 0 0 20px;
                font-size: 22px;
                font-weight: 600;
                color: #1e3a8a;
                text-align: center;
            }

            label {
                font-size: 14px;
                font-weight: 500;
                color: #374151;
                display: block;
                margin-bottom: 6px;
            }

            input[type="password"] {
                width: 100%;
                padding: 10px 12px;
                margin-bottom: 18px;
                border: 1px solid var(--border-color);
                border-radius: 8px;
                font-size: 14px;
                outline: none;
                transition: .2s ease;
                box-sizing: border-box;
            }

            input[type="password"]:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.2);
            }

            button {
                width: 100%;
                padding: 10px;
                border-radius: 8px;
                border: none;
                background: linear-gradient(135deg, var(--primary-color), #3b82f6);
                color: white;
                font-size: 15px;
                font-weight: 600;
                cursor: pointer;
                transition: .2s ease;
                box-shadow: 0 8px 18px rgba(37, 99, 235, 0.3);
            }

            button:hover {
                background: linear-gradient(135deg, var(--primary-hover), #2563eb);
                transform: translateY(-1px);
            }

            .back-link {
                display: block;
                text-align: center;
                margin-top: 15px;
                color: var(--text-muted);
                text-decoration: none;
                font-size: 14px;
            }

            .back-link:hover {
                color: var(--primary-color);
                text-decoration: underline;
            }

            .msg-success {
                margin-top: 15px;
                background: #d1fae5;
                padding: 12px 16px;
                border-radius: 8px;
                color: #065f46;
                font-size: 14px;
                border: 1px solid #6ee7b7;
            }

            .msg-error {
                margin-top: 15px;
                background: #fee2e2;
                padding: 12px 16px;
                border-radius: 8px;
                color: #991b1b;
                font-size: 14px;
                border: 1px solid #fca5a5;
            }
        </style>
    </head>

    <body>
        <div class="change-password-wrapper">
            <div class="container">
                <h2>Change Password</h2>

                <form method="post" action="<%= request.getContextPath()%>/change-password">

                    <label>Current Password:</label>
                    <input type="password" name="currentPassword" placeholder="Enter current password" required>

                    <label>New Password:</label>
                    <input type="password" name="newPassword" placeholder="Enter new password" required>

                    <label>Confirm New Password:</label>
                    <input type="password" name="confirmPassword" placeholder="Re-enter new password" required>

                    <button type="submit">Update Password</button>
                </form>
                <a href="<%= request.getContextPath()%>/landing" class="back-link">Back to Home</a>

                <% if (request.getAttribute("error") != null) {%>
                <div class="msg-error">
                    <%= request.getAttribute("error")%>
                </div>
                <% } %>

                <% if (request.getAttribute("msg") != null) {%>
                <div class="msg-success">
                    <%= request.getAttribute("msg")%>
                </div>
                <% }%>
            </div>
        </div>
        <jsp:include page="footer.jsp" />
    </body>

</html>