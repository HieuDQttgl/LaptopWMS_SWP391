<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

    <head>
        <title>Customers | Laptop WMS</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap"
              rel="stylesheet">
        <style>
            body {
                font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
                background: linear-gradient(135deg, #f0f4ff 0%, #f8fafc 50%, #f0fdf4 100%);
                margin: 0;
                padding: 0;
                min-height: 100vh;
            }

            .page-container {
                max-width: 1200px;
                margin: 2rem auto;
                padding: 2rem;
            }

            .page-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 2rem;
            }

            .page-title {
                display: flex;
                align-items: center;
                gap: 0.75rem;
                font-size: 1.75rem;
                font-weight: 700;
                color: #1e293b;
            }

            .btn-add {
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
                padding: 0.75rem 1.5rem;
                background: linear-gradient(135deg, #10b981 0%, #059669 100%);
                color: white;
                text-decoration: none;
                border-radius: 0.75rem;
                font-weight: 600;
                font-size: 0.875rem;
                transition: all 0.2s ease;
                box-shadow: 0 4px 14px rgba(16, 185, 129, 0.4);
            }

            .btn-add:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(16, 185, 129, 0.5);
                color: white;
            }

            .filter-bar {
                display: flex;
                flex-wrap: wrap;
                gap: 1rem;
                align-items: flex-end;
                padding: 1.25rem 1.5rem;
                background: white;
                border-radius: 1rem;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
                margin-bottom: 1.5rem;
                border: 1px solid #f1f5f9;
            }

            .filter-group {
                display: flex;
                flex-direction: column;
                gap: 0.375rem;
            }

            .filter-group label {
                font-size: 0.6875rem;
                font-weight: 600;
                color: #64748b;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .filter-group input,
            .filter-group select {
                padding: 0.625rem 1rem;
                font-size: 0.875rem;
                border: 2px solid #e2e8f0;
                border-radius: 0.5rem;
                background: white;
                outline: none;
                transition: all 0.2s ease;
                min-width: 200px;
            }

            .filter-group input:focus,
            .filter-group select:focus {
                border-color: #667eea;
                box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.15);
            }

            .btn-search {
                padding: 0.625rem 1.25rem;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                border: none;
                border-radius: 0.5rem;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.2s ease;
            }

            .btn-search:hover {
                transform: translateY(-1px);
                box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
            }

            .btn-clear {
                padding: 0.625rem 1.25rem;
                background: #ef4444;
                color: white;
                text-decoration: none;
                border-radius: 0.5rem;
                font-weight: 600;
                font-size: 0.875rem;
            }

            .btn-clear:hover {
                background: #dc2626;
                color: white;
            }

            .table-card {
                background: white;
                border-radius: 1rem;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
                overflow: hidden;
                border: 1px solid #f1f5f9;
            }

            table {
                width: 100%;
                border-collapse: collapse;
            }

            th {
                padding: 1rem 1.25rem;
                text-align: left;
                font-size: 0.6875rem;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                color: #64748b;
                background: linear-gradient(135deg, #f8fafc 0%, white 100%);
                border-bottom: 2px solid #e2e8f0;
            }

            td {
                padding: 1rem 1.25rem;
                font-size: 0.875rem;
                color: #475569;
                border-bottom: 1px solid #f1f5f9;
            }

            tbody tr {
                transition: all 0.2s ease;
                animation: fadeIn 0.3s ease-out backwards;
            }

            tbody tr:nth-child(1) {
                animation-delay: 0.02s;
            }

            tbody tr:nth-child(2) {
                animation-delay: 0.04s;
            }

            tbody tr:nth-child(3) {
                animation-delay: 0.06s;
            }

            tbody tr:nth-child(4) {
                animation-delay: 0.08s;
            }

            tbody tr:nth-child(5) {
                animation-delay: 0.1s;
            }

            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(10px);
                }

                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            tbody tr:hover {
                background: linear-gradient(135deg, #f8fafc 0%, #f0fdf4 100%);
            }

            .customer-name {
                font-weight: 600;
                color: #1e293b;
            }

            .contact-info {
                display: flex;
                flex-direction: column;
                gap: 0.125rem;
            }

            .contact-email {
                color: #64748b;
                font-size: 0.8125rem;
            }

            .contact-phone {
                color: #94a3b8;
                font-size: 0.75rem;
            }

            .status-badge {
                display: inline-flex;
                align-items: center;
                gap: 0.25rem;
                padding: 0.375rem 0.875rem;
                border-radius: 2rem;
                font-size: 0.6875rem;
                font-weight: 600;
                text-transform: uppercase;
            }

            .status-active {
                background: linear-gradient(135deg, #dcfce7 0%, #bbf7d0 100%);
                color: #16a34a;
            }

            .status-inactive {
                background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
                color: #dc2626;
            }

            .action-buttons {
                display: flex;
                gap: 0.5rem;
            }

            .btn-view {
                padding: 0.5rem 1rem;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                text-decoration: none;
                border-radius: 0.5rem;
                font-size: 0.75rem;
                font-weight: 600;
                transition: all 0.2s ease;
            }

            .btn-view:hover {
                transform: translateY(-1px);
                box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
                color: white;
            }

            .btn-block {
                padding: 0.5rem 1rem;
                background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
                color: white;
                text-decoration: none;
                border-radius: 0.5rem;
                font-size: 0.75rem;
                font-weight: 600;
                transition: all 0.2s ease;
            }

            .btn-block:hover {
                transform: translateY(-1px);
                box-shadow: 0 4px 12px rgba(239, 68, 68, 0.4);
                color: white;
            }

            .btn-unblock {
                padding: 0.5rem 1rem;
                background: linear-gradient(135deg, #10b981 0%, #059669 100%);
                color: white;
                text-decoration: none;
                border-radius: 0.5rem;
                font-size: 0.75rem;
                font-weight: 600;
                transition: all 0.2s ease;
            }

            .btn-unblock:hover {
                transform: translateY(-1px);
                box-shadow: 0 4px 12px rgba(16, 185, 129, 0.4);
                color: white;
            }

            .empty-state {
                text-align: center;
                padding: 4rem 2rem;
                color: #94a3b8;
            }

            .empty-state-icon {
                font-size: 4rem;
                margin-bottom: 1rem;
                opacity: 0.5;
            }

            .back-link {
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
                margin-top: 1.5rem;
                font-size: 0.875rem;
                color: #94a3b8;
                text-decoration: none;
            }

            .back-link:hover {
                color: #64748b;
            }
            /* Pagination */
            .pagination {
                display: flex;
                justify-content: center;
                gap: 0.5rem;
                margin-top: 2rem;
                padding: 1rem;
            }

            .pagination a {
                display: flex;
                align-items: center;
                justify-content: center;
                min-width: 40px;
                height: 40px;
                padding: 0 0.75rem;
                font-size: 0.875rem;
                font-weight: 600;
                color: #475569;
                background: white;
                border: 1px solid #e2e8f0;
                border-radius: 0.5rem;
                text-decoration: none;
                transition: all 0.2s ease;
            }

            .pagination a:hover {
                background: #f1f5f9;
                border-color: #cbd5e1;
            }

            .pagination a.active {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                border-color: transparent;
                box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
            }

            @media (max-width: 768px) {
                .page-container {
                    padding: 1rem;
                    margin: 1rem;
                }

                .page-header {
                    flex-direction: column;
                    gap: 1rem;
                    align-items: flex-start;
                }

                .filter-bar {
                    flex-direction: column;
                }

                .filter-group {
                    width: 100%;
                }

                .filter-group input,
                .filter-group select {
                    width: 100%;
                }

                .table-card {
                    overflow-x: auto;
                }
            }
        </style>
    </head>

    <body>
        <jsp:include page="header.jsp" />

        <div class="page-container">
            <div class="page-header">
                <h1 class="page-title">🛒 Customer Management</h1>
                <a href="add-customer" class="btn-add">+ Add New Customer</a>
            </div>

            <div class="filter-bar">
                <form action="customer-list" method="get" style="display: contents;">
                    <div class="filter-group">
                        <label>Search</label>
                        <input type="text" name="keyword" placeholder="Customer name..." value="${param.keyword}">
                    </div>
                    <div class="filter-group">
                        <label>Status</label>
                        <select name="status" onchange="this.form.submit()">
                            <option value="all" ${param.status=='all' ? 'selected' : '' }>All Status</option>
                            <option value="active" ${param.status=='active' ? 'selected' : '' }>Active</option>
                            <option value="inactive" ${param.status=='inactive' ? 'selected' : '' }>Inactive
                            </option>
                        </select>
                    </div>
                    <button type="submit" class="btn-search">🔍 Search</button>
                    <a href="customer-list" class="btn-clear">✕ Clear</a>
                </form>
            </div>

            <div class="table-card">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Customer Name</th>
                            <th>Contact</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty customerList}">
                                <c:forEach items="${customerList}" var="c">
                                    <tr>
                                        <td><strong>#${c.partnerId}</strong></td>
                                        <td><span class="customer-name">${c.partnerName}</span></td>
                                        <td>
                                            <div class="contact-info">
                                                <span class="contact-email">📧 ${c.partnerEmail}</span>
                                                <span class="contact-phone">📱 ${c.partnerPhone}</span>
                                            </div>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${c.status == 'active'}">
                                                    <span class="status-badge status-active">● Active</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="status-badge status-inactive">● Inactive</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="action-buttons">
                                            <a href="customer-detail?id=${c.partnerId}" class="btn-view">View</a>
                                            <c:choose>
                                                <c:when test="${c.status == 'active'}">
                                                    <a href="javascript:void(0)" class="btn-block"
                                                       onclick="confirmStatusChange('change-status?id=${c.partnerId}&status=active', 'this customer', true)">Block</a>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="javascript:void(0)" class="btn-unblock"
                                                       onclick="confirmStatusChange('change-status?id=${c.partnerId}&status=inactive', 'this customer', false)">Unblock</a>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="5">
                                        <div class="empty-state">
                                            <div class="empty-state-icon">👥</div>
                                            <div>No customers found.</div>
                                        </div>
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
            <!-- Pagination -->
            <c:if test="${totalPages > 1}">
                <div class="pagination">
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <a href="customer-list?page=${i}&keyword=${currentKeyword}&status=${currentStatus}"
                           class="${currentPage == i ? 'active' : ''}">
                            ${i}
                        </a>
                    </c:forEach>
                </div>
            </c:if>
            <a href="<%= request.getContextPath()%>/dashboard" class="back-link">← Back to Dashboard</a>
        </div>

        <%@include file="common-dialogs.jsp" %>
        <jsp:include page="footer.jsp" />
    </body>

</html>