<%-- Document : location-list Created on : Dec 18, 2025 Author : Antigravity --%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>

    <head>
        <title>Location Management - Laptop WMS</title>
        <style>
            body {
                font-family: "Segoe UI", Arial, sans-serif;
                background-color: #f5f6fa;
                margin: 0;
                padding: 0;
                color: #2c3e50;
            }

            .container {
                max-width: 1400px;
                margin: 40px auto;
                background-color: white;
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.07);
            }

            h1 {
                text-align: center;
                color: #2c3e50;
                font-weight: 700;
                margin-bottom: 25px;
            }

            /* Filter Section */
            .filter-container {
                margin-bottom: 20px;
                padding: 15px;
                background: #fff;
                border-radius: 8px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
                border: 1px solid #e0e0e0;
            }

            .filter-form {
                display: flex;
                gap: 15px;
                align-items: center;
                flex-wrap: wrap;
            }

            .filter-group {
                display: flex;
                flex-direction: column;
                gap: 4px;
            }

            .filter-group label {
                font-size: 12px;
                color: #666;
                font-weight: 600;
            }

            .filter-group input,
            .filter-group select {
                padding: 8px 12px;
                border: 1px solid #ccc;
                border-radius: 4px;
                font-size: 14px;
            }

            .filter-group input {
                width: 180px;
            }

            .btn-filter {
                padding: 8px 16px;
                background: #3498db;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-weight: 600;
                margin-top: 18px;
            }

            .btn-filter:hover {
                background: #2980b9;
            }

            .btn-clear {
                padding: 8px 16px;
                background: #e74c3c;
                color: white;
                text-decoration: none;
                border-radius: 4px;
                font-size: 13px;
                font-weight: 600;
                margin-top: 18px;
            }

            .btn-clear:hover {
                background: #c0392b;
            }

            .btn-add {
                background-color: #2ecc71;
                color: white;
                padding: 8px 16px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-weight: 700;
                text-decoration: none;
                display: inline-block;
            }

            .btn-add:hover {
                background-color: #27ae60;
            }

            /* Table Styles */
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
                padding: 14px 12px;
                text-align: left;
                font-size: 13px;
                text-transform: uppercase;
                font-weight: 600;
            }

            th a {
                color: white;
                text-decoration: none;
                display: flex;
                align-items: center;
                gap: 5px;
            }

            th a:hover {
                color: #ecf0f1;
            }

            .sort-icon {
                font-size: 10px;
            }

            td {
                padding: 14px 12px;
                border-bottom: 1px solid #f0f0f0;
                font-size: 14px;
                vertical-align: middle;
                background-color: white;
            }

            tr:hover td {
                background-color: #f8f9fa;
            }

            /* Status Badge */
            .status-badge {
                padding: 4px 10px;
                border-radius: 20px;
                font-size: 11px;
                font-weight: bold;
                text-transform: uppercase;
            }

            .status-available {
                background: #e6f7ed;
                color: #27ae60;
                border: 1px solid #27ae60;
            }

            .status-full {
                background: #fff3e6;
                color: #e67e22;
                border: 1px solid #e67e22;
            }

            .status-inactive {
                background: #fbebeb;
                color: #e74c3c;
                border: 1px solid #e74c3c;
            }

            /* Usage Bar */
            .usage-bar-container {
                width: 100px;
                height: 8px;
                background: #ecf0f1;
                border-radius: 4px;
                overflow: hidden;
                display: inline-block;
                vertical-align: middle;
                margin-right: 8px;
            }

            .usage-bar {
                height: 100%;
                border-radius: 4px;
                transition: width 0.3s ease;
            }

            .usage-low {
                background: #2ecc71;
            }

            .usage-medium {
                background: #f1c40f;
            }

            .usage-high {
                background: #e67e22;
            }

            .usage-full {
                background: #e74c3c;
            }

            /* Action Links */
            .action-link {
                text-decoration: none;
                color: #3498db;
                font-weight: 600;
                margin-right: 10px;
            }

            .action-link:hover {
                text-decoration: underline;
            }

            .action-link.edit {
                color: #2ecc71;
            }

            /* Pagination */
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

            .pagination a.active {
                background-color: #3498db;
                color: white;
                border-color: #3498db;
            }

            .pagination a:hover:not(.active) {
                background-color: #f1f1f1;
            }

            /* Summary */
            .table-summary {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 15px;
                color: #666;
                font-size: 14px;
            }

            .back-link {
                color: #bab0b0;
                font-style: italic;
                text-decoration: none;
            }

            .back-link:hover {
                color: #888;
            }
        </style>
    </head>

    <body>
        <jsp:include page="header.jsp" />

        <div class="container">
            <h1>📍 Warehouse Location Management</h1>

            <div class="filter-container">
                <form action="location-list" method="get" class="filter-form">
                    <div class="filter-group">
                        <label>Search</label>
                        <input type="text" name="keyword" placeholder="Name or ID..."
                               value="${currentKeyword}">
                    </div>

                    <div class="filter-group">
                        <label>Zone</label>
                        <select name="zone" onchange="this.form.submit()">
                            <option value="all">All Zones</option>
                            <c:forEach var="z" items="${zones}">
                                <option value="${z}" ${currentZone==z ? 'selected' : '' }>${z}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="filter-group">
                        <label>Aisle</label>
                        <select name="aisle" onchange="this.form.submit()">
                            <option value="all">All Aisles</option>
                            <c:forEach var="a" items="${aisles}">
                                <option value="${a}" ${currentAisle==a ? 'selected' : '' }>${a}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="filter-group">
                        <label>Status</label>
                        <select name="status" onchange="this.form.submit()">
                            <option value="all" ${currentStatus=='all' ? 'selected' : '' }>All Status
                            </option>
                            <option value="available" ${currentStatus=='available' ? 'selected' : '' }>
                                Available</option>
                            <option value="full" ${currentStatus=='full' ? 'selected' : '' }>Full</option>
                            <option value="active" ${currentStatus=='active' ? 'selected' : '' }>Active
                            </option>
                            <option value="inactive" ${currentStatus=='inactive' ? 'selected' : '' }>
                                Inactive</option>
                        </select>
                    </div>

                    <button type="submit" class="btn-filter">Search</button>
                    <a href="location-list" class="btn-clear">Clear</a>

                    <!-- Preserve sort order in form -->
                    <input type="hidden" name="sortBy" value="${currentSortBy}">
                    <input type="hidden" name="sortOrder" value="${currentSortOrder}">
                </form>
            </div>

            <div class="table-summary">
                <span>Showing ${(currentPage - 1) * 10 + 1} - ${(currentPage - 1) * 10 +
                                locationList.size()} of ${totalItems} locations</span>
                    <c:if test="${sessionScope.currentUser.getRoleId() == 1}">
                    <a href="add-location" class="btn-add">+ Add Location</a>
                </c:if>
            </div>

            <table>
                <thead>
                    <tr>
                        <th>
                            <a
                                href="location-list?keyword=${currentKeyword}&zone=${currentZone}&aisle=${currentAisle}&status=${currentStatus}&sortBy=id&sortOrder=${currentSortBy == 'id' && currentSortOrder == 'ASC' ? 'DESC' : 'ASC'}&page=${currentPage}">
                                ID <span class="sort-icon">${currentSortBy == 'id' ? (currentSortOrder ==
                                                             'ASC' ? '▲' : '▼') : '⇅'}</span>
                            </a>
                        </th>
                        <th>
                            <a
                                href="location-list?keyword=${currentKeyword}&zone=${currentZone}&aisle=${currentAisle}&status=${currentStatus}&sortBy=name&sortOrder=${currentSortBy == 'name' && currentSortOrder == 'ASC' ? 'DESC' : 'ASC'}&page=${currentPage}">
                                Name <span class="sort-icon">${currentSortBy == 'name' ? (currentSortOrder
                                                               == 'ASC' ? '▲' : '▼') : '⇅'}</span>
                            </a>
                        </th>
                        <th>
                            <a
                                href="location-list?keyword=${currentKeyword}&zone=${currentZone}&aisle=${currentAisle}&status=${currentStatus}&sortBy=zone&sortOrder=${currentSortBy == 'zone' && currentSortOrder == 'ASC' ? 'DESC' : 'ASC'}&page=${currentPage}">
                                Zone <span class="sort-icon">${currentSortBy == 'zone' ? (currentSortOrder
                                                               == 'ASC' ? '▲' : '▼') : '⇅'}</span>
                            </a>
                        </th>
                        <th>
                            <a
                                href="location-list?keyword=${currentKeyword}&zone=${currentZone}&aisle=${currentAisle}&status=${currentStatus}&sortBy=aisle&sortOrder=${currentSortBy == 'aisle' && currentSortOrder == 'ASC' ? 'DESC' : 'ASC'}&page=${currentPage}">
                                Aisle <span class="sort-icon">${currentSortBy == 'aisle' ? (currentSortOrder
                                                                == 'ASC' ? '▲' : '▼') : '⇅'}</span>
                            </a>
                        </th>
                        <th>Rack</th>
                        <th>Bin</th>
                        <th>
                            <a
                                href="location-list?keyword=${currentKeyword}&zone=${currentZone}&aisle=${currentAisle}&status=${currentStatus}&sortBy=capacity&sortOrder=${currentSortBy == 'capacity' && currentSortOrder == 'ASC' ? 'DESC' : 'ASC'}&page=${currentPage}">
                                Capacity <span class="sort-icon">${currentSortBy == 'capacity' ?
                                                                   (currentSortOrder == 'ASC' ? '▲' : '▼') : '⇅'}</span>
                            </a>
                        </th>
                        <th>
                            <a
                                href="location-list?keyword=${currentKeyword}&zone=${currentZone}&aisle=${currentAisle}&status=${currentStatus}&sortBy=usage&sortOrder=${currentSortBy == 'usage' && currentSortOrder == 'ASC' ? 'DESC' : 'ASC'}&page=${currentPage}">
                                Usage <span class="sort-icon">${currentSortBy == 'usage' ? (currentSortOrder
                                                                == 'ASC' ? '▲' : '▼') : '⇅'}</span>
                            </a>
                        </th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty locationList}">
                            <c:forEach var="loc" items="${locationList}">
                                <c:set var="usagePercent"
                                       value="${loc.capacity > 0 ? (loc.currentUsage * 100 / loc.capacity) : 0}" />
                                <tr>
                                    <td>${loc.locationId}</td>
                                    <td><strong>${loc.locationName}</strong></td>
                                    <td>${loc.zone != null ? loc.zone : '-'}</td>
                                    <td>${loc.aisle != null ? loc.aisle : '-'}</td>
                                    <td>${loc.rack != null ? loc.rack : '-'}</td>
                                    <td>${loc.bin != null ? loc.bin : '-'}</td>
                                    <td>${loc.capacity}</td>
                                    <td>
                                        <div class="usage-bar-container">
                                            <div class="usage-bar 
                                                 <c:choose>
                                                     <c:when test=" ${usagePercent>= 100}">usage-full
                                                     </c:when>
                                                     <c:when test="${usagePercent >= 75}">usage-high</c:when>
                                                     <c:when test="${usagePercent >= 50}">usage-medium</c:when>
                                                     <c:otherwise>usage-low</c:otherwise>
                                                 </c:choose>"
                                                 style="width: ${usagePercent > 100 ? 100 : usagePercent}%;">
                                            </div>
                                        </div>
                                        <span>${loc.currentUsage}/${loc.capacity}</span>
                                    </td>
                                    <td>
                                        <span class="status-badge 
                                              <c:choose>
                                                  <c:when test=" ${!loc.status}">status-inactive</c:when>
                                                  <c:when test="${loc.currentUsage >= loc.capacity}">status-full</c:when>
                                                  <c:otherwise>status-available</c:otherwise>
                                              </c:choose>">
                                            ${loc.availabilityStatus}
                                        </span>
                                    </td>
                                    <td>
                                        <a href="location-detail?id=${loc.locationId}" class="action-link">View</a>
                                        <c:if
                                            test="${sessionScope.currentUser.getRoleId() == 1 || sessionScope.currentUser.getRoleId() == 2}">
                                            <a href="edit-location?id=${loc.locationId}" class="action-link edit">Edit</a>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="10" style="text-align: center; padding: 40px; color: #999;">
                                    No locations found.
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>

            <c:if test="${totalPages > 1}">
                <div class="pagination">
                    <c:if test="${currentPage > 1}">
                        <a
                            href="location-list?page=${currentPage - 1}&keyword=${currentKeyword}&zone=${currentZone}&aisle=${currentAisle}&status=${currentStatus}&sortBy=${currentSortBy}&sortOrder=${currentSortOrder}">
                            &laquo; Prev
                        </a>
                    </c:if>

                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <c:if
                            test="${i == 1 || i == totalPages || (i >= currentPage - 2 && i <= currentPage + 2)}">
                            <a href="location-list?page=${i}&keyword=${currentKeyword}&zone=${currentZone}&aisle=${currentAisle}&status=${currentStatus}&sortBy=${currentSortBy}&sortOrder=${currentSortOrder}"
                               class="${currentPage == i ? 'active' : ''}">
                                ${i}
                            </a>
                        </c:if>
                        <c:if
                            test="${(i == 2 && currentPage > 4) || (i == totalPages - 1 && currentPage < totalPages - 3)}">
                            <span style="padding: 8px;">...</span>
                        </c:if>
                    </c:forEach>

                    <c:if test="${currentPage < totalPages}">
                        <a
                            href="location-list?page=${currentPage + 1}&keyword=${currentKeyword}&zone=${currentZone}&aisle=${currentAisle}&status=${currentStatus}&sortBy=${currentSortBy}&sortOrder=${currentSortOrder}">
                            Next &raquo;
                        </a>
                    </c:if>
                </div>
            </c:if>

            <br>
            <a href="<%= request.getContextPath()%>/landing" class="back-link">&larr; Back to homepage</a>
        </div>

        <jsp:include page="footer.jsp" />
    </body>

</html>