<%@ page import="Model.Users"%>
<%@ page import="Model.Role"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Map" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>

        <meta charset="UTF-8">
        <title>User Management</title>

        <style>
            body {
                font-family: "Segoe UI", Arial, sans-serif;
                background-color: #f5f6fa;
                margin: 0;
                padding: 0;
                color: #2c3e50;
            }
            .container {
                max-width: 1200px;
                margin: 40px auto;
                background-color: white;
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 4px 20px rgba(0,0,0,0.07);
            }
            h1 {
                text-align: center;
                color: #2c3e50;
                font-weight: 700;
                margin-bottom: 25px;
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
        <h1><jsp:include page="header.jsp"/></h1>
        <div class="container">
            <h1>User Management List</h1>

            <%
                String successMessage = (String) request.getSession().getAttribute("message");
                String errorMessage = (String) request.getSession().getAttribute("error");

                Map<String, String> errors = (Map<String, String>) request.getAttribute("errors");
                Users tempUser = (Users) request.getAttribute("tempUser");

                List<Role> allRoles = (List<Role>) request.getAttribute("allRoles");

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
                    request.getSession().removeAttribute("message");
                }
            %>

            <button id="showAddFormBtn" class="btn-add">Add new User</button>

            <div class="filter-container" id="filterContainer" style="margin-bottom: 20px; padding: 15px; background: #fff; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.05);">
                <form action="user-list" method="get" id="filterForm" style="display: flex; gap: 15px; align-items: center; flex-wrap: wrap;">

                    <input type="hidden" name="sort_field" value="${currentSortField}">
                    <input type="hidden" name="sort_order" value="${currentSortOrder}">

                    <div class="filter-group">
                        <input type="text" name="keyword" id="keywordFilter" placeholder="Search name, email or phone..." 
                               value="${currentKeyword}" 
                               style="padding: 6px 12px; border: 1px solid #ccc; border-radius: 4px; width: 220px;">
                    </div>

                    <button type="submit" class="btn-filter" style="padding: 6px 12px; background: #3498db; color: white; border: none; border-radius: 4px; cursor: pointer;">
                        Search
                    </button>

                    <div class="filter-group">
                        <select name="gender_filter" id="genderFilter" onchange="this.form.submit()" style="padding: 6px; border: 1px solid #ccc; border-radius: 4px;">
                            <option value="all" ${gender_filter == 'all' ? 'selected' : ''}>All Genders</option>
                            <option value="Male" ${gender_filter == 'Male' ? 'selected' : ''}>Male</option>
                            <option value="Female" ${gender_filter == 'Female' ? 'selected' : ''}>Female</option>
                            <option value="Other" ${gender_filter == 'Other' ? 'selected' : ''}>Other</option>
                        </select>
                    </div>

                    <div class="filter-group">
                        <select name="role_filter" id="roleFilter" onchange="this.form.submit()" style="padding: 6px; border: 1px solid #ccc; border-radius: 4px;">
                            <option value="0" ${currentRole == '0' ? 'selected' : ''}>All Roles</option>
                            <c:forEach var="r" items="${allRoles}">
                                <c:if test="${r.status eq 'active'}">
                                    <option value="${r.roleId}" ${currentRole == r.roleId ? 'selected' : ''}>
                                        ${r.roleName}
                                    </option>
                                </c:if>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="filter-group">
                        <select name="status_filter" id="statusFilter" onchange="this.form.submit()" style="padding: 6px; border: 1px solid #ccc; border-radius: 4px;">
                            <option value="all" ${status_filter == 'all' ? 'selected' : ''}>All Status</option>
                            <option value="active" ${status_filter == 'active' ? 'selected' : ''}>Active</option>
                            <option value="inactive" ${status_filter == 'inactive' ? 'selected' : ''}>Inactive</option>
                        </select>
                    </div>


                    <a href="user-list" class="btn-clear" style="padding: 6px 12px; background: #e74c3c; color: white; text-decoration: none; border-radius: 4px; font-size: 13px; font-weight: 600;">Clear</a>
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
                        Integer roleIdValue = (tempUser != null) ? tempUser.getRoleId() : 1;
                    %>

                    <label for="username">Username *:</label>
                    <input type="text" id="username" name="username" value="<%= usernameValue%>"> 
                    <span class="field-error" id="usernameError"></span>
                    <% if (errors != null && errors.containsKey("username")) {%>
                    <span class="field-error"><%= errors.get("username")%></span>
                    <% }%>
                    <br>

                    <label for="password">Password *:</label>
                    <input type="password" id="password" name="password" value="<%= passwordValue%>">
                    <span class="field-error" id="passwordError"></span>
                    <% if (errors != null && errors.containsKey("password")) {%>
                    <span class="field-error"><%= errors.get("password")%></span>
                    <% }%>
                    <br>

                    <label for="fullName">Full Name *:</label>
                    <input type="text" id="fullName" name="fullName" value="<%= fullNameValue%>">
                    <span class="field-error" id="fullNameError"></span>
                    <% if (errors != null && errors.containsKey("fullName")) {%>
                    <span class="field-error"><%= errors.get("fullName")%></span>
                    <% }%>
                    <br>

                    <label for="email">Email *:</label>
                    <input type="email" id="email" name="email" value="<%= emailValue%>">
                    <span class="field-error" id="emailError"></span>
                    <% if (errors != null && errors.containsKey("email")) {%>
                    <span class="field-error"><%= errors.get("email")%></span>
                    <% }%>
                    <br>

                    <label for="phoneNumber">Phone Number:</label>
                    <input type="text" id="phoneNumber" name="phoneNumber" value="<%= phoneNumberValue%>">
                    <span class="field-error" id="phoneNumberError"></span>
                    <% if (errors != null && errors.containsKey("phoneNumber")) {%>
                    <span class="field-error"><%= errors.get("phoneNumber")%></span>
                    <% }%>
                    <br>

                    <label for="gender">Gender *:</label>
                    <select id="gender" name="gender">
                        <option value="Male" <%= "Male".equals(genderValue) ? "selected" : ""%>>Male</option>
                        <option value="Female" <%= "Female".equals(genderValue) ? "selected" : ""%>>Female</option>
                        <option value="Other" <%= "Other".equals(genderValue) ? "selected" : ""%>>Other</option>
                    </select>


                    <label>Role *:</label>
                    <select name="roleId" id="roleIdSelect">
                        <option value="0" ${currentRole == '0' ? 'selected' : ''}>Select Role</option> 
                        <c:forEach var="r" items="${allRoles}">
                            <c:if test="${r.status eq 'active'}">
                                <option value="${r.roleId}" ${roleIdValue == r.roleId ? 'selected' : ''}>
                                    ${r.roleName}
                                </option>
                            </c:if>
                        </c:forEach>
                    </select>
                    <span class="field-error" id="roleIdError"></span>
                    <% if (errors != null && errors.containsKey("roleId")) {%>
                    <span class="field-error"><%= errors.get("roleId")%></span>
                    <% }%>

                    <div class="form-actions">
                        <button type="submit" class="btn-add" onclick="return validateAddUserForm()">Add User</button>
                        <button type="button" class="btn-close" onclick="hideAddForm()">Close Form</button>
                    </div>
                </form>
            </div>

            <table id="userTable" style="display: <%= showFormOnLoad ? "none" : "table"%>;"> 
                <thead>
                    <tr>
                        <th>
                            <a href="#" onclick="window.location.href = createSortUrl('user_id')">
                                ID
                                <% if ("user_id".equals(currentSortField)) {%>
                                <%= "ASC".equals(currentSortOrder) ? " ▲" : " ▼"%>
                                <% }%>
                            </a>
                        </th>
                        <th>
                            <a href="#" onclick="window.location.href = createSortUrl('username')">
                                Username
                                <% if ("username".equals(currentSortField)) {%>
                                <%= "ASC".equals(currentSortOrder) ? " ▲" : " ▼"%>
                                <% }%>
                            </a>
                        </th>
                        <th>
                            <a href="#" onclick="window.location.href = createSortUrl('full_name')">
                                Full Name
                                <% if ("full_name".equals(currentSortField)) {%>
                                <%= "ASC".equals(currentSortOrder) ? " ▲" : " ▼"%>
                                <% }%>
                            </a>
                        </th>
                        <th>
                            <a href="#" onclick="window.location.href = createSortUrl('email')">
                                Email
                                <% if ("email".equals(currentSortField)) {%>
                                <%= "ASC".equals(currentSortOrder) ? " ▲" : " ▼"%>
                                <% }%>
                            </a>
                        </th>
                        <th>Phone Number</th>
                        <th>
                            <a href="#" onclick="window.location.href = createSortUrl('gender')">
                                Gender
                                <% if ("gender".equals(currentSortField)) {%>
                                <%= "ASC".equals(currentSortOrder) ? " ▲" : " ▼"%>
                                <% }%>
                            </a>
                        </th>
                        <th>
                            <a href="#" onclick="window.location.href = createSortUrl('role_name')">
                                Role
                                <% if ("role_name".equals(currentSortField)) {%>
                                <%= "ASC".equals(currentSortOrder) ? " ▲" : " ▼"%>
                                <% }%>
                            </a>
                        </th>
                        <th>
                            <a href="#" onclick="window.location.href = createSortUrl('status')">
                                Status
                                <% if ("status".equals(currentSortField)) {%>
                                <%= "ASC".equals(currentSortOrder) ? " ▲" : " ▼"%>
                                <% }%>
                            </a>
                        </th>
                        <th>
                            <a href="#" onclick="window.location.href = createSortUrl('last_login_at')">
                                Last Login At
                                <% if ("last_login_at".equals(currentSortField)) {%>
                                <%= "ASC".equals(currentSortOrder) ? " ▲" : " ▼"%>
                                <% }%>
                            </a>
                        </th>
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
                            <a href="<%= request.getContextPath()%>/user-list?action=changeStatus&id=<%= user.getUserId()%>">
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
            <a id="backLanding" href="<%= request.getContextPath()%>/landing" class="btn-secondary" style="color: #34495e; text-decoration: none; font-weight: 600; display: <%= showFormOnLoad ? "none" : "block"%>;">Back to Landing Page</a>
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

                var url = 'user-list?keyword=&gender_filter=all&role_filter=0&status_filter=all';
                window.location.href = url;
            }

            if (notificationElement) {
                setTimeout(function () {
                    notificationElement.remove();
                }, 5000);
            }

            function createSortUrl(field) {
                var keyword = document.getElementById('keywordFilter').value;
                var gender = document.getElementById('genderFilter').value;
                var role = document.getElementById('roleFilter').value;
                var status = document.getElementById('statusFilter').value;

                var currentSortField = '<%= currentSortField%>';
                var currentSortOrder = '<%= currentSortOrder%>';

                var newSortOrder = 'ASC';

                if (field === currentSortField) {
                    newSortOrder = (currentSortOrder === 'ASC') ? 'DESC' : 'ASC';
                } else {
                    newSortOrder = 'ASC';
                }

                var url = 'user-list?sort_field=' + field + '&sort_order=' + newSortOrder;

                if (keyword && keyword.trim() !== '') {
                    url += '&keyword=' + encodeURIComponent(keyword.trim());
                }
                if (gender && gender !== 'all') {
                    url += '&gender_filter=' + gender;
                }
                if (role && role !== '0') {
                    url += '&role_filter=' + role;
                }
                if (status && status !== 'all') {
                    url += '&status_filter=' + status;
                }

                return url;
            }

            function displayError(id, message) {
                document.getElementById(id + 'Error').innerText = message;
            }

            function clearErrors() {
                const errorSpans = document.querySelectorAll('.field-error');
                errorSpans.forEach(span => {
                    if (span.id.endsWith('Error')) { // Chỉ xóa các span lỗi front-end
                        span.innerText = '';
                    }
                });
            }

            function validateAddUserForm() {
                clearErrors();
                let isValid = true;

                const username = document.getElementById('username').value.trim();
                if (username === "") {
                    displayError('username', 'Username cannot be empty.');
                    isValid = false;
                } else if (username.length < 5) {
                    displayError('username', 'Username must be at least 5 characters long.');
                    isValid = false;
                }

                const password = document.getElementById('password').value;
                if (password === "") {
                    displayError('password', 'Password cannot be empty.');
                    isValid = false;
                } else if (password.length < 6) {
                    displayError('password', 'Password must be at least 6 characters long.');
                    isValid = false;
                }

                const fullName = document.getElementById('fullName').value.trim();
                if (fullName === "") {
                    displayError('fullName', 'Full Name cannot be empty.');
                    isValid = false;
                }

                const email = document.getElementById('email').value.trim();
                const emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
                if (email === "") {
                    displayError('email', 'Email cannot be empty.');
                    isValid = false;
                } else if (!emailPattern.test(email)) {
                    displayError('email', 'Invalid email format.');
                    isValid = false;
                }

                const phoneNumber = document.getElementById('phoneNumber').value.trim();
                if (phoneNumber !== "" && !/^\d{10,11}$/.test(phoneNumber)) {
                    displayError('phoneNumber', 'Phone Number must be 10-11 digits and contain only numbers.');
                    isValid = false;
                }

                const roleId = document.getElementById('roleIdSelect').value;
                if (roleId === '0') {
                    displayError('roleId', 'Please select a valid Role.');
                    isValid = false;
                }

                return isValid;
            }
        </script>
        <jsp:include page="footer.jsp"/>
    </body>
</html>