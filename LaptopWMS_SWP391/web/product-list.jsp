<%-- 
    Document   : product-list
    Created on : Dec 11, 2025, 5:01:08 PM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="header.jsp"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Laptop Inventory</title>

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
                margin-bottom: 25px;
                text-align: center;
                color: #2c3e50;
                font-weight: 700;
            }

            /* 2. Notifications */
            #notification {
                display: none; /* Hidden by default */
                padding: 15px;
                margin-bottom: 20px;
                border-radius: 6px;
                text-align: center;
                font-weight: 600;
                width: 100%;
                box-sizing: border-box;
            }

            /* 3. Buttons */
            .btn-add {
                background-color: #2ecc71;
                color: white;
                padding: 12px 20px;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                font-size: 15px;
                font-weight: 600;
                margin-bottom: 20px;
                transition: background 0.3s;
                display: inline-block;
            }
            .btn-add:hover {
                background-color: #27ae60;
            }

            .btn-close {
                background-color: #95a5a6;
                color: white;
                padding: 10px 15px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-weight: 600;
                transition: background 0.3s;
            }
            .btn-close:hover {
                background-color: #7f8c8d;
            }

            .btn-filter {
                background-color: #3498db;
                color: white;
                padding: 9px 15px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-weight: 600;
                transition: background 0.3s;
            }
            .btn-filter:hover {
                background-color: #2980b9;
            }

            .btn-clear {
                background-color: #e74c3c;
                color: white;
                padding: 9px 15px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-weight: 600;
                transition: background 0.3s;
            }
            .btn-clear:hover {
                background-color: #c0392b;
            }

            /* 4. Filter Section */
            .filter-container {
                display: flex;
                flex-direction: column;
                gap: 15px;
                margin-bottom: 25px;
                padding: 20px;
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

            .filter-group {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .filter-group label {
                font-weight: 600;
                color: #34495e;
                white-space: nowrap;
            }

            .filter-group input[type="text"],
            .filter-group select {
                padding: 8px 12px;
                border: 1px solid #bdc3c7;
                border-radius: 4px;
                font-size: 14px;
                color: #2c3e50;
            }

            /* 5. Add Form (Hidden Toggle) */
            .add-form-container {
                display: none;
                border: 1px solid #bdc3c7;
                padding: 25px;
                margin-bottom: 30px;
                border-radius: 8px;
                background-color: #ffffff;
                box-shadow: 0 4px 10px rgba(0,0,0,0.05);
            }

            .add-form-container h3 {
                margin-top: 0;
                color: #2ecc71;
                border-bottom: 1px dashed #ecf0f1;
                padding-bottom: 10px;
            }

            .add-form-container label {
                display: block;
                margin-top: 15px;
                margin-bottom: 5px;
                font-weight: 600;
                color: #34495e;
            }

            .add-form-container input[type="text"],
            .add-form-container input[type="number"],
            .add-form-container select {
                width: 100%;
                padding: 10px;
                border: 1px solid #bdc3c7;
                border-radius: 4px;
                box-sizing: border-box; /* Ensures padding doesn't break width */
                font-size: 14px;
            }

            .add-form-container input[type="submit"] {
                background-color: #3498db;
                color: white;
                padding: 12px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-weight: 600;
                width: 100%;
                margin-top: 20px;
                font-size: 15px;
                transition: background 0.3s;
            }
            .add-form-container input[type="submit"]:hover {
                background-color: #2980b9;
            }

            /* 6. Data Table */
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 10px;
                border-radius: 8px;
                overflow: hidden; /* For rounded corners */
                box-shadow: 0 0 0 1px #e0e0e0; /* Subtle border */
            }

            th {
                background-color: #2c3e50;
                color: white;
                padding: 15px 12px;
                text-align: left;
                font-size: 14px;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                font-weight: 600;
            }

            td {
                padding: 15px 12px;
                border-bottom: 1px solid #f0f0f0;
                font-size: 14px;
                vertical-align: middle;
            }

            tr:last-child td {
                border-bottom: none;
            }
            tr:hover {
                background-color: #f7f9fb;
            }

            /* 7. Status Badges */
            .status-badge {
                display: inline-block;
                padding: 5px 10px;
                border-radius: 20px;
                font-weight: 700;
                font-size: 11px;
                text-transform: uppercase;
                letter-spacing: 0.5px;
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

            /* 8. Action Links */
            .action-links a {
                text-decoration: none;
                color: #2980b9;
                font-weight: 600;
                margin-right: 12px;
                transition: color 0.2s;
            }
            .action-links a:hover {
                color: #1a5276;
                text-decoration: underline;
            }

            /* 9. Misc */
            .text-muted {
                color: #7f8c8d;
                font-size: 0.9em;
            }
            .font-bold {
                font-weight: bold;
            }
            .text-center {
                text-align: center;
            }
            .qty-low {
                color: #e67e22;
                font-weight: bold;
            }
            .qty-out {
                color: #e74c3c;
                font-weight: bold;
            }

            /* Two column layout for form */
            .form-row {
                display: flex;
                gap: 20px;
            }
            .form-col {
                flex: 1;
            }

        </style>
    </head>
    <body>

        <div class="container">
            <h1>Laptop Inventory Management</h1>

            <c:if test="${not empty sessionScope.message}">
                <div id="notification" class="status-active" style="display: block;">
                    ${sessionScope.message}
                </div>
                <c:remove var="message" scope="session"/>
            </c:if>

            <button id="showAddFormBtn" class="btn-add">+ Add New Laptop</button>

            <div class="filter-container" id="filterContainer">
                <form id="filterForm" action="laptops" method="get" style="width: 100%;">
                    <div class="filter-controls">

                        <div class="filter-group">
                            <input type="text" name="keyword" id="keywordFilter" 
                                   placeholder="Search model name..." 
                                   value="${currentKeyword}">
                        </div>

                        <div class="filter-group">
                            <label>Brand:</label>
                            <select name="brand" id="brandFilter">
                                <option value="all" ${currentBrand == 'all' ? 'selected' : ''}>All Brands</option>
                                <option value="Apple" ${currentBrand == 'Apple' ? 'selected' : ''}>Apple</option>
                                <option value="Dell" ${currentBrand == 'Dell' ? 'selected' : ''}>Dell</option>
                                <option value="Asus" ${currentBrand == 'Asus' ? 'selected' : ''}>Asus</option>
                                <option value="Lenovo" ${currentBrand == 'Lenovo' ? 'selected' : ''}>Lenovo</option>
                                <option value="HP" ${currentBrand == 'HP' ? 'selected' : ''}>HP</option>
                                <option value="MSI" ${currentBrand == 'MSI' ? 'selected' : ''}>MSI</option>
                                <option value="Acer" ${currentBrand == 'Acer' ? 'selected' : ''}>Acer</option>
                            </select>
                        </div>

                        <div class="filter-group">
                            <label>Sort By:</label>
                            <select name="sort_field" id="sortField">
                                <option value="laptop_id" ${currentSortField == 'laptop_id' ? 'selected' : ''}>ID</option>
                                <option value="price" ${currentSortField == 'price' ? 'selected' : ''}>Price</option>
                                <option value="quantity" ${currentSortField == 'quantity' ? 'selected' : ''}>Quantity</option>
                            </select>
                        </div>

                        <div class="filter-group">
                            <select name="sort_order" id="sortOrder">
                                <option value="ASC" ${currentSortOrder == 'ASC' ? 'selected' : ''}>Ascending</option>
                                <option value="DESC" ${currentSortOrder == 'DESC' ? 'selected' : ''}>Descending</option>
                            </select>
                        </div>

                        <button type="submit" class="btn-filter">Apply Filter</button>
                        <button type="button" class="btn-clear" onclick="clearFilters()">Clear</button>
                    </div>
                </form>
            </div>

            <div id="addFormContainer" class="add-form-container">
                <h3>Add New Laptop</h3>
                <form action="product-add" method="post">

                    <label>Model Name:</label>
                    <input type="text" name="name" required placeholder="e.g. MacBook Pro M3 Max">

                    <label>Brand:</label>
                    <select name="brand">
                        <option value="Apple">Apple</option>
                        <option value="Dell">Dell</option>
                        <option value="Asus">Asus</option>
                        <option value="Lenovo">Lenovo</option>
                        <option value="HP">HP</option>
                        <option value="MSI">MSI</option>
                        <option value="Acer">Acer</option>
                    </select>

                    <div class="form-row">
                        <div class="form-col">
                            <label>Price ($):</label>
                            <input type="number" name="price" step="0.01" required>
                        </div>
                        <div class="form-col">
                            <label>Quantity:</label>
                            <input type="number" name="quantity" required>
                        </div>
                    </div>

                    <label>CPU:</label>
                    <input type="text" name="cpu" required placeholder="e.g. Intel Core i9-13900H">

                    <div class="form-row">
                        <div class="form-col">
                            <label>RAM:</label>
                            <input type="text" name="ram" required placeholder="e.g. 32GB DDR5">
                        </div>
                        <div class="form-col">
                            <label>Storage:</label>
                            <input type="text" name="storage" required placeholder="e.g. 1TB NVMe Gen4">
                        </div>
                    </div>

                    <label>Graphics Card (Optional):</label>
                    <input type="text" name="card" placeholder="e.g. NVIDIA RTX 4070">

                    <label>Screen (Optional):</label>
                    <input type="text" name="screen" placeholder="e.g. 16-inch OLED">

                    <label>Image URL:</label>
                    <input type="text" name="imageUrl" placeholder="http://...">

                    <div style="margin-top: 25px; display: flex; gap: 15px;">
                        <input type="submit" value="Save Laptop">
                        <button type="button" class="btn-close" onclick="hideAddForm()" style="width: auto; margin-top: 20px;">Cancel</button>
                    </div>
                </form>
            </div>

            <table id="productTable">
                <thead>
                    <tr>
                        <th style="width: 50px;">ID</th>
                        <th>Model Name</th>
                        <th>Brand</th>
                        <th>Specs (CPU / RAM / Storage)</th>
                        <th>Price</th>
                        <th>Qty</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty productList}">
                            <c:forEach var="p" items="${productList}">
                                <tr>
                                    <td>${p.id}</td>
                                    <td><strong>${p.name}</strong></td>
                                    <td>${p.brand}</td>

                                    <td style="font-size: 13px; color: #555;">
                                        <span style="color: #000; font-weight: 500;">${p.cpu}</span><br>
                                        ${p.ram} &bull; ${p.storage}
                                    </td>

                                    <td style="color: #2c3e50; font-weight: bold;">
                                        <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="$"/>
                                    </td>

                                    <td>
                                        <c:choose>
                                            <c:when test="${p.quantity == 0}"><span style="color:red; font-weight:bold;">Out of Stock</span></c:when>
                                            <c:when test="${p.quantity < 5}"><span style="color:orange; font-weight:bold;">Low (${p.quantity})</span></c:when>
                                            <c:otherwise>${p.quantity}</c:otherwise>
                                        </c:choose>
                                    </td>

                                    <td>
                                        <c:if test="${p.status eq 'active'}">
                                            <span class="status-badge status-active">Active</span>
                                        </c:if>
                                        <c:if test="${p.status ne 'active'}">
                                            <span class="status-badge status-inactive">Inactive</span>
                                        </c:if>
                                    </td>

                                    <td class="action-links">
                                        <a href="product-edit?id=${p.id}">Edit</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="8" style="text-align:center; padding: 30px; color: #7f8c8d;">
                                    No laptops found matching your criteria.
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>

            <p id="totalCount" class="text-muted" style="margin-top: 20px;">
                Total Items: ${not empty laptopList ? laptopList.size() : 0}
            </p>

        </div>

        <script>
            var showBtn = document.getElementById('showAddFormBtn');
            var formContainer = document.getElementById('addFormContainer');
            var table = document.getElementById('productTable');
            var filter = document.getElementById('filterContainer');
            var total = document.getElementById('totalCount');
            var notification = document.getElementById('notification');

            function clearFilters() {
                document.getElementById('keywordFilter').value = '';
                document.getElementById('brandFilter').value = 'all';
                document.getElementById('sortField').value = 'laptop_id';
                document.getElementById('sortOrder').value = 'ASC';
                document.getElementById('filterForm').submit();
            }

            showBtn.addEventListener('click', function () {
                formContainer.style.display = 'block';
                table.style.display = 'none';
                filter.style.display = 'none';
                total.style.display = 'none';
                showBtn.style.display = 'none';
                if (notification)
                    notification.style.display = 'none';
            });

            function hideAddForm() {
                formContainer.style.display = 'none';
                table.style.display = 'table';
                filter.style.display = 'flex';
                total.style.display = 'block';
                showBtn.style.display = 'inline-block';
            }

            if (notification) {
                setTimeout(function () {
                    notification.style.display = 'none';
                }, 4000);
            }
        </script>

        <jsp:include page="footer.jsp"/>
    </body>
</html>