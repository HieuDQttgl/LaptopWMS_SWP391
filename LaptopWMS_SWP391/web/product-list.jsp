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
        <title>Laptop Inventory</title>

        <style>
            /* --- GENERAL LAYOUT --- */
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

            /* --- BUTTONS --- */
            .btn-add {
                background-color: #2ecc71;
                color: white;
                padding: 12px 20px;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                font-weight: 600;
                margin-bottom: 20px;
                text-decoration: none;
                display: inline-block;
            }
            .btn-add:hover {
                background-color: #27ae60;
            }

            /* --- ACCORDION TABLE STYLES --- */
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

            /* Parent Row Styles */
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

            /* Toggle Icon */
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

            /* Hidden Child Row */
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

            /* Inner Specs Table */
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

            /* Status Badges */
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
        </style>
    </head>
    <body>

        <div class="container">
            <h1>Laptop Inventory Management</h1>

            <div style="display: flex; justify-content: space-between; align-items: center;">
                <button class="btn-add">+ Add New Product</button>
                <div style="color: #7f8c8d; font-size: 14px;">
                    Total Models: <strong>${not empty productList ? productList.size() : 0}</strong>
                </div>
            </div>

            <table id="productTable">
                <thead>
                    <tr>
                        <th style="width: 40px;"></th> <th>ID</th>
                        <th>Model Name</th>
                        <th>Brand</th>
                        <th>Category</th>
                        <th>Supplier</th>
                        <th>Base Unit</th>
                        <th>Status</th>
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
                                    <td>ID: ${p.supplierId}</td> <td>${p.unit}</td>
                                    <td>
                                        <c:if test="${p.status eq 'active'}"><span class="status-badge status-active">Active</span></c:if>
                                        <c:if test="${p.status ne 'active'}"><span class="status-badge status-inactive">Inactive</span></c:if>
                                        </td>
                                    </tr>

                                    <tr id="row-${p.productId}" class="details-row">
                                    <td colspan="8" style="padding: 0;">
                                        <div class="details-container">
                                            <h4 style="margin: 0 0 10px 0; color: #555;">Available Configurations for ${p.productName}</h4>

                                            <table class="inner-table">
                                                <thead>
                                                    <tr>
                                                        <th>RAM</th>
                                                        <th>Storage</th>
                                                        <th>CPU</th>
                                                        <th>GPU</th>
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
                                                                    <td><b>${d.ram}</b></td>
                                                                    <td><b>${d.storage}</b></td>
                                                                    <td>${d.cpu}</td>
                                                                    <td>${d.gpu}</td>
                                                                    <td>${d.screen}"</td>
                                                                    <td>
                                                                        <c:choose>
                                                                            <c:when test="${d.status}"><span style="color: green;">✔ Active</span></c:when>
                                                                            <c:otherwise><span style="color: red;">✖ Hidden</span></c:otherwise>
                                                                        </c:choose>
                                                                    </td>
                                                                    <td>
                                                                        <a href="#" style="color: #3498db; text-decoration: none;">Edit Spec</a>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <tr>
                                                                <td colspan="7" style="text-align:center; color: #999;">
                                                                    No configurations found. <a href="#">Add one?</a>
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

        </div>

        <script>
            // Accordion Logic
            function toggleDetails(rowId, parentRow) {
                var detailRow = document.getElementById(rowId);

                if (detailRow.classList.contains('open')) {
                    detailRow.classList.remove('open');
                    parentRow.classList.remove('active');
                } else {
                    // Optional: Close others before opening? 
                    // For now, let's allow multiple open for easier comparison
                    detailRow.classList.add('open');
                    parentRow.classList.add('active');
                }
            }
        </script>

        <jsp:include page="footer.jsp"/>
    </body>
</html>