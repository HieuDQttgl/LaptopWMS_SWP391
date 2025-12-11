<%@ page import="Model.Users"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html>
    <h1><jsp:include page="header.jsp"/></h1>
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

            .filter-container {
                display: flex;
                flex-direction: column;
                gap: 15px;
                margin-bottom: 25px;
                padding: 15px;
                border: 1px solid #e0e0e0;
                border-radius: 8px;
                background-color: #fcfcfc;
            }

            .filter-controls {
                display: flex;
                gap: 15px;
                flex-wrap: wrap;
                align-items: center;
            }

            .filter-actions {
                display: flex;
                justify-content: flex-end;
                gap: 10px;
                width: 100%;
                padding-top: 10px;
                border-top: 1px dashed #eee;
            }

            .filter-group {
                display: flex;
                flex-wrap: nowrap;
                gap: 10px;
                align-items: center;
            }
            .filter-container label {
                font-weight: 600;
                color: #34495e;
                white-space: nowrap;
            }
            .filter-container input[type="text"],
            .filter-container select {
                padding: 8px 12px;
                border: 1px solid #ccc;
                border-radius: 4px;
                font-size: 14px;
            }
            .btn-filter {
                background-color: #3498db;
                color: white;
                padding: 8px 15px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                transition: background-color 0.3s;
                font-weight: 600;
            }
            .btn-filter:hover {
                background-color: #2980b9;
            }
            .btn-clear {
                background-color: #e74c3c;
                color: white;
                padding: 8px 15px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                transition: background-color 0.3s;
                font-weight: 600;
            }
            .btn-clear:hover {
                background-color: #c0392b;
            }
            th a {
                color: inherit;
                text-decoration: none;
                display: block;
                cursor: pointer;
            }
            th a:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>

        <div class="container">
            <h1>User Management List</h1>

            <%
                String successMessage = request.getParameter("message");
                //String successMessage = (String) request.getSession().getAttribute("message");
                String errorMessage = (String) request.getSession().getAttribute("error");

                Map<String, String> errors = (Map<String, String>) request.getAttribute("errors");
                Users tempUser = (Users) request.getAttribute("tempUser");

                boolean showFormOnLoad = errors != null || tempUser != null;

                String currentKeyword = (String) request.getAttribute("keyword");
                String currentGender = (String) request.getAttribute("gender_filter");
                String currentRole = (String) request.getAttribute("role_filter");
                String currentStatus = (String) request.getAttribute("status_filter");
                String currentSortField = (String) request.getAttribute("sort_field");
                String currentSortOrder = (String) request.getAttribute("sort_order");

                if (currentKeyword == null) {
                    currentKeyword = "";
                }
                if (currentGender == null) {
                    currentGender = "all";
                }
                if (currentRole == null) {
                    currentRole = "0";
                }
                if (currentStatus == null) {
                    currentStatus = "all";
                }
                if (currentSortField == null) {
                    currentSortField = "user_id";
                }
                if (currentSortOrder == null) {
                    currentSortOrder = "ASC";
                }

                if (errorMessage != null) {
                    out.println("<p id='notification' class='message-error notification'>" + errorMessage + "</p>");
                    request.getSession().removeAttribute("error");
                } else if (successMessage != null) {
                    out.println("<p id='notification' class='message-success notification'>" + successMessage + "</p>");
                    //request.getSession().removeAttribute("message");
                }
            %>

            <button id="showAddFormBtn" class="btn-add">Add new User</button>

            <div class="filter-container" id="filterContainer" style="display: <%= showFormOnLoad ? "none" : "flex"%>;">
                <form id="filterForm" action="user-list" method="get" style="width: 100%;">

                    <div class="filter-controls">

                        <div class="filter-group">
                            <input type="text" name="keyword" id="keywordFilter" placeholder="Search by name/email..." value="<%= currentKeyword%>">
                        </div>

                        <div class="filter-group">
                            <label for="genderFilter">Gender:</label>
                            <select name="gender_filter" id="genderFilter">
                                <option value="all" <%= "all".equals(currentGender) ? "selected" : ""%>>All</option>
                                <option value="Male" <%= "Male".equals(currentGender) ? "selected" : ""%>>Male</option>
                                <option value="Female" <%= "Female".equals(currentGender) ? "selected" : ""%>>Female</option>
                                <option value="Other" <%= "Other".equals(currentGender) ? "selected" : ""%>>Other</option>
                            </select>
                        </div>

                        <div class="filter-group">
                            <label for="roleFilter">Role:</label>
                            <select name="role_filter" id="roleFilter">
                                <option value="0" <%= "0".equals(currentRole) ? "selected" : ""%>>All</option>
                                <option value="1" <%= "1".equals(currentRole) ? "selected" : ""%>>Admin</option>
                                <option value="2" <%= "2".equals(currentRole) ? "selected" : ""%>>Warehouse</option>
                                <option value="3" <%= "3".equals(currentRole) ? "selected" : ""%>>Sale</option>
                            </select>
                        </div>

                        <div class="filter-group">
                            <label for="statusFilter">Status:</label>
                            <select name="status_filter" id="statusFilter">
                                <option value="all" <%= "all".equals(currentStatus) ? "selected" : ""%>>All</option>
                                <option value="active" <%= "active".equals(currentStatus) ? "selected" : ""%>>Active</option>
                                <option value="inactive" <%= "inactive".equals(currentStatus) ? "selected" : ""%>>Inactive</option>
                            </select>
                        </div>

                        <div class="filter-group">
                            <label for="sortField">Sort By:</label>
                            <select name="sort_field" id="sortField">
                                <option value="user_id" <%= "user_id".equals(currentSortField) ? "selected" : ""%>>ID</option>
                                <option value="full_name" <%= "full_name".equals(currentSortField) ? "selected" : ""%>>Full Name</option>
                                <option value="gender" <%= "gender".equals(currentSortField) ? "selected" : ""%>>Gender</option>
                                <option value="email" <%= "email".equals(currentSortField) ? "selected" : ""%>>Email</option>
                                <option value="phone_number" <%= "phone_number".equals(currentSortField) ? "selected" : ""%>>Phone Number</option>
                                <option value="role_name" <%= "role_name".equals(currentSortField) ? "selected" : ""%>>Role Name</option>
                                <option value="status" <%= "status".equals(currentSortField) ? "selected" : ""%>>Status</option>
                                <option value="last_login_at" <%= "last_login_at".equals(currentSortField) ? "selected" : ""%>>Last Login</option>
                            </select>
                        </div>

                        <div class="filter-group">
                            <label for="sortOrder">Order:</label>
                            <select name="sort_order" id="sortOrder">
                                <option value="ASC" <%= "ASC".equals(currentSortOrder) ? "selected" : ""%>>Ascending</option>
                                <option value="DESC" <%= "DESC".equals(currentSortOrder) ? "selected" : ""%>>Descending</option>
                            </select>
                        </div>
                    </div>

                    <div class="filter-actions">
                        <button type="submit" class="btn-filter">Apply Filter & Sort</button>
                        <button type="button" class="btn-clear" onclick="clearFilters()">Clear Filter</button>
                    </div>

                </form>
            </div>

            <div id="addFormContainer" class="add-form-container" style="display: <%= showFormOnLoad ? "block" : "none"%>;">
                <h3>Add New User</h3>
                <form action="user-list" method="post">
                    <input type="hidden" name="action" value="add">

                    <%
                        String usernameValue = (tempUser != null && tempUser.getUsername() != null) ? tempUser.getUsername() : "";
                        String passwordValue = (tempUser != null && tempUser.getPassword() != null) ? tempUser.getPassword() : "";
                        String fullNameValue = (tempUser != null && tempUser.getFullName() != null) ? tempUser.getFullName() : "";
                        String emailValue = (tempUser != null && tempUser.getEmail() != null) ? tempUser.getEmail() : "";
                        String phoneNumberValue = (tempUser != null && tempUser.getPhoneNumber() != null) ? tempUser.getPhoneNumber() : "";
                        String genderValue = (tempUser != null && tempUser.getGender() != null) ? tempUser.getGender() : "Male";
                        Integer roleIdValue = (tempUser != null) ? tempUser.getRoleId() : 2;
                    %>

                    <label for="username">Username:</label>
                    <input type="text" id="username" name="username" value="<%= usernameValue%>" >
                    <% if (errors != null && errors.containsKey("username")) {%>
                    <span class="field-error"><%= errors.get("username")%></span>
                    <% }%>
                    <br>

                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password" value="<%= passwordValue%>" >
                    <% if (errors != null && errors.containsKey("password")) {%>
                    <span class="field-error"><%= errors.get("password")%></span>
                    <% }%>
                    <br>

                    <label for="fullName">Full Name:</label>
                    <input type="text" id="fullName" name="fullName" value="<%= fullNameValue%>">
                    <% if (errors != null && errors.containsKey("fullName")) {%>
                    <span class="field-error"><%= errors.get("fullName")%></span>
                    <% }%>
                    <br>

                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" value="<%= emailValue%>" >
                    <% if (errors != null && errors.containsKey("email")) {%>
                    <span class="field-error"><%= errors.get("email")%></span>
                    <% }%>
                    <br>

                    <label for="phoneNumber">Phone Number:</label>
                    <input type="text" id="phoneNumber" name="phoneNumber" value="<%= phoneNumberValue%>">
                    <% if (errors != null && errors.containsKey("phoneNumber")) {%>
                    <span class="field-error"><%= errors.get("phoneNumber")%></span>
                    <% }%>
                    <br>

                    <label for="gender">Gender:</label>
                    <select id="gender" name="gender">
                        <option value="Male" <%= "Male".equals(genderValue) ? "selected" : ""%>>Male</option>
                        <option value="Female" <%= "Female".equals(genderValue) ? "selected" : ""%>>Female</option>
                        <option value="Other" <%= "Other".equals(genderValue) ? "selected" : ""%>>Other</option>
                    </select><br>

                    <label>Role:</label>
                    <select name="roleId">
                        <option value="1" <%= roleIdValue.equals(1) ? "selected" : ""%>>Administrator</option>
                        <option value="2" <%= roleIdValue.equals(2) ? "selected" : ""%>>Warehouse Keeper</option>
                        <option value="3" <%= roleIdValue.equals(3) ? "selected" : ""%>>Sale</option>
                    </select>
                    <% if (errors != null && errors.containsKey("roleId")) {%>
                    <span class="field-error"><%= errors.get("roleId")%></span>
                    <% }%>

                    <div class="form-actions">
                        <input type="submit" value="Add User">
                        <button type="button" class="btn-close" onclick="hideAddForm()">Close Form</button>
                    </div>
                </form>
            </div>

            <table id="userTable" style="display: <%= showFormOnLoad ? "none" : "table"%>;"> 
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Username</th>
                        <th>Full Name</th>
                        <th>Email</th>
                        <th>Phone Number</th>
                        <th>Gender</th> <th>Role</th>
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
                        <td><%= user.getGender()%></td> 
                        <td><%= user.getRoleName() != null ? user.getRoleName() : "N/A"%></td>

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
                            <a href="user-detail?id=<%= user.getUserId()%>">View Detail</a>

                            <%
                                if (user.getRoleId() != 1) {
                            %>
                            |
                            <a href="user-status?id=<%= user.getUserId()%>">
                                <%
                                    String currentUserStatus = user.getStatus();
                                    if ("active".equalsIgnoreCase(currentUserStatus)) {
                                        out.print("Deactivate");
                                    } else {
                                        out.print("Activate");
                                    }
                                %>
                            </a>
                            <% } %>
                            
