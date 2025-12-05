<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Change Password</title>

    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: "Segoe UI", sans-serif;
            background: linear-gradient(135deg, #dbeafe, #eff6ff, #f9fafb);
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .container {
            background: #ffffff;
            padding: 35px 40px;
            border-radius: 14px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            width: 360px;
        }

        h2 {
            margin: 0 0 15px;
            font-size: 24px;
            font-weight: 600;
            color: #1e3a8a;
            text-align: center;
        }

        label {
            font-size: 14px;
            font-weight: 500;
            color: #374151;
        }

        input[type="password"] {
            width: 100%;
            padding: 10px 12px;
            margin-top: 6px;
            margin-bottom: 18px;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            font-size: 14px;
            outline: none;
            transition: .2s ease;
        }

        input[type="password"]:focus {
            border-color: #2563eb;
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.2);
        }

        button {
            width: 100%;
            padding: 10px;
            border-radius: 8px;
            border: none;
            background: #2563eb;
            color: white;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: .2s ease;
        }

        button:hover {
            background: #1d4ed8;
        }

        .msg-success {
            margin-top: 15px;
            background: #e0f7e9;
            padding: 10px;
            border-radius: 6px;
            color: #0f5132;
            font-size: 14px;
            border-left: 4px solid #2ecc71;
        }

        .msg-error {
            margin-top: 15px;
            background: #fde2e1;
            padding: 10px;
            border-radius: 6px;
            color: #842029;
            font-size: 14px;
            border-left: 4px solid #e74c3c;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Change Password</h2>

    <form method="post" action="<%= request.getContextPath() %>/change-password">

        <label>Current Password:</label>
        <input type="password" name="currentPassword" placeholder="Enter current password" required>

        <label>New Password:</label>
        <input type="password" name="newPassword" placeholder="Enter new password" required>

        <label>Confirm New Password:</label>
        <input type="password" name="confirmPassword" placeholder="Re-enter new password" required>

        <button type="submit">Update Password</button>
    </form>
    <a href="landing">Back to Home</a>

    <% if(request.getAttribute("error") != null){ %>
        <div class="msg-error"><%= request.getAttribute("error") %></div>
    <% } %>

    <% if(request.getAttribute("msg") != null){ %>
        <div class="msg-success"><%= request.getAttribute("msg") %></div>
    <% } %>

</div>

</body>
</html>
