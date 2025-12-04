<%@ page import="Model.Users" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit User Role</title>
</head>
<body>

    <h2>Edit Role for User</h2>

    <%
        Users user = (Users) request.getAttribute("user");
    %>

    <form action="edit-role" method="post">
        <input type="hidden" name="id" value="<%= user.getUserId() %>">

        <label>Username:</label>
        <input type="text" value="<%= user.getUsername() %>" disabled><br><br>

        <label>Role:</label>
        <select name="roleId">
            <option value="1" <%= user.getRoleId() == 1 ? "selected" : "" %>>Admin</option>
            <option value="2" <%= user.getRoleId() == 2 ? "selected" : "" %>>Manager</option>
            <option value="3" <%= user.getRoleId() == 3 ? "selected" : "" %>>Staff</option>
        </select>
        <br><br>

        <button type="submit">Save</button>
    </form>

</body>
</html>