<%--                        <%
                                if (user.getRoleId() != 1) {
                            %>
                            |
                            <a href="<%= request.getContextPath() %>/user-list?action=changeStatus&id=<%= user.getUserId()%>">
                                <%
                                    String currentUserStatus = user.getStatus();
                                    if ("active".equalsIgnoreCase(currentUserStatus)) {
                                        out.print("Deactivate");
                                    } else {
                                        out.print("Activate");
                                    }
                                %>
                            </a>
                            <% } %> --%>
                        </td>
                    </tr>

                    <%
                        }
                    } else {
                    %>
                    <tr>
                        <td colspan="10" style="text-align: center; color: #7f8c8d;">No users found.</td>
                    </tr>
                    <% }%>
                </tbody>
            </table>

            <p id="totalUsers" style="margin-top: 20px; color: #7f8c8d; display: <%= showFormOnLoad ? "none" : "block"%>;">Total Users: <%= users != null ? users.size() : 0%></p>
            <a id="backLanding" href="<%= request.getContextPath()%>/landing" class="btn-secondary" style="display: <%= showFormOnLoad ? "none" : "block"%>;">Back to Landing Page</a>
        </div>

        <script>
            var button = document.getElementById('showAddFormBtn');
            var formContainer = document.getElementById('addFormContainer');
            var notificationElement = document.getElementById('notification');
            var userTable = document.getElementById('userTable');
            var totalUsersParagraph = document.getElementById('totalUsers');
            var backLandingLink = document.getElementById('backLanding');
            var filterContainer = document.getElementById('filterContainer');

            function hideTableElements() {
                if (userTable)
                    userTable.style.display = 'none';
                if (totalUsersParagraph)
                    totalUsersParagraph.style.display = 'none';
                if (backLandingLink)
                    backLandingLink.style.display = 'none';
                if (filterContainer)
                    filterContainer.style.display = 'none';
            }

            function showTableElements() {
                if (userTable)
                    userTable.style.display = 'table';
                if (totalUsersParagraph)
                    totalUsersParagraph.style.display = 'block';
                if (backLandingLink)
                    backLandingLink.style.display = 'block';
                if (filterContainer)
                    filterContainer.style.display = 'flex';
            }

            function hideAddForm() {
                if (formContainer)
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

            function clearFilters() {
                document.getElementById('keywordFilter').value = '';
                document.getElementById('genderFilter').value = 'all';
                document.getElementById('roleFilter').value = '0';
                document.getElementById('statusFilter').value = 'all';
                document.getElementById('sortField').value = 'user_id';
                document.getElementById('sortOrder').value = 'ASC';

                document.getElementById('filterForm').submit();
            }

            if (notificationElement) {
                setTimeout(function () {
                    notificationElement.remove();
                }, 5000);
            }
        </script>
        <jsp:include page="footer.jsp"/>
    </body>
</html>