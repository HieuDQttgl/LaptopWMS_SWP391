<%@page import="Model.Location"%>
<%@page import="DTO.InventoryDTO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Laptop Warehouse Management System</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            body {
                font-family: "Segoe UI", Arial, sans-serif;
                background-color: #f5f6fa;
                margin: 0;
                padding: 0;
                color: #2c3e50;
            }

            .inventory-container {
                max-width: 1200px;
                margin: 40px auto;
                padding: 0 20px;
            }

            .inventory-card {
                background-color: #ffffff;
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 4px 20px rgba(0,0,0,0.07);
            }

            .inventory-card h1 {
                text-align: center;
                font-weight: 700;
                margin-bottom: 25px;
                padding-bottom: 15px;
                border-bottom: 2px solid #e5e5e5;
            }

            .btn {
                padding: 8px 18px;
                border-radius: 6px;
                text-decoration: none;
                cursor: pointer;
                font-size: 14px;
                border: none;
                font-weight: 600;
                transition: all 0.25s ease;
                display: inline-block;
            }

            .btn:hover {
                transform: translateY(-1px);
                box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            }

            .controls {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 25px;
                padding: 15px;
                background-color: #f9fafb;
                border-radius: 8px;
            }

            .filter-group {
                display: flex;
                gap: 10px;
                align-items: center;
            }

            input[type="text"], select {
                padding: 8px 10px;
                border: 1px solid #d1d5db;
                border-radius: 6px;
                outline: none;
            }

            input:focus, select:focus {
                border-color: #0d6efd;
            }

            .btn-search {
                background-color: #10b981;
                color: white;
            }

            .btn-audit {
                background-color: #e67e22;
                color: white;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }

            th {
                background-color: #f8f9fa;
                color: #34495e;
                font-weight: 600;
                padding: 14px 12px;
                text-transform: uppercase;
                font-size: 0.85rem;
                border-bottom: 2px solid #edf2f7;
                cursor: pointer;
                position: relative;
                user-select: none;
            }

            th:hover {
                background-color: #e9ecef;
            }

            th .sort-icon {
                margin-left: 5px;
                font-size: 0.75rem;
                opacity: 0.5;
            }

            th.active .sort-icon {
                opacity: 1;
            }

            td {
                padding: 12px;
                border-bottom: 1px solid #edf2f7;
            }

            tr:hover {
                background-color: #f9fafb;
            }

            .pagination {
                display: flex;
                justify-content: center;
                margin-top: 25px;
                gap: 6px;
            }

            .pagination a {
                padding: 8px 12px;
                border: 1px solid #d1d5db;
                border-radius: 6px;
                text-decoration: none;
                color: #374151;
                background-color: white;
                font-weight: 500;
            }

            .pagination a.active {
                background-color: #10b981;
                color: white;
                border-color: #10b981;
            }

            .stock-low {
                color: #e74c3c;
                font-weight: bold;
            }

            .stock-medium {
                color: #f39c12;
                font-weight: bold;
            }

            .stock-high {
                color: #27ae60;
                font-weight: bold;
            }

        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>

        <%
            List<InventoryDTO> list = (List<InventoryDTO>) request.getAttribute("inventoryList");
            List<Location> locations = (List<Location>) request.getAttribute("locations");
            int selectedLoc = (int) request.getAttribute("selectedLocation");
            int currentPage = (int) request.getAttribute("currentPage");
            int totalPages = (int) request.getAttribute("totalPages");
            String searchParam = (String) request.getAttribute("search");
            String sortBy = (String) request.getAttribute("sortBy");
            String sortOrder = (String) request.getAttribute("sortOrder");
        %>

        <div class="inventory-container">
            <div class="inventory-card">
                <h1>Inventory Management</h1>
                <a href="add-inventory" class="btn" style="background-color: #2ecc71; color: white; margin-bottom: 15px;">
                    <i class="fas fa-plus"></i> Add New Product to Inventory
                </a>

                <div class="controls">
                    <form action="inventory" method="get" class="filter-group">
                        <select name="location" onchange="this.form.submit()">
                            <option value="0">All Locations</option>
                            <%
                                if (locations != null) {
                                    for (Location loc : locations) {
                            %>
                            <option value="<%= loc.getLocationId()%>" <%= selectedLoc == loc.getLocationId() ? "selected" : ""%>>
                                <%= loc.getLocationName()%>
                            </option>
                            <%
                                    }
                                }
                            %>
                        </select>

                        <input type="text" name="search" placeholder="Search product..." value="<%= searchParam%>">
                        <input type="hidden" name="sortBy" value="<%= sortBy%>">
                        <input type="hidden" name="sortOrder" value="<%= sortOrder%>">
                        <button type="submit" class="btn btn-search">
                            <i class="fas fa-search"></i> Search
                        </button>
                    </form>
                </div>

                <table>
                    <thead>
                        <tr>
                            <th onclick="sortTable('id')" class="<%= "id".equals(sortBy) ? "active" : ""%>">
                                ID 
                                <i class="fas fa-sort<%= "id".equals(sortBy) ? ("ASC".equals(sortOrder) ? "-up" : "-down") : ""%> sort-icon"></i>
                            </th>
                            <th onclick="sortTable('product')" class="<%= "product".equals(sortBy) ? "active" : ""%>">
                                Product Name
                                <i class="fas fa-sort<%= "product".equals(sortBy) ? ("ASC".equals(sortOrder) ? "-up" : "-down") : ""%> sort-icon"></i>
                            </th>
                            <th onclick="sortTable('location')" class="<%= "location".equals(sortBy) ? "active" : ""%>">
                                Location
                                <i class="fas fa-sort<%= "location".equals(sortBy) ? ("ASC".equals(sortOrder) ? "-up" : "-down") : ""%> sort-icon"></i>
                            </th>
                            <th onclick="sortTable('quantity')" class="<%= "quantity".equals(sortBy) ? "active" : ""%>">
                                Quantity
                                <i class="fas fa-sort<%= "quantity".equals(sortBy) ? ("ASC".equals(sortOrder) ? "-up" : "-down") : ""%> sort-icon"></i>
                            </th>
                            <th>Last Updated</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if (list != null && !list.isEmpty()) {
                                for (InventoryDTO item : list) {
                                    String stockClass = "";
                                    if (item.getStockQuantity() == 0) {
                                        stockClass = "stock-low";
                                    } else if (item.getStockQuantity() < 5) {
                                        stockClass = "stock-medium";
                                    } else {
                                        stockClass = "stock-high";
                                    }
                        %>
                        <tr>
                            <td><%= item.getInventoryId()%></td>
                            <td><strong><%= item.getProductName()%></strong></td>
                            <td><%= item.getLocationName()%></td>
                            <td class="<%= stockClass%>">
                                <%= item.getStockQuantity()%>
                                <% if (item.getStockQuantity() == 0) { %>
                                <i class="fas fa-exclamation-circle" title="Out of stock"></i>
                                <% } else if (item.getStockQuantity() < 5) { %>
                                <i class="fas fa-exclamation-triangle" title="Low stock"></i>
                                <% }%>
                            </td>
                            <td><%= item.getLastUpdated()%></td>
                            <td>
                                <a href="audit-inventory?productId=<%= item.getProductId()%>&locationId=<%= item.getLocationId()%>" 
                                   class="btn btn-audit">
                                    <i class="fas fa-clipboard-check"></i> Audit
                                </a>
                            </td>
                        </tr>
                        <%
                            }
                        } else {
                        %>
                        <tr>
                            <td colspan="6" style="text-align: center; padding: 30px;">
                                <i class="fas fa-inbox" style="font-size: 3rem; color: #ccc;"></i>
                                <p style="margin-top: 10px; color: #999;">No inventory records found.</p>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>

                <div style="margin-top: 20px; padding: 15px; background-color: #f9fafb; border-radius: 8px; display: flex; justify-content: space-between; align-items: center;">
                    <a href="javascript:history.back()" class="btn" style="background-color: #6c757d; color: white;">
                        <i class="fas fa-arrow-left"></i> Back
                    </a>

                    <div style="color: #6c757d; font-size: 14px; font-weight: 600;">
                        <% if (list != null && !list.isEmpty()) {
                                int totalRecordsCalc = Integer.parseInt(request.getAttribute("totalPages").toString()) * 10;
                                int startRecord = (currentPage - 1) * 10 + 1;
                                int endRecord = Math.min(currentPage * 10, totalRecordsCalc);
                        %>
                        <i class="fas fa-info-circle"></i>
                        Page <%= currentPage%> of <%= totalPages%> 
                        | Showing <%= list.size()%> items
                        <% } else { %>
                        <i class="fas fa-info-circle"></i> No records found
                        <% } %>
                    </div>
                </div>

                <% if (totalPages > 1) { %>
                <div class="pagination">
                    <%
                        String baseLink = "inventory?search=" + searchParam
                                + "&location=" + selectedLoc
                                + "&sortBy=" + sortBy
                                + "&sortOrder=" + sortOrder
                                + "&page=";

                        if (currentPage > 1) {
                    %>
                    <a href="<%= baseLink + (currentPage - 1)%>">
                        <i class="fas fa-chevron-left"></i> Prev
                    </a>
                    <% } %>

                    <%
                        int startPage = Math.max(1, currentPage - 2);
                        int endPage = Math.min(totalPages, currentPage + 2);

                        if (startPage > 1) {
                    %>
                    <a href="<%= baseLink%>1">1</a>
                    <% if (startPage > 2) { %>
                    <span style="padding: 8px;">...</span>
                    <% } %>
                    <% } %>

                    <% for (int i = startPage; i <= endPage; i++) {%>
                    <a href="<%= baseLink + i%>" class="<%= i == currentPage ? "active" : ""%>"><%= i%></a>
                    <% } %>

                    <% if (endPage < totalPages) { %>
                    <% if (endPage < totalPages - 1) { %>
                    <span style="padding: 8px;">...</span>
                    <% }%>
                    <a href="<%= baseLink + totalPages%>"><%= totalPages%></a>
                    <% } %>

                    <% if (currentPage < totalPages) {%>
                    <a href="<%= baseLink + (currentPage + 1)%>">
                        Next <i class="fas fa-chevron-right"></i>
                    </a>
                    <% }%>
                </div>
                <% }%>
            </div>
        </div>

        <jsp:include page="footer.jsp"></jsp:include>

            <script>
                function sortTable(column) {
                    const currentSort = '<%= sortBy%>';
                    const currentOrder = '<%= sortOrder%>';

                    let newOrder = 'ASC';
                    if (column === currentSort) {
                        newOrder = currentOrder === 'ASC' ? 'DESC' : 'ASC';
                    }

                    const searchParam = '<%= searchParam%>';
                    const locationParam = '<%= selectedLoc%>';

                    window.location.href = 'inventory?search=' + searchParam +
                            '&location=' + locationParam +
                            '&sortBy=' + column +
                            '&sortOrder=' + newOrder;
                }
        </script>
    </body>
</html>