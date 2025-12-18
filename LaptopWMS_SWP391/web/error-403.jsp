<%-- 
    Document   : error-403
    Created on : Dec 15, 2025, 11:09:03 AM
    Author     : super
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Laptop Warehouse Management System</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
                margin: 0;
                background-color: #f2eeee;
            }
            .error-container {
                text-align: center;
                background: white;
                padding: 40px;
                border-radius: 10px;
                box-shadow: 0 10px 40px rgba(0,0,0,0.2);
                max-width: 500px;
            }
            .error-code {
                font-size: 80px;
                font-weight: bold;
                color: #e74c3c;
                margin: 0;
            }
            .error-title {
                font-size: 24px;
                color: #333;
                margin: 20px 0;
            }
            .error-message {
                color: #666;
                margin: 20px 0;
                line-height: 1.6;
            }
            .btn {
                display: inline-block;
                padding: 12px 30px;
                background: black;
                color: white;
                text-decoration: none;
                border-radius: 5px;
                margin: 10px 5px;
                transition: background 0.3s;
            }
        </style>
    </head>
    <body>
        <div class="error-container">
            <h1 class="error-code">403</h1>
            <h2 class="error-title">Access Denied</h2>
            <p class="error-message">
                You don't have permission to access this page. 
                <br>Please contact your administrator if you believe this is an error.
            </p>
            <div>
                <a href="${pageContext.request.contextPath}/landing" class="btn">Go to Home</a>
                <a href="javascript:history.back()" class="btn btn-secondary">Go Back</a>
            </div>
        </div>
    </body>
</html>