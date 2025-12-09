<%@page import="Model.Users"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
             pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>User Management</title>
        
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
            
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }
            th {
                background-color: #f9f9f9;
                padding: 15px 12px;
                text-align: left;
                border-bottom: 3px solid #e5e5e5;
                color: #666;
                font-size: 13px;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }
            td {
                padding: 15px 12px;
                border-bottom: 1px solid #f0f0f0;
                font-size: 14px;
            }
            tr:hover {
                background-color: #f7f9fb;
            }

            .status-badge {
                display: inline-block;
                padding: 5px 10px;
                border-radius: 20px;
                font-weight: 600;
                font-size: 12px;
                text-transform: capitalize;
            }
            .status-active {
                background-color: #e6f7ed;
                color: #27ae60;
                border: 1px solid #27ae60;
            }
            .status-inactive {
                background-color: #fbebeb;
                color: #e74c3c;
                border: 1px solid #e74c3c;
            }

            .action-links a {
                margin-right: 15px;
                text-decoration: none;
                color: #2980b9;
                font-weight: 600;
                transition: color 0.3s;
            }
            .action-links a:hover {
                color: #3498db;
                text-decoration: underline;
            }

            .btn-add {
                background-color: #2ecc71;
                color: white;
                padding: 10px 18px;
                border: none;
                border-radius: 6px;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                margin-bottom: 25px;
                cursor: pointer;
                font-size: 15px;
                font-weight: 600;
                transition: background-color 0.3s;
            }
            .btn-add:hover {
                background-color: #27ae60;
            }
            
            .form-actions {
                display: flex;
                justify-content: space-between;
                align-items: center;
                gap: 10px;
                margin-top: 20px;
            }

            .btn-close {
                background-color: #95a5a6;
                color: white;
                padding: 10px 15px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s;
                font-weight: 600;
            }
            .btn-close:hover {
                background-color: #7f8c8d;
            }
            
            .add-form-container {
                display: none;
                border: 1px solid #bdc3c7;
                padding: 25px;
                margin-bottom: 30px;
                border-radius: 8px;
                background-color: #ffffff;
                box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            }
            .add-form-container h3 {
                margin-top: 0;
                color: #2ecc71;
                border-bottom: 1px dashed #ecf0f1;
                padding-bottom: 10px;
            }
            .add-form-container label {
                display: block;
                margin-top: 10px;
                margin-bottom: 5px;
                font-weight: 600;
                color: #34495e;
            }
            .add-form-container input[type="text"],
            .add-form-container input[type="password"],
            .add-form-container input[type="email"],
            .add-form-container select {
                padding: 10px;
                margin-bottom: 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
                width: 100%;
                box-sizing: border-box;
            }
            .add-form-container input[type="submit"] {
                background-color: #3498db;
                color: white;
                padding: 10px 15px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-weight: 600;
                transition: background-color 0.3s;
                width: 50%;
                box-sizing: border-box;
            }
            .add-form-container input[type="submit"]:hover {
                background-color: #2980b9;
            }

            .notification { 
                padding: 12px;
                border-radius: 6px;
                margin-bottom: 20px;
                font-weight: 600;
                border-left: 5px solid;
            }
            .message-success {
                color: #1a7d3f;
                background-color: #d4edda;
                border-left-color: #2ecc71;
            }
            .message-error {
                color: #8c2a35;
                background-color: #f8d7da;
                border-left-color: #e74c3c;
            }
            .field-error {
                color: #e74c3c;
                font-size: 11px;
                margin-top: 2px;
                margin-bottom: 5px;
                display: block;
                font-weight: 500;
            }
            .btn-secondary {
                /* Sửa style cho Back to Landing Page */
                /* Đảm bảo style này tồn tại hoặc thêm vào */
                background-color: #f1f2f6; 
                color: #34495e; 
                padding: 8px 15px; 
                border-radius: 6px; 
                text-decoration: none; 
                font-weight: 600;
                border: 1px solid #ccc;
            }
        </style>
    </head>
    <body>

        <div class="container">
            <h1>User Management List</h1>

            <%
                // Lấy thông báo lỗi/thành công từ request/session
                String successMessage = request.getParameter("message");
                String errorMessage = (String) request.getSession().getAttribute("error");
                
                // Lấy các biến mới cho việc giữ lại dữ liệu và hiển thị lỗi chi tiết
                Map<String, String> errors = (Map<String, String>) request.getAttribute("errors");
                Users tempUser = (Users) request.getAttribute("tempUser");
                
                // Kiểm tra xem form có cần được mở tự động không
                boolean showFormOnLoad = errors != null || tempUser != null;
                
                if (errorMessage != null) {
                    out.println("<p id='notification' class='message-error notification'>" + errorMessage + "</p>");
                    request.getSession().removeAttribute("error");
                } else if (successMessage != null) {
                    out.println("<p id='notification' class='message-success notification'>" + successMessage + "</p>");
                }
            %>

            <button id="showAddFormBtn" class="btn-add">Add new User</button>

            <div id="addFormContainer" class="add-form-container" style="display: <%= showFormOnLoad ? "block" : "none" %>;">
                <h3>Add New User</h3>
                <form action="user-list" method="post">
                    <input type="hidden" name="action" value="add">

                    <% 
                        String usernameValue = tempUser != null ? (tempUser.getUsername() != null ? tempUser.getUsername() : "") : "";
                        String passwordValue = tempUser != null ? (tempUser.getPassword() != null ? tempUser.getPassword() : "") : "";
                        String fullNameValue = tempUser != null ? (tempUser.getFullName() != null ? tempUser.getFullName() : "") : "";
                        String emailValue = tempUser != null ? (tempUser.getEmail() != null ? tempUser.getEmail() : "") : "";
                        String phoneNumberValue = tempUser != null ? (tempUser.getPhoneNumber() != null ? tempUser.getPhoneNumber() : "") : "";
                        String genderValue = tempUser != null ? (tempUser.getGender() != null ? tempUser.getGender() : "Male") : "Male";
                        Integer roleIdValue = tempUser != null ? tempUser.getRoleId() : 3; // Giả sử Role mặc định là 3 (Sale)
                    %>

                    <label for="username">Username:</label>
                    <input type="text" id="username" name="username" value="<%= usernameValue %>" required>
                    <% if (errors != null && errors.containsKey("username")) { %>
                        <span class="field-error"><%= errors.get("username") %></span>
                    <% } %>
                    <br>

                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password" value="<%= passwordValue %>" required>
                    <% if (errors != null && errors.containsKey("password")) { %>
                        <span class="field-error"><%= errors.get("password") %></span>
                    <% } %>
                    <br>

                    <label for="fullName">Full Name:</label>
                    <input type="text" id="fullName" name="fullName" value="<%= fullNameValue %>"><br>

                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" value="<%= emailValue %>" required>
                    <% if (errors != null && errors.containsKey("email")) { %>
                        <span class="field-error"><%= errors.get("email") %></span>
                    <% } %>
                    <br>

                    <label for="phoneNumber">Phone Number:</label>
                    <input type="text" id="phoneNumber" name="phoneNumber" value="<%= phoneNumberValue %>">
                    <% if (errors != null && errors.containsKey("phoneNumber")) { %>
                        <span class="field-error"><%= errors.get("phoneNumber") %></span>
                    <% } %>
                    <br>

                    <label for="gender">Gender:</label>
                    <select id="gender" name="gender">
                        <option value="Male" <%= "Male".equals(genderValue) ? "selected" : "" %>>Male</option>
                        <option value="Female" <%= "Female".equals(genderValue) ? "selected" : "" %>>Female</option>
                        <option value="Other" <%= "Other".equals(genderValue) ? "selected" : "" %>>Other</option>
                    </select><br>

                    <label>Role:</label>
                    <select name="roleId">
                        <option value="1" <%= roleIdValue.equals(1) ? "selected" : "" %>>Administrator</option>
                        <option value="2" <%= roleIdValue.equals(2) ? "selected" : "" %>>Warehouse Keeper</option>
                        <option value="3" <%= roleIdValue.equals(3) ? "selected" : "" %>>Sale</option>
                    </select>
                     <% if (errors != null && errors.containsKey("roleId")) { %>
                        <span class="field-error"><%= errors.get("roleId") %></span>
                    <% } %>

                    <div class="form-actions">
                        <input type="submit" value="Add User">
                        <button type="button" class="btn-close" onclick="hideAddForm()">Close Form</button>
                    </div>
                </form>
            </div>

            <table id="userTable" style="display: <%= showFormOnLoad ? "none" : "table" %>;"> 
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

                        if (users != null && !users.isEmpty()) {
                            for (Users user : users) {
                    %>

                    <tr>
                        <td><%= user.getUserId()%></td>
                        <td><%= user.getUsername()%></td>
                        <td><%= user.getFullName()%></td>
                        <td><%= user.getEmail()%></td>
                        <td><%= user.getPhoneNumber()%></td>
                        <td><%= user.getRoleName() != null ? user.getRoleName() : "N/A" %></td>

                        <td>
                            <%
                                if ("active".equalsIgnoreCase(user.getStatus())) {
                            %>
                            <span class="status-badge status-active">Active</span>
                            <% } else { %>
                            <span class="status-badge status-inactive">Inactive</span>
                            <% } %>
                        </td>

                        <td>
                            <%
                                if (user.getLastLoginAt() != null) {
                                    out.print(sdf.format(user.getLastLoginAt()));
                                } else {
                                    out.print("—");
                                }
                            %>
                        </td>

                        <td class="action-links">
                            <a href="user-detail?id=<%= user.getUserId()%>">View Detail</a> |
                            <a href="user-status?id=<%= user.getUserId()%>">
                                <% 
                                    String currentStatus = user.getStatus();
                                    if ("active".equalsIgnoreCase(currentStatus)) {
                                        out.print("Deactivate");
                                    } else {
                                        out.print("Activate");
                                    }
                                %>
                            </a>
                        </td>
                    </tr>

                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="9" style="text-align: center; color: #7f8c8d;">No users found. Please add a new user.</td>
                    </tr>
                    <% }%>
                </tbody>
            </table>
            
            <p id="totalUsers" style="margin-top: 20px; color: #7f8c8d; display: <%= showFormOnLoad ? "none" : "block" %>;">Total Users: <%= users != null ? users.size() : 0 %></p>
            <a id="backLanding" href="<%= request.getContextPath() %>/landing" class="btn-secondary" style="display: <%= showFormOnLoad ? "none" : "block" %>;">Back to Landing Page</a>
        </div>
        
        <script>
            // Logic Javascript cần được cập nhật để phù hợp với việc ẩn/hiện bảng
            var button = document.getElementById('showAddFormBtn');
            var formContainer = document.getElementById('addFormContainer');
            var notificationElement = document.getElementById('notification');
            var userTable = document.getElementById('userTable');
            var totalUsersParagraph = document.getElementById('totalUsers');
            var backLandingLink = document.getElementById('backLanding');

            function hideTableElements() {
                userTable.style.display = 'none';
                if (totalUsersParagraph) {
                    totalUsersParagraph.style.display = 'none';
                }
                backLandingLink.style.display = 'none';
            }
            
            function showTableElements() {
                userTable.style.display = 'table';
                if (totalUsersParagraph) {
                    totalUsersParagraph.style.display = 'block';
                }
                backLandingLink.style.display = 'block';
            }

            function hideAddForm() {
                formContainer.style.display = 'none';
                showTableElements();
            }

            button.addEventListener('click', function () {
                var isHidden = formContainer.style.display === 'none' || formContainer.style.display === '';
                
                if (isHidden) {
                    formContainer.style.display = 'block';
                    hideTableElements();
                } else {
                    hideAddForm();
                }
            });
            
            if (notificationElement) {
                setTimeout(function() {
                    notificationElement.remove(); 
                }, 5000);
            }
        </script>
    </body>
</html>