<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Change Password</title>
    </head>
    <body>
        <h2>Change Password</h2>

        <form method="post" action="<%= request.getContextPath() %>/change-password">
            <label>Current Password:</label><br>
            <input type="password" name="currentPassword" required><br><br>

            <label>New Password:</label><br>
            <input type="password" name="newPassword" required><br><br>

            <label>Confirm New Password:</label><br>
            <input type="password" name="confirmPassword" required><br><br>

            <button type="submit">Update Password</button>
        </form>

        <% if(request.getAttribute("error") != null){ %>
        <p style="color:red;"><%= request.getAttribute("error") %></p>
        <% } %>

        <% if(request.getAttribute("msg") != null){ %>
        <p style="color:green;"><%= request.getAttribute("msg") %></p>
        <% } %>

    </body>
</html>
