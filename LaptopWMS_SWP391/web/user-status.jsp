<%@ page import="Model.Users" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
     pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="header.jsp"/>
    <meta charset="UTF-8">
    <title>Change User Status</title>

    <style>
        body {
            font-family: "Segoe UI", sans-serif;
            background: #f5f6fa;
            padding: 0;
            margin: 0;
        }

        .container {
            width: 450px;
            margin: 60px auto;
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
            text-align: center;
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #e74c3c;
        }

        label {
            display: block;
            text-align: left;
            font-weight: 600;
            color: #34495e;
            margin-top: 10px;
        }

        input[type="text"] {
            width: 100%;
            padding: 10px 12px;
            margin-top: 5px;
            margin-bottom: 18px;
            border: 1px solid #dcdde1;
            border-radius: 8px;
            font-size: 15px;
            background: #ecf0f1; 
            color: #7f8c8d;
            box-sizing: border-box;
        }
        
        .status-info {
            font-size: 16px;
            font-weight: bold;
            margin: 20px 0;
            padding: 10px;
            border-radius: 4px;
        }
        .status-active { 
            color: #2ecc71; 
            background: #e6f7ed;
        }
        .status-inactive { 
            color: #e74c3c; 
            background: #fbebeb;
        }

        button {
            width: 100%;
            padding: 12px;
            background: #e74c3c;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            font-weight: bold;
            transition: 0.2s;
            margin-bottom: 10px;
        }

        button:hover {
            background: #c0392b;
        }
        
        .btn-cancel {
            background: #95a5a6;
        }
        .btn-cancel:hover {
            background: #7f8c8d;
        }
    </style>

</head>
<body>

    <div class="container">
        <h2>Confirm Status Change</h2>

        <%
            Users user = (Users) request.getAttribute("user");
            if (user == null) {
                out.println("<p style='color: red;'>Error: User data not available.</p>");
                return;
            }
            
            String currentStatus = user.getStatus();
            String newStatus = "active".equalsIgnoreCase(currentStatus) ? "inactive" : "active";
            String actionVerb = "active".equalsIgnoreCase(currentStatus) ? "DEACTIVATE" : "ACTIVATE";
        %>

        <p>
            You are doing **<%= actionVerb %>** for this account:
        </p>
        
        <form action="user-status" method="post">
            
            <input type="hidden" name="id" value="<%= user.getUserId() %>">
            <input type="hidden" name="newStatus" value="<%= newStatus %>">

            <label>User ID:</label>
            <input type="text" value="<%= user.getUserId() %>" disabled>
            
            <label>Username:</label>
            <input type="text" value="<%= user.getUsername() %>" disabled>

            <label>Current Status:</label>
            <input type="text" value="<%= currentStatus.toUpperCase() %>" disabled>
            
            <p class="status-info">
                New status: 
                <span class="status-<%= newStatus %>"><%= newStatus.toUpperCase() %></span>
            </p>

            <button type="submit">Confirm <%= actionVerb %></button>
            <button type="button" class="btn-cancel" onclick="window.location.href='user-list'">Cancel</button>
            
        </form>
    </div>
<jsp:include page="footer.jsp"/>
</body>
</html>