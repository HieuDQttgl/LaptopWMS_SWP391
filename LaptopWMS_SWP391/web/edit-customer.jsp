<%-- 
    Document   : edit-customer
    Created on : Dec 17, 2025, 5:05:53 PM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<!DOCTYPE html>
<html>
    <head>
        <title>Laptop Warehouse Management System</title>
        <style>
            body {
                font-family: "Segoe UI", sans-serif;
                background: #f5f6fa;
                margin: 0;
                padding: 0;
            }
            .form-container {
                max-width: 500px;
                margin: 40px auto;
                background: white;
                padding: 30px;
                border-radius: 8px;
                box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            }
            h2 {
                text-align: center;
                color: #2c3e50;
                margin-top: 0;
            }
            .form-group {
                margin-bottom: 15px;
            }
            label {
                display: block;
                margin-bottom: 5px;
                font-weight: 600;
                color: #333;
            }
            input, select {
                width: 100%;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 4px;
                box-sizing: border-box;
            }
            .btn-save {
                width: 100%;
                padding: 12px;
                background: #2ecc71;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-size: 16px;
                font-weight: bold;
            }
            .btn-save:hover {
                background: #27ae60;
            }
            .link-back {
                display: block;
                text-align: center;
                margin-top: 15px;
                color: #7f8c8d;
                text-decoration: none;
            }
        </style>
    </head>
    <body>

        <jsp:include page="header.jsp" />

        <div class="form-container">
            <h2>Edit Customer</h2>
            <p style="text-align: center; color: #7f8c8d; font-size: 14px;">
                Editing Customer ID: <strong>${customer.customerId}</strong>
            </p>

            <form action="edit-customer" method="post">
                <input type="hidden" name="id" value="${customer.customerId}">

                <div class="form-group">
                    <label>Name</label>
                    <input type="text" name="name" value="${customer.customerName}" required>
                </div>

                <div class="form-group">
                    <label>Email</label>
                    <input type="email" name="email" value="${customer.email}" required>
                </div>

                <div class="form-group">
                    <label>Phone</label>
                    <input type="text" name="phone" value="${customer.phone}" required>
                </div>

                <div class="form-group">
                    <label>Address</label>
                    <input type="text" name="address" value="${customer.address}" required>
                </div>

                <button type="submit" class="btn-save">Update Customer</button>
                <a href="customer-list" class="link-back">Cancel</a>
            </form>
        </div>

        <jsp:include page="footer.jsp" />
    </body>
</html>
