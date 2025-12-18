<%-- 
    Document   : inventory-audit
    Created on : Dec 15, 2025, 10:18:59 AM
    Author     : Admin
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Laptop Warehouse Management System</title>
        <style>
            body {
                font-family: "Segoe UI", Arial, sans-serif;
                background-color: #f5f6fa;
                margin: 0;
                padding: 0px;
                color: #2c3e50;
            }

            .container {
                max-width: 1200px;
                margin: 20px auto;
                background-color: white;
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 4px 20px rgba(0,0,0,0.08);
            }


            h1 {
                font-size: 24px;
                color: #2c3e50;
                margin-bottom: 25px;
                padding-bottom: 15px;
                border-bottom: 2px solid #edf2f7;
                text-align: center;
            }

            h3 {
                font-size: 18px;
                color: #34495e;
                margin-top: 0;
            }


            .add-unit-section {
                background: #f8f9fa;
                padding: 20px;
                border-radius: 8px;
                border: 1px solid #e9ecef;
                margin-bottom: 30px;
            }


            .form-inline {
                display: flex;
                flex-wrap: wrap;
                gap: 15px;
                align-items: flex-end;
            }

            .form-group {
                display: flex;
                flex-direction: column;
                gap: 5px;
            }

            label {
                font-weight: 600;
                font-size: 13px;
                color: #4a5568;
            }

            select, input[type="text"] {
                padding: 10px;
                border: 1px solid #dcdde1;
                border-radius: 6px;
                font-size: 14px;
                outline: none;
                transition: border 0.3s;
            }

            select:focus, input:focus {
                border-color: #3498db;
            }


            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 10px;
                background: white;
            }

            th {
                background-color: #f8f9fa;
                color: #4a5568;
                font-weight: 600;
                padding: 15px 12px;
                text-align: left;
                border-bottom: 2px solid #edf2f7;
            }

            td {
                padding: 12px;
                border-bottom: 1px solid #edf2f7;
                vertical-align: middle;
                font-size: 14px;
            }

            tr:hover {
                background-color: #fcfcfc;
            }


            .btn {
                padding: 8px 18px;
                border-radius: 6px;
                font-size: 14px;
                font-weight: 600;
                border: none;
                cursor: pointer;
                text-decoration: none;
                display: inline-block;
            }
            .btn-back {
                background-color: #6c757d;
                color: white;
            }

            .btn-back:hover {
                background-color: #5a6268;
            }

            .btn-update {
                background-color: #10b981;
                color: white;
            }

            .btn-update:hover {
                background-color: #059669;
            }

            .action-bar {
                display: flex;
                justify-content: flex-end;
                margin-top: 25px;
            }

            .btn-primary {
                background-color: #3498db;
                color: white;
            }

            .btn-primary:hover {
                background-color: #2980b9;
            }

            .btn-success {
                background-color: #2ecc71;
                color: white;
            }

            .btn-success:hover {
                background-color: #27ae60;
            }

            .btn-secondary {
                background-color: #95a5a6;
                color: white;
                margin-bottom: 20px;
            }

            .btn-update {
                width: auto;
                font-size: 14px;
                padding: 8px 18px;
            }


            .status-badge {
                padding: 4px 8px;
                border-radius: 4px;
                font-size: 12px;
                font-weight: bold;
                text-transform: uppercase;
            }

            .status-available {
                color: #27ae60;
                background: #e8f8f0;
            }
            .status-lost {
                color: #e74c3c;
                background: #fdedec;
            }
            .status-damaged {
                color: #f39c12;
                background: #fef5e7;
            }
            .status-sold {
                color: #3498db;
                background: #ebf5fb;
            }

            .no-items {
                text-align: center;
                padding: 40px;
                color: #7f8c8d;
                border: 2px dashed #dcdde1;
                border-radius: 8px;
            </style>
            <title>Laptop Warehouse Management System</title></title
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>
            <a href="inventory" class="btn btn-back">Back to Inventory</a>
            <div style="margin-top: 30px;
                 padding: 15px;
                 border: 1px solid #ddd;
                 background: #f9f9f9;">
                <h3>Add New Unit (Serial Number)</h3>
                <form action="add-product-item" method="POST">
                    <input type="hidden" name="productId" value="${productId}">
                <input type="hidden" name="locationId" value="${locationId}">

                <label>Select Specification:</label>
                <select name="detailId" required style="width: auto;
                        margin-bottom: 10px;">
                    <option value="">-- Choose Specs --</option>
                    <c:forEach items="${productDetails}" var="d">
                        <option value="${d.productDetailId}">
                            ${d.cpu} / RAM: ${d.ram} / Storage: ${d.storage}
                        </option>
                    </c:forEach>
                </select>

                <br>
                <label>Serial Number:</label>
                <input type="text" name="serialNumber" placeholder="Enter Serial..." required style="width: 200px;">

                <button type="submit" class="btn btn-update">Add to Inventory</button>
            </form>
        </div>
        <h1>Audit Inventory - Product ID: ${productId}</h1>

        <c:if test="${empty items}">
            <div class="no-items">
                <p>No items found for this product. Please add product items first.</p>
            </div>
        </c:if>

        <c:if test="${not empty items}">
            <form action="audit-inventory" method="post">
                <input type="hidden" name="productId" value="${productId}">

                <table border="1">
                    <thead>
                        <tr>
                            <th>Item ID</th>
                            <th>Serial Number</th>
                            <th>Specifications</th>
                            <th>Current Status</th>
                            <th>Update Status</th>
                            <th>Note</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${items}" var="item">
                            <tr class="status-${item.status.toLowerCase()}">
                                <td>${item.itemId}</td>
                                <td><strong>${item.serialNumber}</strong></td>
                                <td class="spec-summary">${item.specSummary}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${item.status == 'Available'}">
                                            <span style="color: green;">Available</span>
                                        </c:when>
                                        <c:when test="${item.status == 'Lost'}">
                                            <span style="color: red;">Lost</span>
                                        </c:when>
                                        <c:when test="${item.status == 'Damaged'}">
                                            <span style="color: orange;">Damaged</span>
                                        </c:when>
                                        <c:when test="${item.status == 'Sold'}">
                                            <span style="color: blue;">Sold</span>
                                        </c:when>
                                        <c:otherwise>
                                            ${item.status}
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <input type="hidden" name="itemId" value="${item.itemId}">
                                    <select name="status_${item.itemId}" required>
                                        <option value="Available" ${item.status == 'Available' ? 'selected' : ''}>Available (Count in Stock)</option>
                                        <option value="Lost" ${item.status == 'Lost' ? 'selected' : ''}>Lost (No Count)</option>
                                        <option value="Damaged" ${item.status == 'Damaged' ? 'selected' : ''}>Damaged (No Count)</option>
                                        <option value="Sold" ${item.status == 'Sold' ? 'selected' : ''}>Sold (No Count)</option>
                                    </select>
                                </td>
                                <td>
                                    <input type="text" 
                                           name="note_${item.itemId}" 
                                           value="${item.itemNote != null ? item.itemNote : ''}"
                                           placeholder="Add note...">
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <div class="action-bar">
                    <button type="submit" class="btn btn-update">
                        Update Audit & Recalculate Stock
                    </button>
                </div>
            </form>
        </c:if>
        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>