<%@page import="Model.Location"%>
<%@page import="Model.InventoryDTO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Inventory Management</title>
        <style>
            .inventory-container {
                max-width: 1200px;
                margin: 20px auto;
                padding: 0 20px;
                font-family: Arial, sans-serif;
            }
            .controls {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
                background: #fff;
                padding: 15px;
                border-radius: 5px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }
            .filter-group {
                display: flex;
                gap: 10px;
            }
            .btn {
                padding: 8px 16px;
                border-radius: 4px;
                text-decoration: none;
                cursor: pointer;
                font-size: 14px;
                border: none;
            }
            .btn-audit {
                background-color: #2c3e50;
                color: white;
            }
            .btn-search {
                background-color: #10b981;
                color: white;
            }
            .btn-view {
                background-color: #3498db;
                color: white;
                padding: 5px 10px;
            }
            input[type="text"], select {
                padding: 8px;
                border: 1px solid #ddd;
                border-radius: 4px;
                outline: none;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                background: white;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }
            th, td {
                padding: 12px 15px;
                text-align: left;
                border-bottom: 1px solid #eee;
            }
            th {
                background-color: #f8f9fa;
                color: #333;
                font-weight: bold;
            }
            tr:hover {
                background-color: #f5f5f5;
            }
            .pagination {
                display: flex;
                justify-content: center;
                margin-top: 20px;
                gap: 5px;
            }
            .pagination a {
                padding: 8px 12px;
                border: 1px solid #ddd;
                text-decoration: none;
                color: #333;
                border-radius: 4px;
                background: white;
            }
            .pagination a.active {
                background-color: #10b981;
                color: white;
                border-color: #10b981;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>

        <div class="inventory-container">
            <h1>Inventory Management</h1>

            <div class="controls">
                <div>
                    <a href="audit-inventory" class="btn btn-audit">Audit Inventory</a>
                </div>
                
                <form action="inventory" method="get" class="filter-group">
                    <select name="location" onchange="this.form.submit()">
                        <option value="0">All Locations</option>
                        <%
                            List<Location> locations = (List<Location>) request.getAttribute("locations");
                            int selectedLoc = (int) request.getAttribute("selectedLocation");
                            if (locations != null) {
                                for (Location loc : locations) {
                        %>
                        <option value="<%= loc.getLocationId() %>" <%= selectedLoc == loc.getLocationId() ? "selected" : "" %>>
                            <%= loc.getLocationName() %>
                        </option>
                        <%
                                }
                            }
                        %>
                    </select>

                    <input type="text" name="search" placeholder="Search product..." value="<%= request.getAttribute("search") %>">
                    <button type="submit" class="btn btn-search">Search</button>
                </form>
            </div>

            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Product Name</th>
                        <th>Location</th>
                        <th>Quantity</th>
                        <th>Last Updated</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<InventoryDTO> list = (List<InventoryDTO>) request.getAttribute("inventoryList");
                        if (list != null && !list.isEmpty()) {
                            for (InventoryDTO item : list) {
                    %>
                    <tr>
                        <td><%= item.getInventoryId() %></td>
                        <td><%= item.getProductName() %></td>
                        <td><%= item.getLocationName() %></td>
                        <td><%= item.getStockQuantity() %></td>
                        <td><%= item.getLastUpdated() %></td>
                        <td>
                            <a href="inventory-detail?id=<%= item.getInventoryId() %>" class="btn btn-view">View Details</a>
                        </td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="6" style="text-align: center;">No inventory records found.</td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>

            <div class="pagination">
                <%
                    int currentPage = (int) request.getAttribute("currentPage");
                    int totalPages = (int) request.getAttribute("totalPages");
                    String searchParam = (String) request.getAttribute("search");
                    int locParam = (int) request.getAttribute("selectedLocation");
                    String baseLink = "inventory?search=" + searchParam + "&location=" + locParam + "&page=";

                    if (currentPage > 1) {
                %>
                <a href="<%= baseLink + (currentPage - 1) %>">&laquo; Prev</a>
                <% } %>

                <% for (int i = 1; i <= totalPages; i++) { %>
                <a href="<%= baseLink + i %>" class="<%= i == currentPage ? "active" : "" %>"><%= i %></a>
                <% } %>

                <% if (currentPage < totalPages) { %>
                <a href="<%= baseLink + (currentPage + 1) %>">Next &raquo;</a>
                <% } %>
            </div>
        </div>

        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>