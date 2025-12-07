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
                 cursor: pointer;
            }
            .btn-close {
                 background-color: #6c757d;
                 color: white;
                 padding: 8px 12px;
                 border: none;
                 border-radius: 4px;
                 cursor: pointer;
                 margin-top: 10px;
            }
            .add-form-container {
                display: none;
                border: 1px solid #ccc;
                padding: 20px;
                margin-bottom: 30px;
                border-radius: 5px;
                background-color: #f9f9f9;
            }
            .add-form-container input[type="text"],
            .add-form-container input[type="password"],
            .add-form-container input[type="email"],
            .add-form-container select {
                padding: 8px;
                margin-bottom: 10px;
                border: 1px solid #ddd;
                border-radius: 4px;
                width: 100%;
                box-sizing: border-box;
            }
            .add-form-container input[type="submit"] {
                background-color: #28a745;
                color: white;
                padding: 10px 15px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }
            .add-form-container input[type="submit"]:hover {
                background-color: #218838;
            }

            .status-active {
                color: green;
                font-weight: bold;
            }
            .status-inactive {
                color: red;
            }
            .notification { 
                padding: 10px;
                border-radius: 4px;
                margin-bottom: 15px;
            }
            .message-success {
                color: #155724;
                background-color: #d4edda;
                border: 1px solid #c3e6cb;
            }
            .message-error {
                color: #721c24;
                background-color: #f8d7da;
                border: 1px solid #f5c6cb;
            }
        </style>
    </head>
    <body>

        <h1>User List</h1>

        <%
            String successMessage = request.getParameter("message");
            String errorMessage = (String) request.getSession().getAttribute("error");
            if (errorMessage != null) {
                out.println("<p id='notification' class='message-error notification'> " + errorMessage + "</p>");
                request.getSession().removeAttribute("error");
            } else if (successMessage != null) {
                out.println("<p id='notification' class='message-success notification' " + successMessage + "</p>");
            }
        %>
        
        <button id="showAddFormBtn" class="btn-add">➕ Add new User</button>

        <div id="addFormContainer" class="add-form-container">
            <h3>➕ Add New User</h3>
            <form action="user-list" method="post">
                <input type="hidden" name="action" value="add"> 

                <label for="username">Username:</label>
                <input type="text" id="username" name="username" required><br>

                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required><br>

                <label for="fullName">Full Name:</label>
                <input type="text" id="fullName" name="fullName"><br>

                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required><br>

                <label for="phoneNumber">Phone Number:</label>
                <input type="text" id="phoneNumber" name="phoneNumber"><br>

                <label for="gender">Gender:</label>
                <select id="gender" name="gender">
                    <option value="Male">Male</option>
                    <option value="Female">Female</option>
                    <option value="Other">Other</option>
                </select><br>

                <label>Role:</label>
                <select name="roleId">
                    <option value="1">Administrator</option>
                    <option value="2">Warehouse Keeper</option>
                    <option value="3">Sale</option>
                </select>

                <input type="submit" value="Add">
            </form>
            <button type="button" class="btn-close" onclick="hideAddForm()">Close Form</button>
        </div>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Username</th>
                    <th>Full Name</th>
                    <th>Email</th>
                    <th>Phone Number</th>
                    <th>Role Name</th>
                    <th>Status</th>
                    <th>Last Login At</th>
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
                    <td><%= user.getUserId()%></td>
                    <td><%= user.getUsername()%></td>
                    <td><%= user.getFullName()%></td>
                    <td><%= user.getEmail()%></td>
                    <td><%= user.getPhoneNumber()%></td>
                    <td><%= user.getRoleName()%></td>

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

                    <td class="action-links">
                        <a href="user-detail?id=<%= user.getUserId()%>">View</a> |
                        <a href="edit-user?id=<%= user.getUserId()%>">Edit</a>
                    </td>

                </tr>

                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="9">No users found or error retrieving data.</td>
                </tr>
                <% }%>
            </tbody>
        </table>
        
        <script>
            var button = document.getElementById('showAddFormBtn');
            var formContainer = document.getElementById('addFormContainer');
            var notificationElement = document.getElementById('notification');

            function hideAddForm() {
                formContainer.style.display = 'none';
            }

            button.addEventListener('click', function () {
                if (formContainer.style.display === 'none' || formContainer.style.display === '') {
                    formContainer.style.display = 'block';
                } else {
                    formContainer.style.display = 'none';
                }
            });
            
            if (notificationElement) {
                if (notificationElement.classList.contains('message-error')) {
                     formContainer.style.display = 'block';
                }
                
                setTimeout(function() {
                    notificationElement.remove(); 
                }, 5000);
            }
        </script>
    </body>
</html>