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
        <title>Laptop Warehouse Management System</title>

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

            .btn-add {
                background-color: #2ecc71;
                color: white;
                padding: 6px 14px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-weight: 700;
                margin-bottom: 10px;
                text-decoration: none;
                display: inline-block;
            }
            
            .btn-add:hover {
                background-color: #27ae60;
            }

            table {
                width: 100%;
                border-collapse: separate;
                border-spacing: 0;
                margin-top: 10px;
                border-radius: 8px;
                overflow: hidden;
                box-shadow: 0 0 0 1px #e0e0e0;
            }

            th {
                background-color: #2c3e50;
                color: white;
                padding: 15px 12px;
                text-align: left;
                font-size: 14px;
                text-transform: uppercase;
                font-weight: 600;
            }

            td {
                padding: 15px 12px;
                border-bottom: 1px solid #f0f0f0;
                font-size: 14px;
                vertical-align: middle;
                background-color: white;
            }

            .parent-row {
                cursor: pointer;
                transition: background-color 0.2s;
            }
            .parent-row:hover {
                background-color: #f1f4f8 !important;
            }
            .parent-row strong {
                color: #2980b9;
            }

            .toggle-icon {
                display: inline-block;
                font-size: 12px;
                color: #95a5a6;
                transition: transform 0.3s ease;
            }
            .parent-row.active .toggle-icon {
                transform: rotate(90deg);
                color: #2c3e50;
            }

            .details-row {
                display: none;
            }
            .details-row.open {
                display: table-row;
            }
            .details-container {
                padding: 20px;
                background-color: #f8f9fa;
                border-bottom: 1px solid #ddd;
                box-shadow: inset 0 3px 6px rgba(0,0,0,0.05);
            }

            .inner-table {
                width: 100%;
                border: 1px solid #dcdcdc;
                margin-top: 10px;
            }
            .inner-table th {
                background-color: #ecf0f1;
                color: #555;
                font-size: 12px;
                padding: 8px;
                border-bottom: 1px solid #bdc3c7;
            }
            .inner-table td {
                font-size: 13px;
                padding: 8px;
                border-bottom: 1px solid #eee;
            }

            .status-badge {
                padding: 4px 10px;
                border-radius: 20px;
                font-size: 11px;
                font-weight: bold;
                text-transform: uppercase;
            }
            .status-active {
                background: #e6f7ed;
                color: #27ae60;
                border: 1px solid #27ae60;
            }
            .status-inactive {
                background: #fbebeb;
                color: #e74c3c;
                border: 1px solid #e74c3c;
            }

            .pagination {
                list-style: none;
                padding: 0;
                display: flex;
                gap: 5px;
                justify-content: center;
                margin-top: 30px;
            }
            .pagination a {
                text-decoration: none;
                padding: 8px 14px;
                border: 1px solid #ddd;
                color: #3498db;
                border-radius: 4px;
                font-weight: 600;
                transition: 0.2s;
            }
            .pagination .active {
                background-color: #3498db;
                color: white;
                border-color: #3498db;
            }
            .pagination a:hover:not(.active) {
                background-color: #f1f1f1;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"/>

        <div class="container">
            <h1>Laptop Product Management</h1>

            <div style="display: flex; justify-content: space-between; align-items: center;">
                <c:if test="${sessionScope.currentUser.getRoleId() == 1 or sessionScope.currentUser.getRoleId() == 2}">
                    <a href="add-product" class="btn-add">+ Add New Product</a>
                </c:if>
            </div>

            <div class="filter-container" style="margin-bottom: 20px; padding: 15px; background: #fff; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.05);">
                <form action="product-list" method="get" style="display: flex; gap: 15px; align-items: center; flex-wrap: wrap;">

                    <div class="filter-group">
                        <input type="text" name="keyword" placeholder="Search model name..." 
                               value="${currentKeyword}" 
                               style="padding: 6px 12px; border: 1px solid #ccc; border-radius: 4px; width: 200px;">
                    </div>
                    <button type="submit" class="btn-filter" style="padding: 6px 12px; background: #3498db; color: white; border: none; border-radius: 4px; cursor: pointer;">Search</button>

                    <div class="filter-group">
                        <select name="status" onchange="this.form.submit()" style="padding: 6px; border: 1px solid #ccc; border-radius: 4px;">
                            <option value="all" ${currentStatus == 'all' ? 'selected' : ''}>All Status</option>
                            <option value="1" ${currentStatus == '1' ? 'selected' : ''}>Active</option>
                            <option value="0" ${currentStatus == '0' ? 'selected' : ''}>Inactive</option>
                        </select>
                    </div>

                    <div class="filter-group">
                        <select name="category" onchange="this.form.submit()" style="padding: 6px; border: 1px solid #ccc; border-radius: 4px;">
                            <option value="all" ${currentCategory == 'all' ? 'selected' : ''}>All Categories</option>
                            <option value="Office" ${currentCategory == 'Office' ? 'selected' : ''}>Office</option>
                            <option value="Gaming" ${currentCategory == 'Gaming' ? 'selected' : ''}>Gaming</option>
                            <option value="Workstation" ${currentCategory == 'Workstation' ? 'selected' : ''}>Workstation</option>
                        </select>
                    </div>

                    <div class="filter-group">
                        <select name="brand" onchange="this.form.submit()" style="padding: 6px; border: 1px solid #ccc; border-radius: 4px;">
                            <option value="all" ${currentBrand == 'all' ? 'selected' : ''}>All Brands</option>
                            <option value="Dell" ${currentBrand == 'Dell' ? 'selected' : ''}>Dell</option>
                            <option value="HP" ${currentBrand == 'HP' ? 'selected' : ''}>HP</option>
                            <option value="ASUS" ${currentBrand == 'ASUS' ? 'selected' : ''}>Asus</option>
                            <option value="Lenovo" ${currentBrand == 'Lenovo' ? 'selected' : ''}>Lenovo</option>
                            <option value="Apple" ${currentBrand == 'Apple' ? 'selected' : ''}>Apple</option>
                        </select>
                    </div>

                    <div class="filter-group">
                        <select name="sort_order" onchange="this.form.submit()" style="padding: 6px; border: 1px solid #ccc; border-radius: 4px;">
                            <option value="ASC" ${currentSortOrder == 'ASC' ? 'selected' : ''}>Oldest</option>
                            <option value="DESC" ${currentSortOrder == 'DESC' ? 'selected' : ''}>Newest</option>
                        </select>
                    </div>

                    <a href="product-list" class="btn-clear" style="padding: 6px 12px; background: #e74c3c; color: white; text-decoration: none; border-radius: 4px; font-size: 13px; font-weight: 600;">Clear</a>
                </form>
            </div>

            <table id="productTable">
                <thead>
                    <tr>
                        <th style="width: 40px;"></th> <th>ID</th>
                        <th>Model Name</th>
                        <th>Brand</th>
                        <th>Category</th>
                        <th>Supplier</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty productList}">
                            <c:forEach var="p" items="${productList}">

                                <tr class="parent-row" onclick="toggleDetails('row-${p.productId}', this)">
                                    <td style="text-align: center;">
                                        <span class="toggle-icon">&#9654;</span>
                                    </td>
                                    <td>${p.productId}</td>
                                    <td><strong>${p.productName}</strong></td>
                                    <td>${p.brand}</td>
                                    <td>${p.category}</td>
                                    <td>${p.supplierName}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${p.status}">
                                                <span class="status-badge status-active">Active</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status-badge status-inactive">Inactive</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td onclick="event.stopPropagation();">
                                        <a href="edit-product?id=${p.productId}" style="text-decoration: none; color: #3498db; margin-right: 10px;">Edit</a>
                                        <a href="toggleProduct?id=${p.productId}" 
                                           style="color: ${p.status ? '#e74c3c' : '#2ecc71'}; text-decoration: none; font-weight: 600; font-size: 13px;">
                                            ${p.status ? 'Deactivate' : 'Activate'}
                                        </a>
                                    </td>
                                </tr>

                                <tr id="row-${p.productId}" class="details-row">
                                    <td colspan="8" style="padding: 0;">
                                        <div class="details-container">
                                            <h4 style="margin: 0 0 10px 0; color: #555;">Available Configurations for ${p.productName}</h4>

                                            <a href="add-product-detail?id=${p.productId}" 
                                               class="btn-add">
                                                + Add Detail
                                            </a>

                                            <table class="inner-table">
                                                <thead>
                                                    <tr>
                                                        <th>CPU</th>
                                                        <th>GPU</th>
                                                        <th>Storage</th>
                                                        <th>RAM</th>
                                                        <th>Screen</th>
                                                        <th>Status</th>
                                                        <th>Action</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:choose>
                                                        <c:when test="${not empty p.detailsList}">
                                                            <c:forEach var="d" items="${p.detailsList}">
                                                                <tr>
                                                                    <td><b>${d.cpu}</b></td>
                                                                    <td><b>${d.gpu}</b></td>
                                                                    <td><b>${d.storage}</b></td>
                                                                    <td><b>${d.ram}</b></td>
                                                                    <td><b>${d.screen}"</b></td>
                                                                    <td>
                                                                        <c:choose>
                                                                            <c:when test="${d.status}"><span style="color: green;">Active</span></c:when>
                                                                            <c:otherwise><span style="color: red;">Hidden</span></c:otherwise>
                                                                        </c:choose>
                                                                    </td>

                                                                    <td>
                                                                        <a href="edit-product-detail?id=${d.productDetailId}" style="color: #3498db; text-decoration: none; font-weight: 600;">Edit</a>
                                                                        <span style="color: #ccc; margin: 0 5px;">|</span>

                                                                        <a href="toggleSpec?id=${d.productDetailId}" 
                                                                           style="color: ${d.status ? '#e74c3c' : '#2ecc71'}; text-decoration: none; font-size: 12px;">
                                                                            ${d.status ? 'Deactivate' : 'Activate'}
                                                                        </a>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <tr>
                                                                <td colspan="7" style="text-align:center; color: #999;">
                                                                    No configurations found.
                                                                </td>
                                                            </tr>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </tbody>
                                            </table>
                                        </div>
                                    </td>
                                </tr>

                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr><td colspan="8" style="text-align:center; padding:30px;">No products found.</td></tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>

            <c:if test="${totalPages > 1}">
                <div class="pagination">
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <a href="product-list?page=${i}&keyword=${currentKeyword}&brand=${currentBrand}&category=${currentCategory}&status=${currentStatus}&sort_order=${currentSortOrder}"
                           class="${currentPage == i ? 'active' : ''}">
                            ${i}
                        </a>
                    </c:forEach>
                </div>
            </c:if>

                            <a href="<%= request.getContextPath()%>/landing" style="color: #bab0b0; font-style: italic; text-decoration: none;"><- Back to homepage</a>
        </div>

        <script>
            function toggleDetails(rowId, parentRow) {
                var detailRow = document.getElementById(rowId);

                if (detailRow.classList.contains('open')) {
                    detailRow.classList.remove('open');
                    parentRow.classList.remove('active');
                } else {
                    detailRow.classList.add('open');
                    parentRow.classList.add('active');
                }
            }
        </script>

        <jsp:include page="footer.jsp"/>
    </body>
</html>