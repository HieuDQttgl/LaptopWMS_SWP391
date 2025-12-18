<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="Model.Users" %>
<%@ page import="Model.Role" %>
<%
    List<Users> userList = (List<Users>) request.getAttribute("userList");
    List<Role> roleList = (List<Role>) request.getAttribute("roleList");
%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="header.jsp"/>
        <meta charset="UTF-8">
        <title>Laptop Warehouse Management System</title>
        
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f5f5f5;
                margin: 0;
                padding: 20px;
            }

            .container {
                max-width: 1200px;
                margin: 0 auto;
                background-color: white;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            }

            h1 {
                color: #333;
                margin-bottom: 10px;
            }

            .subtitle {
                color: #10b981;
                margin-bottom: 20px;
                font-size: 14px;
            }

            .btn-permission {
                background-color: #10b981;
                color: white;
                padding: 12px 24px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                text-decoration: none;
                display: inline-block;
                margin-bottom: 20px;
                font-size: 14px;
            }

            .btn-permission:hover {
                background-color: #059669;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }

            th {
                background-color: #f9f9f9;
                padding: 12px;
                text-align: left;
                border-bottom: 2px solid #e5e5e5;
                color: #666;
                font-size: 12px;
                text-transform: uppercase;
            }

            td {
                padding: 15px 12px;
                border-bottom: 1px solid #f0f0f0;
            }

            select {
                padding: 8px 12px;
                border: 1px solid #ddd;
                border-radius: 5px;
                font-size: 14px;
                cursor: pointer;
                width: 200px;
            }
            .button-group {
                text-align: right;
                margin-bottom: 20px;
            }
            .button-group a.btn {
                background-color: #10b981;
                color: white;
                padding: 10px 18px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                text-decoration: none;
                display: inline-block;
                font-size: 14px;
                font-weight: 600;
                transition: background-color 0.3s;
                margin-left: 10px;
            }
        </style>
    </head>
    <body>
        <div class="container">

            <h1>User Role Management</h1>

            <div class="button-group">
                <a href="add-role" class="btn"> Add New Role</a>
                <a href="role-list" class="btn">Change Role Status</a>
                <a href="role-permission" class="btn">Change Role Permission</a>
            </div>

            <table>
                <thead>
                    <tr>
                        <th>Role Name</th>
                        <th>Role Status</th>
                    </tr>
                </thead>

                <tbody>
                    <%
                        if (userList != null && !userList.isEmpty()) {
                            for (Users user : userList) {
                                Role userRole = null;
                                for (Role role : roleList) {
                                    if (role.getRoleId() == user.getRoleId()) {
                                        userRole = role;
                                        break;
                                    }
                                }
                    %>
                    <tr>
                        <td><%= user.getRoleName() != null ? user.getRoleName() : "No Role"%></td>
                        <td>
                            <% if (userRole != null && "active".equals(userRole.getStatus())) { %>
                            <span class="badge badge-active">Active</span>
                            <% } else { %>
                            <span class="badge badge-inactive">Inactive</span>
                            <% } %>
                        </td>
                    </tr>
                    <%
                        }
                    } else {
                    %>
                    <tr>
                        <td colspan="6">No users found</td>
                    </tr>
                    <% }%>
                </tbody>
            </table>

            <p>Total Users: <%= userList != null ? userList.size() : 0%></p>
            <a href="javascript:history.back()" class="btn-back"> Back</a>
        </div>
            <jsp:include page="footer.jsp"/>
    </body>
</html>