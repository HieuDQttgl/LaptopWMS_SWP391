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
        <title>Audit Inventory - Product ID: ${productId}</title>
        <style>
            body {
                font-family: Arial;
                margin: 20px;
                background-color: #ffffff;
            }

            h1 {
                font-size: 22px;
                margin-bottom: 10px;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 15px;
            }

            th, td {
                border: 1px solid #ccc;
                padding: 8px;
                font-size: 14px;
            }

            th {
                background-color: #eee;
                text-align: left;
            }

            select, input[type="text"] {
                width: 100%;
                padding: 5px;
                font-size: 13px;
            }

            button {
                margin-top: 15px;
                padding: 8px 16px;
                font-size: 14px;
                cursor: pointer;
            }

            .back-link {
                display: inline-block;
                margin-bottom: 10px;
                font-size: 14px;
            }

            .no-items {
                margin-top: 20px;
                padding: 10px;
                border: 1px solid #ccc;
            }

            .spec-summary {
                font-size: 13px;
            }

            .status-available {
                background-color: #f0fff0;
            }

            .status-lost {
                background-color: #fff0f0;
            }

            .status-damaged {
                background-color: #fffbe6;
            }

            .status-sold {
                background-color: #f0f8ff;
            }
        </style>

    </head>
    <body>
        <a href="inventory" class="back-link">← Back to Inventory</a>
        <div style="margin-top: 30px; padding: 15px; border: 1px solid #ddd; background: #f9f9f9;">
            <h3>Add New Unit (Serial Number)</h3>
            <form action="add-product-item" method="POST">
                <input type="hidden" name="productId" value="${productId}">
                <input type="hidden" name="locationId" value="${locationId}">

                <label>Select Specification:</label>
                <select name="detailId" required style="width: auto; margin-bottom: 10px;">
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

                <button type="submit" style="background-color: #28a745; color: white;">Add to Inventory</button>
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

                <button type="submit">Update Audit & Recalculate Stock</button>
            </form>
        </c:if>

    </body>
</html>