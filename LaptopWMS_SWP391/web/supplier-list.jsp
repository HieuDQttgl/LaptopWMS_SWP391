<%@ page import="Model.Supplier"%>
<%@ page import="Model.Users"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html>
    <jsp:include page="header.jsp"/>
    <head>
        <meta charset="UTF-8">
        <title>Supplier Management</title>

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
                margin-right: 10px;
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

            .btn-secondary {
                display: inline-block;
                padding: 10px 18px;
                background-color: #95a5a6;
                color: white;
                text-decoration: none;
                border-radius: 6px;
                font-weight: 600;
                margin-top: 20px;
                transition: background-color 0.3s;
            }
            .btn-secondary:hover {
                background-color: #7f8c8d;
            }
        </style>
    </head>
    <body>

        <div class="container">
            <h1>Supplier Management List</h1>

            <%
                String successMessage = (String) request.getSession().getAttribute("message");
                String errorMessage = (String) request.getSession().getAttribute("error");

                Map<String, String> errors = (Map<String, String>) request.getAttribute("errors");
                Supplier tempSupplier = (Supplier) request.getAttribute("tempSupplier");
                Users currentUser = (Users) request.getAttribute("currentUser");

                boolean showFormOnLoad = errors != null || tempSupplier != null;
                boolean isAdmin = currentUser != null && currentUser.getRoleId() == 1;

                String currentKeyword = (String) request.getAttribute("keyword");
                String currentStatus = (String) request.getAttribute("status_filter");
                String currentSortField = (String) request.getAttribute("sort_field");
                String currentSortOrder = (String) request.getAttribute("sort_order");

                if (currentKeyword == null) currentKeyword = "";
                if (currentStatus == null) currentStatus = "all";
                if (currentSortField == null) currentSortField = "supplier_id";
                if (currentSortOrder == null) currentSortOrder = "ASC";

                if (errorMessage != null) {
                    out.println("<p id='notification' class='message-error notification'>" + errorMessage + "</p>");
                    request.getSession().removeAttribute("error");
                } else if (successMessage != null) {
                    out.println("<p id='notification' class='message-success notification'>" + successMessage + "</p>");
                    request.getSession().removeAttribute("message");
                }
            %>

            <% if (isAdmin) { %>
            <button id="showAddFormBtn" class="btn-add">Add New Supplier</button>
            <% } %>

            <!-- Filter Section -->
            <div class="filter-container" id="filterContainer" style="display: <%= showFormOnLoad ? "none" : "flex"%>;">
                <form id="filterForm" action="supplier-list" method="get" style="width: 100%;">

                    <div class="filter-controls">

                        <div class="filter-group">
                            <input type="text" name="keyword" id="keywordFilter" 
                                   placeholder="Search by name/email/phone..." 
                                   value="<%= currentKeyword%>">
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
                                <option value="supplier_id" <%= "supplier_id".equals(currentSortField) ? "selected" : ""%>>ID</option>
                                <option value="supplier_name" <%= "supplier_name".equals(currentSortField) ? "selected" : ""%>>Supplier Name</option>
                                <option value="supplier_email" <%= "supplier_email".equals(currentSortField) ? "selected" : ""%>>Email</option>
                                <option value="supplier_phone" <%= "supplier_phone".equals(currentSortField) ? "selected" : ""%>>Phone</option>
                                <option value="status" <%= "status".equals(currentSortField) ? "selected" : ""%>>Status</option>
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

            <!-- Add Supplier Form -->
            <% if (isAdmin) { %>
            <div id="addFormContainer" class="add-form-container" style="display: <%= showFormOnLoad ? "block" : "none"%>;">
                <h3>Add New Supplier</h3>
                <form action="supplier-list" method="post">
                    <input type="hidden" name="action" value="add">

                    <%
                        String supplierNameValue = (tempSupplier != null && tempSupplier.getSupplierName() != null) 
                                ? tempSupplier.getSupplierName() : "";
                        String supplierEmailValue = (tempSupplier != null && tempSupplier.getSupplierEmail() != null) 
                                ? tempSupplier.getSupplierEmail() : "";
                        String supplierPhoneValue = (tempSupplier != null && tempSupplier.getSupplierPhone() != null) 
                                ? tempSupplier.getSupplierPhone() : "";
                    %>

                    <label for="supplierName">Supplier Name: <span style="color: red;">*</span></label>
                    <input type="text" id="supplierName" name="supplierName" value="<%= supplierNameValue%>">
                    <% if (errors != null && errors.containsKey("supplierName")) {%>
                    <span class="field-error"><%= errors.get("supplierName")%></span>
                    <% }%>

                    <label for="supplierEmail">Email:</label>
                    <input type="email" id="supplierEmail" name="supplierEmail" value="<%= supplierEmailValue%>">
                    <% if (errors != null && errors.containsKey("supplierEmail")) {%>
                    <span class="field-error"><%= errors.get("supplierEmail")%></span>
                    <% }%>

                    <label for="supplierPhone">Phone Number:</label>
                    <input type="text" id="supplierPhone" name="supplierPhone" value="<%= supplierPhoneValue%>" 
                           placeholder="e.g., 0901234567">
                    <% if (errors != null && errors.containsKey("supplierPhone")) {%>
                    <span class="field-error"><%= errors.get("supplierPhone")%></span>
                    <% }%>

                    <div class="form-actions">
                        <input type="submit" value="Add Supplier">
                        <button type="button" class="btn-close" onclick="hideAddForm()">Close Form</button>
                    </div>
                </form>
            </div>
            <% } %>

            <!-- Supplier Table -->
            <table id="supplierTable" style="display: <%= showFormOnLoad ? "none" : "table"%>;"> 
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Supplier Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Status</th>
                        <% if (isAdmin) { %>
                        <th>Action</th>
                        <% } %>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Supplier> suppliers = (List<Supplier>) request.getAttribute("suppliers");

                        if (suppliers != null && !suppliers.isEmpty()) {
                            for (Supplier supplier : suppliers) {
                    %>

                    <tr>
                        <td><%= supplier.getSupplierId()%></td>
                        <td><%= supplier.getSupplierName()%></td>
                        <td><%= supplier.getSupplierEmail() != null ? supplier.getSupplierEmail() : "—"%></td>
                        <td><%= supplier.getSupplierPhone() != null ? supplier.getSupplierPhone() : "—"%></td>

                        <td>
                            <%
                                if ("active".equalsIgnoreCase(supplier.getStatus())) {
                            %>
                            <span class="status-badge status-active">Active</span>
                            <% } else { %>
                            <span class="status-badge status-inactive">Inactive</span>
                            <% } %>
                        </td>

                        <% if (isAdmin) { %>
                        <td class="action-links">
                            <form action="supplier-list" method="post" style="display: inline;">
                                <input type="hidden" name="action" value="changeStatus">
                                <input type="hidden" name="id" value="<%= supplier.getSupplierId()%>">
                                <a href="#" onclick="this.closest('form').submit(); return false;">
                                    <%
                                        if ("active".equalsIgnoreCase(supplier.getStatus())) {
                                            out.print("Deactivate");
                                        } else {
                                            out.print("Activate");
                                        }
                                    %>
                                </a>
                            </form>
                        </td>
                        <% } %>
                    </tr>

                    <%
                        }
                    } else {
                    %>
                    <tr>
                        <td colspan="<%= isAdmin ? 6 : 5 %>" style="text-align: center; color: #7f8c8d;">No suppliers found.</td>
                    </tr>
                    <% }%>
                </tbody>
            </table>

            <p id="totalSuppliers" style="margin-top: 20px; color: #7f8c8d; display: <%= showFormOnLoad ? "none" : "block"%>;">
                Total Suppliers: <%= suppliers != null ? suppliers.size() : 0%>
            </p>
            <a id="backLanding" href="<%= request.getContextPath()%>/landing" class="btn-secondary" 
               style="display: <%= showFormOnLoad ? "none" : "inline-block"%>;">Back to Landing Page</a>
        </div>

        <script>
            var button = document.getElementById('showAddFormBtn');
            var formContainer = document.getElementById('addFormContainer');
            var notificationElement = document.getElementById('notification');
            var supplierTable = document.getElementById('supplierTable');
            var totalSuppliersParagraph = document.getElementById('totalSuppliers');
            var backLandingLink = document.getElementById('backLanding');
            var filterContainer = document.getElementById('filterContainer');

            function hideTableElements() {
                if (supplierTable) supplierTable.style.display = 'none';
                if (totalSuppliersParagraph) totalSuppliersParagraph.style.display = 'none';
                if (backLandingLink) backLandingLink.style.display = 'none';
                if (filterContainer) filterContainer.style.display = 'none';
            }

            function showTableElements() {
                if (supplierTable) supplierTable.style.display = 'table';
                if (totalSuppliersParagraph) totalSuppliersParagraph.style.display = 'block';
                if (backLandingLink) backLandingLink.style.display = 'inline-block';
                if (filterContainer) filterContainer.style.display = 'flex';
            }

            function hideAddForm() {
                if (formContainer) formContainer.style.display = 'none';
                showTableElements();
            }

            if (button) {
                button.addEventListener('click', function () {
                    var isHidden = formContainer.style.display === 'none' || formContainer.style.display === '';

                    if (isHidden) {
                        formContainer.style.display = 'block';
                        hideTableElements();
                    } else {
                        hideAddForm();
                    }
                });
            }

            function clearFilters() {
                document.getElementById('keywordFilter').value = '';
                document.getElementById('statusFilter').value = 'all';
                document.getElementById('sortField').value = 'supplier_id';
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
