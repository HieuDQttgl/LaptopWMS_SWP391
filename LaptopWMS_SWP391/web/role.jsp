<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="Model.Users" %>
<%@ page import="Model.Role" %>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="header.jsp"/>
        <meta charset="UTF-8">
        <title>Laptop Warehouse Management System</title>

        <style>
            body {
                font-family: 'Segoe UI', Arial, sans-serif;
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
                box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            }

            h1 {
                color: #333;
                margin-bottom: 10px;
            }

            .button-group {
                text-align: right;
                margin-bottom: 20px;
            }

            .button-group a.btn {
                background-color: #10b981;
                color: white;
                padding: 10px 18px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                text-decoration: none;
                display: inline-block;
                font-size: 14px;
                font-weight: 600;
                transition: background-color 0.3s;
                margin-left: 10px;
            }

            .button-group a.btn:hover {
                background-color: #059669;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }

            th {
                background-color: #f8f9fa;
                padding: 15px;
                text-align: left;
                border-bottom: 2px solid #e5e5e5;
                color: #4b5563;
                font-size: 13px;
                font-weight: 700;
                text-transform: uppercase;
            }

            td {
                padding: 15px;
                border-bottom: 1px solid #f0f0f0;
                color: #374151;
            }
            
            tr:hover {
                background-color: #f9fafb;
            }

    
            .custom-pagination {
                display: flex;
                justify-content: center;
                align-items: center;
                margin-top: 30px;
                gap: 8px;
            }

            .custom-pagination a {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                min-width: 36px;
                height: 36px;
                padding: 0 12px;
                font-size: 14px;
                font-weight: 500;
                color: #4b5563; 
                background-color: #ffffff;
                border: 1px solid #d1d5db;
                border-radius: 8px;
                text-decoration: none;
                transition: all 0.2s ease;
                box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
            }

            .custom-pagination a:hover {
                border-color: #10b981;
                color: #10b981;
                background-color: #ecfdf5;
                transform: translateY(-1px);
            }

            .custom-pagination .active {
                background-color: #10b981 !important;
                border-color: #10b981 !important;
                color: #ffffff !important;
                pointer-events: none;
                box-shadow: 0 4px 6px rgba(16, 185, 129, 0.3);
            }

            .custom-pagination span {
                color: #9ca3af;
                font-size: 14px;
            }
            
            .btn-back {
                display: inline-block;
                margin-top: 20px;
                color: #666;
                text-decoration: none;
            }
            .btn-back:hover {
                text-decoration: underline;
                color: #333;
            }
        </style>
    </head>
    <body>
        <div class="container">

            <h1>User Role Management</h1>

            <div class="button-group">
                <a href="add-role" class="btn">Add New Role</a>
                <a href="role-list" class="btn">Change Role Status</a>
                <a href="role-permission" class="btn">Change Role Permission</a>
            </div>

            <table class="table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Role Name</th>
                        <th>Description</th> 
                        <th>Role Status</th>
                        <th>Action</th>
                    </tr>
                </thead>

                <tbody>
                    <%
                        List<Role> roleList = (List<Role>) request.getAttribute("roleList");

                        if (roleList != null && !roleList.isEmpty()) {
                            for (Role role : roleList) {
                    %>
                    <tr>
                        <td><%= role.getRoleId()%></td>

                        <td><strong><%= role.getRoleName()%></strong></td>

                        <td style="color: #666; font-style: italic;">
                            <%= (role.getRoleDescription() != null) ? role.getRoleDescription() : ""%>
                        </td>

                        <td>
                            <% if ("active".equals(role.getStatus())) { %>
                            <span style="background: #d1fae5; color: #065f46; padding: 5px 12px; border-radius: 20px; font-size: 12px; font-weight: 600;">Active</span>
                            <% } else { %>
                            <span style="background: #fee2e2; color: #991b1b; padding: 5px 12px; border-radius: 20px; font-size: 12px; font-weight: 600;">Inactive</span>
                            <% }%>
                        </td>

                        <td>
                            <a href="edit-role?id=<%= role.getRoleId()%>" style="color: #2563eb; text-decoration: none; font-weight: 500;">Edit</a>
                        </td>
                    </tr>
                    <%
                        }
                    } else {
                    %>
                    <tr>
                        <td colspan="5" style="text-align: center; padding: 30px; color: #888;">No roles found</td>
                    </tr>
                    <% }%>
                </tbody>
            </table>

            <div class="custom-pagination">
                <%
                    // Xử lý null an toàn
                    Integer cpObj = (Integer) request.getAttribute("currentPage");
                    Integer tpObj = (Integer) request.getAttribute("totalPages");
                    int currentPage = (cpObj != null) ? cpObj : 1;
                    int totalPages = (tpObj != null) ? tpObj : 1;
                    
                    String baseLink = "role?page=";
                    
                    if (totalPages > 1) {
                %>
                
           
                <% if (currentPage > 1) { %>
                <a href="<%= baseLink + (currentPage - 1)%>">
                    <i class="fas fa-chevron-left" style="margin-right: 5px; font-size: 10px;"></i> Prev
                </a>
                <% } %>

        
                <%
                    int startPage = Math.max(1, currentPage - 2);
                    int endPage = Math.min(totalPages, currentPage + 2);

                    if (startPage > 1) {
                %>
                <a href="<%= baseLink%>1">1</a>
                <% if (startPage > 2) { %> <span>...</span> <% } %>
                <% } %>

                <% for (int i = startPage; i <= endPage; i++) {%>
                <a href="<%= baseLink + i%>" class="<%= i == currentPage ? "active" : ""%>"><%= i%></a>
                <% } %>

                <% if (endPage < totalPages) { %>
                <% if (endPage < totalPages - 1) { %> <span>...</span> <% }%>
                <a href="<%= baseLink + totalPages%>"><%= totalPages%></a>
                <% } %>

           
                <% if (currentPage < totalPages) {%>
                <a href="<%= baseLink + (currentPage + 1)%>">
                    Next <i class="fas fa-chevron-right" style="margin-left: 5px; font-size: 10px;"></i>
                </a>
                <% }%>
                
                <% }  %>
            </div>

            <div style="margin-top: 20px; color: #666; font-size: 14px;">
                Showing <%= roleList != null ? roleList.size() : 0 %> roles on this page.
            </div>
            
            <a href="javascript:history.back()" class="btn-back"> &larr; Back to Dashboard</a>
        </div>
        <jsp:include page="footer.jsp"/>
    </body>
</html>