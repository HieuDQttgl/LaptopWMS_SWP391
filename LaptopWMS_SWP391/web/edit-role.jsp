<%@ page import="Model.Users" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit User Role</title>

    <style>
        body {
            font-family: "Segoe UI", sans-serif;
            background: #f5f6fa;
            padding: 0;
            margin: 0;
        }

        .container {
            width: 450px;
            margin: 60px auto;
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #2c3e50;
        }

        label {
            font-weight: 600;
            color: #34495e;
        }

        input[type="text"], select {
            width: 100%;
            padding: 10px 12px;
            margin-top: 5px;
            margin-bottom: 18px;
            border: 1px solid #dcdde1;
            border-radius: 8px;
            font-size: 15px;
            background: #fdfdfd;
            box-sizing: border-box;
        }

        input[disabled] {
            background: #ecf0f1;
            color: #7f8c8d;
        }

        button {
            width: 100%;
            padding: 12px;
            background: #3498db;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            font-weight: bold;
            transition: 0.2s;
        }

        button:hover {
            background: #2980b9;
        }
    </style>

</head>
<body>

    <div class="container">
        <h2>Edit User Role</h2>

        <%
            Users user = (Users) request.getAttribute("user");
        %>

        <form action="edit-role" method="post">

            <input type="hidden" name="id" value="<%= user.getUserId() %>">

            <label>Username:</label>
            <input type="text" value="<%= user.getUsername() %>" disabled>

            <label>Role:</label>
            <select name="roleId">
                <option value="1" <%= user.getRoleId() == 1 ? "selected" : "" %>>Administrator</option>
                <option value="2" <%= user.getRoleId() == 2 ? "selected" : "" %>>Warehouse Keeper</option>
                <option value="3" <%= user.getRoleId() == 3 ? "selected" : "" %>>Sale</option>
            </select>

            <button type="submit">Save</button>
        </form>
    </div>

</body>
</html>
