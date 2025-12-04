<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Forgot Password</title>
    </head>
    <body>
        <h2>Forgot Password</h2>

        <form method="post" action="<%= request.getContextPath() %>/forgot">
            <label>Email:</label>
            <input type="email" name="email" required>
            <br><br>
            <button type="submit">Reset Password</button>
        </form>

        <% 
            String msg = (String) request.getAttribute("msg");
            if (msg != null) { 
        %>
        <p style="color: green;"><%= msg %></p>
        <% } %>

        <% 
            String error = (String) request.getAttribute("error");
            if (error != null) { 
        %>
        <p style="color: red;"><%= error %></p>
        <% } %>

    </body>
</html>
