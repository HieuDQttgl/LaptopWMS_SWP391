<%@page import="Model.Users"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="Model.Users" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>User Management</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 20px;
            }
            h1 {
                color: #333;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 15px;
            }
            th, td {
                border: 1px solid #ddd;
                padding: 10px;
                text-align: left;
            }
            th {
                background-color: #f2f2f2;
                color: #333;
            }
            .action-links a {
                margin-right: 10px;
                text-decoration: none;
                color: #007bff;
            }
            .action-links a:hover {
                text-decoration: underline;
            }
            .btn-add {
                background-color: #28a745;
                color: white;
                padding: 10px 15px;
                border: none;
                border-radius: 5px;
                text-decoration: none;
                display: inline-block;
                margin-bottom: 20px;
            }
            .status-active {
                color: green;
                font-weight: bold;
            }
            .status-inactive {
                color: red;
            }
        </style>
    </head>
    <body>

        <h1>User List</h1>

        <a href="user-form.jsp" class="btn-add">Add new User</a>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Username</th>
                    <th>Full Name</th>
                    <th>Email</th>
                    <th>Phone Number</th>
                    <th>Role ID</th>
                    <th>Status</th>
                    <th>Last Login At</th>
                    <th>Created At</th>
                    <th>Updated At</th>
                    <th>Created By</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    List<Users> users = (List<Users>) request.getAttribute("users");
                    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
                
                    if (users != null) {
                        for (Users user : users) {
                %>

                <tr>
                    <td><%= user.getUserId() %></td>
                    <td><%= user.getUsername() %></td>
                    <td><%= user.getFullName() %></td>
                    <td><%= user.getEmail() %></td>
                    <td><%= user.getPhoneNumber() %></td>
                    <td><%= user.getRoleId() %></td>

                    <td>
                        <% 
                            if ("active".equalsIgnoreCase(user.getStatus())) {
                        %>
                        <span class="status-active">Active</span>
                        <% } else { %>
                        <span class="status-inactive">Inactive</span>
                        <% } %>
                    </td>

                    <td>
                        <% 
                            if (user.getLastLoginAt() != null) {
                                out.print(sdf.format(user.getLastLoginAt()));
                            } else {
                                out.print("Never logged in");
                            }
                        %>
                    </td>

                    <td>
                        <% 
                            if (user.getCreatedAt() != null) {
                                out.print(sdf.format(user.getCreatedAt()));
                            } else {
                                out.print("N/A");
                            }
                        %>
                    </td>

                    <td>
                        <% 
                            if (user.getUpdatedAt() != null) {
                                out.print(sdf.format(user.getUpdatedAt()));
                            } else {
                                out.print("N/A");
                            }
                        %>
                    </td>

                    <td><%= (user.getCreatedBy() != null ? user.getCreatedBy() : "N/A") %></td>

                    <td class="action-links">
                        <a href="user-detail?id=<%= user.getUserId() %>">View</a> |
                        <a href="edit-role?id=<%= user.getUserId() %>">Edit Role</a>
                    </td>

                </tr>

                <% 
                        } 
                    } else {
                %>
                <tr>
                    <td colspan="12">No users found or error retrieving data.</td>
                </tr>
                <% } %>
            </tbody>
        </table>

    </body>
</html>