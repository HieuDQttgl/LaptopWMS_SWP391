<%@ page import="Model.Users" %>
    <%@ page import="Model.Role" %>
        <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
            <%@ page import="java.util.List" %>
                <%@ page import="java.util.Map" %>
                    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
                        <!DOCTYPE html>
                        <html>

                        <head>
                            <meta charset="UTF-8">
                            <title>Users | Laptop WMS</title>
                            <link
                                href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap"
                                rel="stylesheet">
                            <style>
                                body {
                                    font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
                                    background: linear-gradient(135deg, #f0f4ff 0%, #f8fafc 50%, #f0fdf4 100%);
                                    margin: 0;
                                    padding: 0;
                                    min-height: 100vh;
                                }

                                .page-container {
                                    max-width: 1300px;
                                    margin: 2rem auto;
                                    padding: 2rem;
                                }

                                .page-header {
                                    display: flex;
                                    justify-content: space-between;
                                    align-items: center;
                                    margin-bottom: 1.5rem;
                                }

                                .page-title {
                                    display: flex;
                                    align-items: center;
                                    gap: 0.75rem;
                                    font-size: 1.75rem;
                                    font-weight: 700;
                                    color: #1e293b;
                                }

                                .notification {
                                    display: flex;
                                    align-items: center;
                                    gap: 0.5rem;
                                    padding: 1rem 1.25rem;
                                    border-radius: 0.75rem;
                                    margin-bottom: 1.5rem;
                                    font-weight: 500;
                                    animation: slideDown 0.3s ease-out;
                                }

                                @keyframes slideDown {
                                    from {
                                        opacity: 0;
                                        transform: translateY(-10px);
                                    }

                                    to {
                                        opacity: 1;
                                        transform: translateY(0);
                                    }
                                }

                                .message-success {
                                    background: linear-gradient(135deg, #dcfce7 0%, #bbf7d0 100%);
                                    color: #16a34a;
                                    border: 1px solid #86efac;
                                }

                                .message-error {
                                    background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
                                    color: #dc2626;
                                    border: 1px solid #fca5a5;
                                }

                                .btn-add {
                                    display: inline-flex;
                                    align-items: center;
                                    gap: 0.5rem;
                                    padding: 0.75rem 1.5rem;
                                    background: linear-gradient(135deg, #10b981 0%, #059669 100%);
                                    color: white;
                                    text-decoration: none;
                                    border: none;
                                    border-radius: 0.75rem;
                                    font-weight: 600;
                                    font-size: 0.875rem;
                                    cursor: pointer;
                                    transition: all 0.2s ease;
                                    box-shadow: 0 4px 14px rgba(16, 185, 129, 0.4);
                                }

                                .btn-add:hover {
                                    transform: translateY(-2px);
                                    box-shadow: 0 6px 20px rgba(16, 185, 129, 0.5);
                                    color: white;
                                }

                                .filter-bar {
                                    display: flex;
                                    flex-wrap: wrap;
                                    gap: 1rem;
                                    align-items: flex-end;
                                    padding: 1.25rem 1.5rem;
                                    background: white;
                                    border-radius: 1rem;
                                    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
                                    margin-bottom: 1.5rem;
                                    border: 1px solid #f1f5f9;
                                }

                                .filter-group {
                                    display: flex;
                                    flex-direction: column;
                                    gap: 0.375rem;
                                }

                                .filter-group label {
                                    font-size: 0.6875rem;
                                    font-weight: 600;
                                    color: #64748b;
                                    text-transform: uppercase;
                                    letter-spacing: 0.5px;
                                }

                                .filter-group input,
                                .filter-group select {
                                    padding: 0.625rem 1rem;
                                    font-size: 0.875rem;
                                    border: 2px solid #e2e8f0;
                                    border-radius: 0.5rem;
                                    background: white;
                                    outline: none;
                                    transition: all 0.2s ease;
                                    min-width: 150px;
                                }

                                .filter-group input:focus,
                                .filter-group select:focus {
                                    border-color: #667eea;
                                    box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.15);
                                }

                                .btn-search {
                                    padding: 0.625rem 1.25rem;
                                    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                                    color: white;
                                    border: none;
                                    border-radius: 0.5rem;
                                    font-weight: 600;
                                    cursor: pointer;
                                    transition: all 0.2s ease;
                                }

                                .btn-search:hover {
                                    transform: translateY(-1px);
                                    box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
                                }

                                .btn-clear {
                                    padding: 0.625rem 1.25rem;
                                    background: #ef4444;
                                    color: white;
                                    text-decoration: none;
                                    border-radius: 0.5rem;
                                    font-weight: 600;
                                    font-size: 0.875rem;
                                }

                                .btn-clear:hover {
                                    background: #dc2626;
                                    color: white;
                                }

                                .add-form-container {
                                    display: none;
                                    padding: 2rem;
                                    margin-bottom: 1.5rem;
                                    border-radius: 1rem;
                                    background: white;
                                    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
                                    border: 1px solid #f1f5f9;
                                    animation: fadeIn 0.3s ease-out;
                                }

                                @keyframes fadeIn {
                                    from {
                                        opacity: 0;
                                        transform: translateY(-10px);
                                    }

                                    to {
                                        opacity: 1;
                                        transform: translateY(0);
                                    }
                                }

                                .add-form-container h3 {
                                    margin: 0 0 1.5rem 0;
                                    color: #1e293b;
                                    font-size: 1.25rem;
                                    font-weight: 700;
                                }

                                .add-form-container label {
                                    display: block;
                                    margin-top: 1rem;
                                    margin-bottom: 0.375rem;
                                    font-weight: 600;
                                    color: #475569;
                                    font-size: 0.875rem;
                                }

                                .add-form-container input[type="text"],
                                .add-form-container input[type="password"],
                                .add-form-container input[type="email"],
                                .add-form-container select {
                                    padding: 0.75rem 1rem;
                                    margin-bottom: 0.25rem;
                                    border: 2px solid #e2e8f0;
                                    border-radius: 0.5rem;
                                    width: 100%;
                                    box-sizing: border-box;
                                    font-size: 0.9375rem;
                                    transition: all 0.2s ease;
                                    outline: none;
                                }

                                .add-form-container input:focus,
                                .add-form-container select:focus {
                                    border-color: #667eea;
                                    box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.15);
                                }

                                .field-error {
                                    color: #dc2626;
                                    font-size: 0.75rem;
                                    margin-top: 0.25rem;
                                    display: block;
                                }

                                .form-actions {
                                    display: flex;
                                    gap: 1rem;
                                    margin-top: 1.5rem;
                                }

                                .btn-submit {
                                    padding: 0.75rem 1.5rem;
                                    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                                    color: white;
                                    border: none;
                                    border-radius: 0.5rem;
                                    font-weight: 600;
                                    cursor: pointer;
                                    transition: all 0.2s ease;
                                }

                                .btn-submit:hover {
                                    transform: translateY(-1px);
                                    box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
                                }

                                .btn-close {
                                    padding: 0.75rem 1.5rem;
                                    background: #94a3b8;
                                    color: white;
                                    border: none;
                                    border-radius: 0.5rem;
                                    font-weight: 600;
                                    cursor: pointer;
                                    transition: all 0.2s ease;
                                }

                                .btn-close:hover {
                                    background: #64748b;
                                }

                                .table-card {
                                    background: white;
                                    border-radius: 1rem;
                                    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
                                    overflow: hidden;
                                    border: 1px solid #f1f5f9;
                                }

                                table {
                                    width: 100%;
                                    border-collapse: collapse;
                                }

                                th {
                                    padding: 1rem 1.25rem;
                                    text-align: left;
                                    font-size: 0.6875rem;
                                    font-weight: 600;
                                    text-transform: uppercase;
                                    letter-spacing: 0.5px;
                                    color: #64748b;
                                    background: linear-gradient(135deg, #f8fafc 0%, white 100%);
                                    border-bottom: 2px solid #e2e8f0;
                                }

                                th a {
                                    color: inherit;
                                    text-decoration: none;
                                }

                                th a:hover {
                                    color: #667eea;
                                }

                                td {
                                    padding: 1rem 1.25rem;
                                    font-size: 0.875rem;
                                    color: #475569;
                                    border-bottom: 1px solid #f1f5f9;
                                }

                                tbody tr {
                                    transition: all 0.2s ease;
                                }

                                tbody tr:hover {
                                    background: linear-gradient(135deg, #f8fafc 0%, #f0fdf4 100%);
                                }

                                .user-info {
                                    font-weight: 600;
                                    color: #1e293b;
                                }

                                .user-email {
                                    color: #64748b;
                                    font-size: 0.8125rem;
                                }

                                .role-badge {
                                    display: inline-flex;
                                    align-items: center;
                                    gap: 0.25rem;
                                    padding: 0.25rem 0.75rem;
                                    background: linear-gradient(135deg, #eff6ff 0%, #dbeafe 100%);
                                    color: #2563eb;
                                    border-radius: 1rem;
                                    font-size: 0.75rem;
                                    font-weight: 600;
                                }

                                .status-badge {
                                    display: inline-flex;
                                    align-items: center;
                                    gap: 0.25rem;
                                    padding: 0.375rem 0.875rem;
                                    border-radius: 2rem;
                                    font-size: 0.6875rem;
                                    font-weight: 600;
                                    text-transform: uppercase;
                                }

                                .status-active {
                                    background: linear-gradient(135deg, #dcfce7 0%, #bbf7d0 100%);
                                    color: #16a34a;
                                }

                                .status-inactive {
                                    background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
                                    color: #dc2626;
                                }

                                .action-links {
                                    display: flex;
                                    gap: 0.75rem;
                                }

                                .action-links a {
                                    color: #3b82f6;
                                    text-decoration: none;
                                    font-weight: 500;
                                    font-size: 0.8125rem;
                                    transition: color 0.2s ease;
                                }

                                .action-links a:hover {
                                    color: #1d4ed8;
                                }

                                .action-links a.danger {
                                    color: #ef4444;
                                }

                                .action-links a.danger:hover {
                                    color: #dc2626;
                                }

                                .action-links a.success {
                                    color: #10b981;
                                }

                                .action-links a.success:hover {
                                    color: #059669;
                                }

                                .empty-state {
                                    text-align: center;
                                    padding: 4rem 2rem;
                                    color: #94a3b8;
                                }

                                .pagination {
                                    display: flex;
                                    justify-content: center;
                                    align-items: center;
                                    gap: 0.5rem;
                                    margin-top: 2rem;
                                    flex-wrap: wrap;
                                }

                                .pagination a,
                                .pagination span {
                                    display: flex;
                                    align-items: center;
                                    justify-content: center;
                                    min-width: 40px;
                                    height: 40px;
                                    padding: 0 0.75rem;
                                    font-size: 0.875rem;
                                    font-weight: 600;
                                    color: #475569;
                                    background: white;
                                    border: 1px solid #e2e8f0;
                                    border-radius: 0.5rem;
                                    text-decoration: none;
                                    transition: all 0.2s ease;
                                }

                                .pagination a:hover {
                                    background: #f1f5f9;
                                    border-color: #cbd5e1;
                                }

                                .pagination .current-page {
                                    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                                    color: white;
                                    border-color: transparent;
                                    box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
                                }

                                .pagination .disabled {
                                    color: #cbd5e1;
                                    cursor: not-allowed;
                                    pointer-events: none;
                                }

                                .pagination-info {
                                    color: #64748b;
                                    font-size: 0.875rem;
                                }

                                .back-link {
                                    display: inline-flex;
                                    align-items: center;
                                    gap: 0.5rem;
                                    margin-top: 1.5rem;
                                    font-size: 0.875rem;
                                    color: #94a3b8;
                                    text-decoration: none;
                                }

                                .back-link:hover {
                                    color: #64748b;
                                }

                                @media (max-width: 1024px) {
                                    .table-card {
                                        overflow-x: auto;
                                    }

                                    table {
                                        min-width: 900px;
                                    }
                                }

                                @media (max-width: 768px) {
                                    .page-container {
                                        padding: 1rem;
                                        margin: 1rem;
                                    }

                                    .page-header {
                                        flex-direction: column;
                                        gap: 1rem;
                                        align-items: flex-start;
                                    }

                                    .filter-bar {
                                        flex-direction: column;
                                    }

                                    .filter-group {
                                        width: 100%;
                                    }

                                    .filter-group input,
                                    .filter-group select {
                                        width: 100%;
                                    }
                                }
                            </style>
                        </head>

                        <body>
                            <jsp:include page="header.jsp" />

                            <div class="page-container">
                                <div class="page-header">
                                    <h1 class="page-title">👤 User Management</h1>
                                </div>

                                <% String successMessage=(String) request.getSession().getAttribute("message"); String
                                    errorMessage=(String) request.getSession().getAttribute("error"); Map<String,
                                    String> errors = (Map<String, String>) request.getAttribute("errors");
                                        Users tempUser = (Users) request.getAttribute("tempUser");
                                        List<Role> allRoles = (List<Role>) request.getAttribute("allRoles");
                                                boolean showFormOnLoad = errors != null || tempUser != null;

                                                String currentKeyword = (String) request.getAttribute("keyword");
                                                String currentRole = (String) request.getAttribute("role_filter");
                                                String currentStatus = (String) request.getAttribute("status_filter");
                                                String currentSortField = (String) request.getAttribute("sort_field");
                                                String currentSortOrder = (String) request.getAttribute("sort_order");

                                                if (currentKeyword == null) currentKeyword = "";
                                                if (currentRole == null) currentRole = "0";
                                                if (currentStatus == null) currentStatus = "all";
                                                if (currentSortField == null) currentSortField = "user_id";
                                                if (currentSortOrder == null) currentSortOrder = "ASC";

                                                if (errorMessage != null) {
                                                out.println("<div class='notification message-error'>⚠ " + errorMessage
                                                    + "</div>");
                                                request.getSession().removeAttribute("error");
                                                } else if (successMessage != null) {
                                                out.println("<div class='notification message-success'>✓ " +
                                                    successMessage + "</div>");
                                                request.getSession().removeAttribute("message");
                                                }
                                                %>

                                                <button id="showAddFormBtn" class="btn-add" onclick="showAddForm()">+
                                                    Add New User</button>

                                                <div class="filter-bar" id="filterContainer"
                                                    style="display: <%= showFormOnLoad ? " none" : "flex" %>;">
                                                    <form action="user-list" method="get" id="filterForm"
                                                        style="display: contents;">
                                                        <input type="hidden" name="sort_field"
                                                            value="${currentSortField}">
                                                        <input type="hidden" name="sort_order"
                                                            value="${currentSortOrder}">

                                                        <div class="filter-group">
                                                            <label>Search</label>
                                                            <input type="text" name="keyword"
                                                                placeholder="Name, email or username..."
                                                                value="${keyword}" style="min-width: 220px;">
                                                        </div>

                                                        <div class="filter-group">
                                                            <label>Role</label>
                                                            <select name="role_filter" onchange="this.form.submit()">
                                                                <option value="0" ${empty role_filter ||
                                                                    role_filter=='0' ? 'selected' : '' }>All Roles
                                                                </option>
                                                                <c:forEach var="r" items="${allRoles}">
                                                                    <c:if
                                                                        test="${r.status eq 'active' and r.roleName ne 'Administrator'}">
                                                                        <option value="${r.roleId}"
                                                                            ${role_filter==r.roleId.toString()
                                                                            ? 'selected' : '' }>${r.roleName}</option>
                                                                    </c:if>
                                                                </c:forEach>
                                                            </select>
                                                        </div>

                                                        <div class="filter-group">
                                                            <label>Status</label>
                                                            <select name="status_filter" onchange="this.form.submit()">
                                                                <option value="all" ${status_filter=='all' ? 'selected'
                                                                    : '' }>All Status</option>
                                                                <option value="active" ${status_filter=='active'
                                                                    ? 'selected' : '' }>Active</option>
                                                                <option value="inactive" ${status_filter=='inactive'
                                                                    ? 'selected' : '' }>Inactive</option>
                                                            </select>
                                                        </div>

                                                        <button type="submit" class="btn-search">🔍 Search</button>
                                                        <a href="user-list" class="btn-clear">✕ Clear</a>
                                                    </form>
                                                </div>

                                                <div id="addFormContainer" class="add-form-container"
                                                    style="display: <%= showFormOnLoad ? " block" : "none" %>;">
                                                    <h3>✚ Add New User</h3>
                                                    <form action="user-list" method="post">
                                                        <input type="hidden" name="action" value="add">

                                                        <% String usernameValue=(tempUser !=null &&
                                                            tempUser.getUsername() !=null) ? tempUser.getUsername() : ""
                                                            ; String passwordValue=(tempUser !=null &&
                                                            tempUser.getPassword() !=null) ? tempUser.getPassword() : ""
                                                            ; String fullNameValue=(tempUser !=null &&
                                                            tempUser.getFullName() !=null) ? tempUser.getFullName() : ""
                                                            ; String emailValue=(tempUser !=null && tempUser.getEmail()
                                                            !=null) ? tempUser.getEmail() : "" ; Integer
                                                            roleIdValue=(tempUser !=null) ? tempUser.getRoleId() : 0; %>

                                                            <label for="username">Username *</label>
                                                            <input type="text" id="username" name="username"
                                                                value="<%= usernameValue %>"
                                                                placeholder="Enter username">
                                                            <% if (errors !=null && errors.containsKey("username")) { %>
                                                                <span class="field-error">
                                                                    <%= errors.get("username") %>
                                                                </span>
                                                                <% } %>

                                                                    <label for="password">Password *</label>
                                                                    <input type="password" id="password" name="password"
                                                                        value="<%= passwordValue %>"
                                                                        placeholder="Enter password">
                                                                    <% if (errors !=null &&
                                                                        errors.containsKey("password")) { %><span
                                                                            class="field-error">
                                                                            <%= errors.get("password") %>
                                                                        </span>
                                                                        <% } %>

                                                                            <label for="fullName">Full Name *</label>
                                                                            <input type="text" id="fullName"
                                                                                name="fullName"
                                                                                value="<%= fullNameValue %>"
                                                                                placeholder="Enter full name">
                                                                            <% if (errors !=null &&
                                                                                errors.containsKey("fullName")) { %>
                                                                                <span class="field-error">
                                                                                    <%= errors.get("fullName") %>
                                                                                </span>
                                                                                <% } %>

                                                                                    <label for="email">Email *</label>
                                                                                    <input type="email" id="email"
                                                                                        name="email"
                                                                                        value="<%= emailValue %>"
                                                                                        placeholder="Enter email">
                                                                                    <% if (errors !=null &&
                                                                                        errors.containsKey("email")) {
                                                                                        %><span class="field-error">
                                                                                            <%= errors.get("email") %>
                                                                                        </span>
                                                                                        <% } %>

                                                                                            <label>Role *</label>
                                                                                            <select name="roleId"
                                                                                                id="roleIdSelect">
                                                                                                <option value="0"
                                                                                                    <%=(roleIdValue==null
                                                                                                    || roleIdValue==0)
                                                                                                    ? "selected" : "" %>
                                                                                                    >Select Role
                                                                                                </option>
                                                                                                <c:forEach var="r"
                                                                                                    items="${allRoles}">
                                                                                                    <c:if
                                                                                                        test="${r.status eq 'active' and r.roleName ne 'Administrator'}">
                                                                                                        <option
                                                                                                            value="${r.roleId}"
                                                                                                            <%=(roleIdValue
                                                                                                            !=null &&
                                                                                                            roleIdValue.equals(((Role)
                                                                                                            pageContext.getAttribute("r")).getRoleId()))
                                                                                                            ? "selected"
                                                                                                            : "" %>
                                                                                                            >${r.roleName}
                                                                                                        </option>
                                                                                                    </c:if>
                                                                                                </c:forEach>
                                                                                            </select>
                                                                                            <% if (errors !=null &&
                                                                                                errors.containsKey("roleId"))
                                                                                                { %><span
                                                                                                    class="field-error">
                                                                                                    <%= errors.get("roleId")
                                                                                                        %>
                                                                                                </span>
                                                                                                <% } %>

                                                                                                    <div
                                                                                                        class="form-actions">
                                                                                                        <button
                                                                                                            type="submit"
                                                                                                            class="btn-submit"
                                                                                                            onclick="return validateAddUserForm()">Add
                                                                                                            User</button>
                                                                                                        <button
                                                                                                            type="button"
                                                                                                            class="btn-close"
                                                                                                            onclick="hideAddForm()">Cancel</button>
                                                                                                    </div>
                                                    </form>
                                                </div>

                                                <div class="table-card" id="userTable"
                                                    style="display: <%= showFormOnLoad ? " none" : "block" %>;">
                                                    <table>
                                                        <thead>
                                                            <tr>
                                                                <th><a href="javascript:sortBy('user_id')">ID <% if
                                                                            ("user_id".equals(currentSortField)) { %>
                                                                            <%= "ASC" .equals(currentSortOrder) ? "▲"
                                                                                : "▼" %>
                                                                                <% } %></a></th>
                                                                <th><a href="javascript:sortBy('username')">Username <%
                                                                            if ("username".equals(currentSortField)) {
                                                                            %>
                                                                            <%= "ASC" .equals(currentSortOrder) ? "▲"
                                                                                : "▼" %>
                                                                                <% } %></a></th>
                                                                <th><a href="javascript:sortBy('full_name')">Full Name
                                                                        <% if ("full_name".equals(currentSortField)) {
                                                                            %>
                                                                            <%= "ASC" .equals(currentSortOrder) ? "▲"
                                                                                : "▼" %>
                                                                                <% } %>
                                                                    </a></th>
                                                                <th><a href="javascript:sortBy('email')">Email <% if
                                                                            ("email".equals(currentSortField)) { %>
                                                                            <%= "ASC" .equals(currentSortOrder) ? "▲"
                                                                                : "▼" %>
                                                                                <% } %></a></th>
                                                                <th><a href="javascript:sortBy('role_name')">Role <% if
                                                                            ("role_name".equals(currentSortField)) { %>
                                                                            <%= "ASC" .equals(currentSortOrder) ? "▲"
                                                                                : "▼" %>
                                                                                <% } %></a></th>
                                                                <th><a href="javascript:sortBy('status')">Status <% if
                                                                            ("status".equals(currentSortField)) { %>
                                                                            <%= "ASC" .equals(currentSortOrder) ? "▲"
                                                                                : "▼" %>
                                                                                <% } %></a></th>
                                                                <th>Actions</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <% List<Users> users = (List<Users>)
                                                                    request.getAttribute("users");
                                                                    if (users != null && !users.isEmpty()) {
                                                                    for (Users user : users) {
                                                                    String statusClass =
                                                                    "active".equalsIgnoreCase(user.getStatus()) ?
                                                                    "danger" : "success";
                                                                    String statusAction =
                                                                    "active".equalsIgnoreCase(user.getStatus()) ?
                                                                    "Deactivate" : "Activate";
                                                                    %>
                                                                    <tr>
                                                                        <td><strong>#<%= user.getUserId() %></strong>
                                                                        </td>
                                                                        <td><span class="user-info">
                                                                                <%= user.getUsername() %>
                                                                            </span></td>
                                                                        <td>
                                                                            <%= user.getFullName() %>
                                                                        </td>
                                                                        <td><span class="user-email">
                                                                                <%= user.getEmail() %>
                                                                            </span></td>
                                                                        <td><span class="role-badge">
                                                                                <%= user.getRoleName() !=null ?
                                                                                    user.getRoleName() : "N/A" %>
                                                                            </span></td>
                                                                        <td>
                                                                            <% if
                                                                                ("active".equalsIgnoreCase(user.getStatus()))
                                                                                { %>
                                                                                <span
                                                                                    class="status-badge status-active">●
                                                                                    Active</span>
                                                                                <% } else { %>
                                                                                    <span
                                                                                        class="status-badge status-inactive">●
                                                                                        Inactive</span>
                                                                                    <% } %>
                                                                        </td>
                                                                        <td class="action-links">
                                                                            <a
                                                                                href="user-detail?id=<%= user.getUserId() %>">View</a>
                                                                            <% if (user.getRoleId() !=1) { %>
                                                                                <a href="javascript:void(0)"
                                                                                    onclick="confirmStatusChange('<%= request.getContextPath() %>/user-list?action=changeStatus&id=<%= user.getUserId() %>', 'this user', <%= "active".equalsIgnoreCase(user.getStatus())
                                                                                    %>)"
                                                                                    class="<%= statusClass %>">
                                                                                        <%= statusAction %>
                                                                                </a>
                                                                                <% } %>
                                                                        </td>
                                                                    </tr>
                                                                    <% } } else { %>
                                                                        <tr>
                                                                            <td colspan="7" class="empty-state">
                                                                                <div
                                                                                    style="font-size: 3rem; margin-bottom: 0.5rem;">
                                                                                    👥</div>
                                                                                No users found.
                                                                            </td>
                                                                        </tr>
                                                                        <% } %>
                                                        </tbody>
                                                    </table>
                                                </div>

                                                <% Integer currentPage=(Integer) request.getAttribute("currentPage");
                                                    Integer totalPages=(Integer) request.getAttribute("totalPages");
                                                    Integer totalRecords=(Integer) request.getAttribute("totalRecords");
                                                    Integer recordsPerPage=(Integer)
                                                    request.getAttribute("recordsPerPage"); if (currentPage==null)
                                                    currentPage=1; if (totalPages==null) totalPages=1; if
                                                    (totalRecords==null) totalRecords=0; if (recordsPerPage==null)
                                                    recordsPerPage=10; %>

                                                    <div class="pagination" id="paginationContainer"
                                                        style="display: <%= showFormOnLoad ? " none" : "flex" %>;">
                                                        <% if (currentPage> 1) { %>
                                                            <a href="javascript:goToPage(<%= currentPage - 1 %>)">«
                                                                Prev</a>
                                                            <% } else { %>
                                                                <span class="disabled">« Prev</span>
                                                                <% } %>

                                                                    <% int startPage=Math.max(1, currentPage - 2); int
                                                                        endPage=Math.min(totalPages, currentPage + 2);
                                                                        if (startPage> 1) { %>
                                                                        <a href="javascript:goToPage(1)">1</a>
                                                                        <% if (startPage> 2) { %><span>...</span>
                                                                            <% } } %>

                                                                                <% for (int i=startPage; i <=endPage;
                                                                                    i++) { if (i==currentPage) { %>
                                                                                    <span class="current-page">
                                                                                        <%= i %>
                                                                                    </span>
                                                                                    <% } else { %>
                                                                                        <a
                                                                                            href="javascript:goToPage(<%= i %>)">
                                                                                            <%= i %>
                                                                                        </a>
                                                                                        <% } } %>

                                                                                            <% if (endPage < totalPages)
                                                                                                { if (endPage <
                                                                                                totalPages - 1) { %>
                                                                                                <span>...</span>
                                                                                                <% } %>
                                                                                                    <a
                                                                                                        href="javascript:goToPage(<%= totalPages %>)">
                                                                                                        <%= totalPages
                                                                                                            %>
                                                                                                    </a>
                                                                                                    <% } %>

                                                                                                        <% if
                                                                                                            (currentPage
                                                                                                            <
                                                                                                            totalPages)
                                                                                                            { %>
                                                                                                            <a
                                                                                                                href="javascript:goToPage(<%= currentPage + 1 %>)">Next
                                                                                                                »</a>
                                                                                                            <% } else {
                                                                                                                %>
                                                                                                                <span
                                                                                                                    class="disabled">Next
                                                                                                                    »</span>
                                                                                                                <% } %>

                                                                                                                    <span
                                                                                                                        class="pagination-info"
                                                                                                                        style="margin-left: 1rem;">
                                                                                                                        Showing
                                                                                                                        <%= Math.min((currentPage
                                                                                                                            -
                                                                                                                            1)
                                                                                                                            *
                                                                                                                            recordsPerPage
                                                                                                                            +
                                                                                                                            1,
                                                                                                                            totalRecords)
                                                                                                                            %>
                                                                                                                            -
                                                                                                                            <%= Math.min(currentPage
                                                                                                                                *
                                                                                                                                recordsPerPage,
                                                                                                                                totalRecords)
                                                                                                                                %>
                                                                                                                                of
                                                                                                                                <%= totalRecords
                                                                                                                                    %>
                                                                                                                    </span>
                                                    </div>

                                                    <a href="<%= request.getContextPath() %>/dashboard"
                                                        class="back-link">← Back to Dashboard</a>
                            </div>

                            <jsp:include page="footer.jsp" />

                            <script>
                                function showAddForm() {
                                    document.getElementById('addFormContainer').style.display = 'block';
                                    document.getElementById('filterContainer').style.display = 'none';
                                    document.getElementById('userTable').style.display = 'none';
                                    document.getElementById('paginationContainer').style.display = 'none';
                                    document.getElementById('showAddFormBtn').style.display = 'none';
                                }

                                function hideAddForm() {
                                    document.getElementById('addFormContainer').style.display = 'none';
                                    document.getElementById('filterContainer').style.display = 'flex';
                                    document.getElementById('userTable').style.display = 'block';
                                    document.getElementById('paginationContainer').style.display = 'flex';
                                    document.getElementById('showAddFormBtn').style.display = 'inline-flex';
                                }

                                function validateAddUserForm() {
                                    let valid = true;
                                    const username = document.getElementById('username').value.trim();
                                    const password = document.getElementById('password').value.trim();
                                    const fullName = document.getElementById('fullName').value.trim();
                                    const email = document.getElementById('email').value.trim();
                                    const roleId = document.getElementById('roleIdSelect').value;

                                    if (username === '' || password === '' || fullName === '' || email === '' || roleId === '0') {
                                        valid = false;
                                    }
                                    return valid;
                                }

                                function sortBy(field) {
                                    const params = new URLSearchParams(window.location.search);
                                    const currentField = params.get('sort_field') || 'user_id';
                                    const currentOrder = params.get('sort_order') || 'ASC';

                                    let newOrder = 'ASC';
                                    if (field === currentField && currentOrder === 'ASC') {
                                        newOrder = 'DESC';
                                    }

                                    params.set('sort_field', field);
                                    params.set('sort_order', newOrder);
                                    params.set('page', '1');
                                    window.location.href = 'user-list?' + params.toString();
                                }

                                function goToPage(page) {
                                    const params = new URLSearchParams(window.location.search);
                                    params.set('page', page);
                                    window.location.href = 'user-list?' + params.toString();
                                }
                            </script>
                            <%@include file="common-dialogs.jsp" %>
                        </body>

                        </html>