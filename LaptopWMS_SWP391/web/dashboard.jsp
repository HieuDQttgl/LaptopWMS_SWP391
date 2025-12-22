<%-- Document : dashboard Created on : Dec 18, 2025, 9:59:24 AM Author : super --%>

    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

            <!DOCTYPE html>
            <html>

            <head>
                <title>Dashboard | Laptop WMS</title>
                <style>
                    body {
                        font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
                        background: linear-gradient(135deg, #f0f4ff 0%, #f8fafc 50%, #f0fdf4 100%);
                        padding: 0;
                        margin: 0;
                        min-height: 100vh;
                    }

                    .dashboard-container {
                        max-width: 1400px;
                        margin: 0 auto;
                        padding: 2rem;
                    }

                    /* Welcome Banner */
                    .welcome-banner {
                        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                        border-radius: 1.5rem;
                        padding: 2.5rem;
                        margin-bottom: 2rem;
                        color: white;
                        position: relative;
                        overflow: hidden;
                        box-shadow: 0 20px 40px rgba(102, 126, 234, 0.3);
                        animation: fadeInUp 0.5s ease-out;
                    }

                    .welcome-banner::before {
                        content: '';
                        position: absolute;
                        top: -50%;
                        right: -10%;
                        width: 400px;
                        height: 400px;
                        background: rgba(255, 255, 255, 0.1);
                        border-radius: 50%;
                    }

                    .welcome-banner::after {
                        content: '';
                        position: absolute;
                        bottom: -30%;
                        left: 10%;
                        width: 200px;
                        height: 200px;
                        background: rgba(255, 255, 255, 0.08);
                        border-radius: 50%;
                    }

                    .welcome-banner h1 {
                        font-size: 2rem;
                        font-weight: 700;
                        margin: 0 0 0.5rem 0;
                        position: relative;
                        z-index: 1;
                    }

                    .welcome-banner .role-badge {
                        display: inline-flex;
                        align-items: center;
                        gap: 0.5rem;
                        padding: 0.375rem 1rem;
                        background: rgba(255, 255, 255, 0.2);
                        border-radius: 2rem;
                        font-size: 0.875rem;
                        font-weight: 500;
                        position: relative;
                        z-index: 1;
                        backdrop-filter: blur(10px);
                    }

                    /* Team Updates Section */
                    .team-section {
                        margin-top: 2rem;
                        padding-top: 1.5rem;
                        border-top: 1px solid rgba(255, 255, 255, 0.2);
                        position: relative;
                        z-index: 1;
                    }

                    .team-section-header {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        margin-bottom: 1rem;
                    }

                    .team-section-header h3 {
                        font-size: 1rem;
                        font-weight: 600;
                        margin: 0;
                        display: flex;
                        align-items: center;
                        gap: 0.5rem;
                    }

                    .team-section-header a {
                        font-size: 0.8125rem;
                        color: rgba(255, 255, 255, 0.8);
                        text-decoration: none;
                        font-weight: 500;
                    }

                    .team-section-header a:hover {
                        color: white;
                    }

                    .announcement-item {
                        background: rgba(255, 255, 255, 0.1);
                        backdrop-filter: blur(10px);
                        border-radius: 0.75rem;
                        padding: 0.875rem 1rem;
                        margin-bottom: 0.75rem;
                        transition: all 0.2s ease;
                    }

                    .announcement-item:hover {
                        background: rgba(255, 255, 255, 0.15);
                        transform: translateX(4px);
                    }

                    .announcement-meta {
                        font-size: 0.6875rem;
                        color: rgba(255, 255, 255, 0.6);
                        margin-bottom: 0.25rem;
                    }

                    .announcement-meta strong {
                        color: rgba(255, 255, 255, 0.9);
                    }

                    .announcement-content {
                        font-size: 0.8125rem;
                        color: rgba(255, 255, 255, 0.85);
                        line-height: 1.4;
                        overflow: hidden;
                        white-space: nowrap;
                        text-overflow: ellipsis;
                    }

                    .quick-post {
                        display: flex;
                        gap: 0.5rem;
                        margin-top: 1rem;
                    }

                    .quick-post input {
                        flex: 1;
                        padding: 0.625rem 1rem;
                        border: none;
                        border-radius: 0.5rem;
                        background: rgba(255, 255, 255, 0.2);
                        color: white;
                        font-size: 0.8125rem;
                        outline: none;
                        backdrop-filter: blur(10px);
                    }

                    .quick-post input::placeholder {
                        color: rgba(255, 255, 255, 0.5);
                    }

                    .quick-post button {
                        padding: 0.625rem 1.25rem;
                        border: none;
                        border-radius: 0.5rem;
                        background: white;
                        color: #667eea;
                        font-size: 0.8125rem;
                        font-weight: 600;
                        cursor: pointer;
                        transition: all 0.2s ease;
                    }

                    .quick-post button:hover {
                        transform: translateY(-1px);
                        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
                    }

                    /* Widget Grid */
                    .widget-grid {
                        display: grid;
                        grid-template-columns: repeat(auto-fit, minmax(360px, 1fr));
                        gap: 1.5rem;
                    }

                    .widget {
                        background: white;
                        border-radius: 1rem;
                        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
                        border: 1px solid #f1f5f9;
                        overflow: hidden;
                        animation: fadeInUp 0.4s ease-out backwards;
                    }

                    .widget:nth-child(1) {
                        animation-delay: 0.1s;
                    }

                    .widget:nth-child(2) {
                        animation-delay: 0.15s;
                    }

                    .widget:nth-child(3) {
                        animation-delay: 0.2s;
                    }

                    .widget-header {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        padding: 1.25rem 1.5rem;
                        border-bottom: 1px solid #f1f5f9;
                        background: linear-gradient(135deg, #f8fafc 0%, white 100%);
                    }

                    .widget-title {
                        font-size: 1rem;
                        font-weight: 600;
                        color: #1e293b;
                        display: flex;
                        align-items: center;
                        gap: 0.5rem;
                    }

                    .widget-badge {
                        font-size: 0.6875rem;
                        padding: 0.25rem 0.625rem;
                        border-radius: 1rem;
                        font-weight: 600;
                    }

                    .widget-badge.success {
                        background: #dcfce7;
                        color: #16a34a;
                    }

                    .widget-badge.warning {
                        background: #fef3c7;
                        color: #d97706;
                    }

                    .widget-badge.danger {
                        background: #fee2e2;
                        color: #dc2626;
                    }

                    .widget-badge.info {
                        background: #dbeafe;
                        color: #2563eb;
                    }

                    .widget-body {
                        padding: 1rem 1.5rem 1.5rem;
                    }

                    .widget-link {
                        font-size: 0.75rem;
                        color: #3b82f6;
                        text-decoration: none;
                        font-weight: 500;
                    }

                    .widget-link:hover {
                        color: #1d4ed8;
                    }

                    /* List Items */
                    .list-item {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        padding: 1rem 0;
                        border-bottom: 1px solid #f8fafc;
                        transition: all 0.2s ease;
                    }

                    .list-item:last-child {
                        border-bottom: none;
                    }

                    .list-item:hover {
                        padding-left: 0.5rem;
                    }

                    .list-item-info {
                        flex: 1;
                    }

                    .list-item-main {
                        font-weight: 600;
                        color: #334155;
                        font-size: 0.875rem;
                        margin-bottom: 0.125rem;
                    }

                    .list-item-sub {
                        font-size: 0.75rem;
                        color: #94a3b8;
                    }

                    /* Status Badges */
                    .status-badge {
                        display: inline-flex;
                        align-items: center;
                        gap: 0.25rem;
                        padding: 0.25rem 0.75rem;
                        border-radius: 2rem;
                        font-size: 0.6875rem;
                        font-weight: 600;
                        text-transform: uppercase;
                        letter-spacing: 0.5px;
                    }

                    .badge-success {
                        background: #dcfce7;
                        color: #16a34a;
                    }

                    .badge-warning {
                        background: #fef3c7;
                        color: #d97706;
                    }

                    .badge-danger {
                        background: #fee2e2;
                        color: #dc2626;
                    }

                    .badge-info {
                        background: #dbeafe;
                        color: #2563eb;
                    }

                    /* Quantity Badge */
                    .quantity-badge {
                        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                        color: white;
                        padding: 0.25rem 0.625rem;
                        border-radius: 1rem;
                        font-size: 0.75rem;
                        font-weight: 600;
                    }

                    /* Action Button */
                    .btn-action {
                        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                        color: white;
                        text-decoration: none;
                        padding: 0.5rem 1rem;
                        border-radius: 0.5rem;
                        font-size: 0.75rem;
                        font-weight: 600;
                        transition: all 0.2s ease;
                        display: inline-flex;
                        align-items: center;
                        gap: 0.375rem;
                    }

                    .btn-action:hover {
                        transform: translateY(-1px);
                        box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
                        color: white;
                    }

                    /* Empty State */
                    .empty-state {
                        text-align: center;
                        padding: 2rem 1rem;
                        color: #94a3b8;
                    }

                    .empty-state-icon {
                        font-size: 2.5rem;
                        margin-bottom: 0.75rem;
                        opacity: 0.5;
                    }

                    .empty-state-text {
                        font-size: 0.875rem;
                        font-weight: 500;
                        color: #64748b;
                    }

                    .empty-state-sub {
                        font-size: 0.75rem;
                        color: #94a3b8;
                        margin-top: 0.25rem;
                    }

                    /* Tables */
                    .mini-table {
                        width: 100%;
                        border-collapse: collapse;
                        font-size: 0.8125rem;
                    }

                    .mini-table th {
                        text-align: left;
                        padding: 0.75rem;
                        color: #64748b;
                        font-weight: 500;
                        font-size: 0.6875rem;
                        text-transform: uppercase;
                        letter-spacing: 0.5px;
                        border-bottom: 1px solid #f1f5f9;
                    }

                    .mini-table td {
                        padding: 0.875rem 0.75rem;
                        border-bottom: 1px solid #f8fafc;
                        color: #475569;
                    }

                    .mini-table tr:hover {
                        background: #f8fafc;
                    }

                    .mini-table .user-info strong {
                        color: #1e293b;
                        display: block;
                    }

                    .mini-table .user-info span {
                        font-size: 0.6875rem;
                        color: #94a3b8;
                    }

                    /* Animations */
                    @keyframes fadeInUp {
                        from {
                            opacity: 0;
                            transform: translateY(20px);
                        }

                        to {
                            opacity: 1;
                            transform: translateY(0);
                        }
                    }

                    /* Responsive */
                    @media (max-width: 768px) {
                        .dashboard-container {
                            padding: 1rem;
                        }

                        .welcome-banner {
                            padding: 1.5rem;
                        }

                        .welcome-banner h1 {
                            font-size: 1.5rem;
                        }

                        .widget-grid {
                            grid-template-columns: 1fr;
                        }
                    }
                </style>
            </head>

            <body>
                <jsp:include page="header.jsp" />

                <div class="dashboard-container">
                    <!-- Welcome Banner -->
                    <div class="welcome-banner">
                        <h1>👋 Welcome back, ${currentUser != null ? currentUser.fullName : 'Guest'}</h1>
                        <div class="role-badge">
                            <c:choose>
                                <c:when test="${currentUser.roleId == 1}">⚙️ Administrator</c:when>
                                <c:when test="${currentUser.roleId == 2}">💼 Sales Staff</c:when>
                                <c:when test="${currentUser.roleId == 3}">📦 Warehouse Keeper</c:when>
                                <c:otherwise>👤 User</c:otherwise>
                            </c:choose>
                        </div>

                        <!-- Team Updates Section -->
                        <div class="team-section">
                            <div class="team-section-header">
                                <h3>📌 Team Updates</h3>
                                <a href="team-board">View Board →</a>
                            </div>

                            <c:forEach var="a" items="${announcementList}">
                                <div class="announcement-item">
                                    <div class="announcement-meta">
                                        <strong>${a.senderName}</strong> • ${a.formattedDate}
                                    </div>
                                    <div class="announcement-content">${a.content}</div>
                                </div>
                            </c:forEach>

                            <c:if test="${empty announcementList}">
                                <div style="text-align: center; padding: 1rem; color: rgba(255,255,255,0.6);">
                                    No team updates yet.
                                </div>
                            </c:if>

                            <form action="add-announcement" method="POST" class="quick-post">
                                <input type="text" name="content" placeholder="Share a quick update with your team...">
                                <button type="submit">Post</button>
                            </form>
                        </div>
                    </div>

                    <!-- Widget Grid -->
                    <div class="widget-grid">

                        <%--==================ROLE: SALES STAFF (ID 2)==================--%>
                            <c:if test="${currentUser.roleId == 2}">

                                <div class="widget">
                                    <div class="widget-header">
                                        <span class="widget-title">📊 High Availability</span>
                                        <span class="widget-badge success">Ready to Sell</span>
                                    </div>
                                    <div class="widget-body">
                                        <c:forEach var="p" items="${topProducts}">
                                            <div class="list-item">
                                                <div class="list-item-info">
                                                    <div class="list-item-main">${p.cpu}</div>
                                                    <div class="list-item-sub">${p.ram}</div>
                                                </div>
                                                <span class="status-badge badge-success">${p.quantity} Units</span>
                                            </div>
                                        </c:forEach>
                                        <c:if test="${empty topProducts}">
                                            <div class="empty-state">
                                                <div class="empty-state-icon">📦</div>
                                                <div class="empty-state-text">No products available</div>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>

                                <div class="widget">
                                    <div class="widget-header">
                                        <span class="widget-title">🎫 My Recent Tickets</span>
                                        <a href="ticket-list" class="widget-link">View All →</a>
                                    </div>
                                    <div class="widget-body">
                                        <c:forEach var="t" items="${myTickets}">
                                            <div class="list-item">
                                                <div class="list-item-info">
                                                    <div class="list-item-main">${t.ticketCode}</div>
                                                    <div class="list-item-sub">${t.title}</div>
                                                </div>
                                                <c:choose>
                                                    <c:when test="${t.status == 'COMPLETED'}">
                                                        <span class="status-badge badge-success">✓ Completed</span>
                                                    </c:when>
                                                    <c:when test="${t.status == 'REJECTED'}">
                                                        <span class="status-badge badge-danger">✗ Rejected</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="status-badge badge-warning">⏳ Pending</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </c:forEach>
                                        <c:if test="${empty myTickets}">
                                            <div class="empty-state">
                                                <div class="empty-state-icon">📭</div>
                                                <div class="empty-state-text">No tickets yet</div>
                                                <div class="empty-state-sub">Create your first ticket to get started
                                                </div>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>

                                <div class="widget">
                                    <div class="widget-header">
                                        <span class="widget-title">⚠️ Low Stock Alert</span>
                                        <span class="widget-badge danger">Needs Attention</span>
                                    </div>
                                    <div class="widget-body">
                                        <c:forEach var="p" items="${lowStock}">
                                            <div class="list-item">
                                                <div class="list-item-info">
                                                    <div class="list-item-main">${p.cpu}</div>
                                                    <div class="list-item-sub">Restock needed</div>
                                                </div>
                                                <span class="status-badge badge-danger">${p.quantity} Left</span>
                                            </div>
                                        </c:forEach>
                                        <c:if test="${empty lowStock}">
                                            <div class="empty-state">
                                                <div class="empty-state-icon">✅</div>
                                                <div class="empty-state-text">Healthy Inventory</div>
                                                <div class="empty-state-sub">All products have sufficient stock</div>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>

                            </c:if>

                            <%--==================ROLE: KEEPER (ID 3)==================--%>
                                <c:if test="${currentUser.roleId == 3}">

                                    <div class="widget">
                                        <div class="widget-header">
                                            <span class="widget-title">📋 Work Queue</span>
                                            <span class="widget-badge warning">Pending Action</span>
                                        </div>
                                        <div class="widget-body">
                                            <c:forEach var="t" items="${pendingTickets}">
                                                <div class="list-item">
                                                    <div class="list-item-info">
                                                        <div class="list-item-main">${t.ticketCode}</div>
                                                        <div class="list-item-sub">${t.type} Request</div>
                                                    </div>
                                                    <a href="ticket-detail?id=${t.ticketId}" class="btn-action">
                                                        ⚡ Process
                                                    </a>
                                                </div>
                                            </c:forEach>
                                            <c:if test="${empty pendingTickets}">
                                                <div class="empty-state">
                                                    <div class="empty-state-icon">🎉</div>
                                                    <div class="empty-state-text">All caught up!</div>
                                                    <div class="empty-state-sub">No pending tickets to process</div>
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>

                                    <div class="widget">
                                        <div class="widget-header">
                                            <span class="widget-title">⚠️ Low Stock Alert</span>
                                        </div>
                                        <div class="widget-body">
                                            <c:forEach var="p" items="${lowStock}">
                                                <div class="list-item">
                                                    <div class="list-item-info">
                                                        <div class="list-item-main">${p.cpu}</div>
                                                        <div class="list-item-sub">Restock needed</div>
                                                    </div>
                                                    <span class="status-badge badge-danger">${p.quantity} Left</span>
                                                </div>
                                            </c:forEach>
                                            <c:if test="${empty lowStock}">
                                                <div class="empty-state">
                                                    <div class="empty-state-icon">✅</div>
                                                    <div class="empty-state-text">Healthy Inventory</div>
                                                    <div class="empty-state-sub">All products have sufficient stock
                                                    </div>
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>

                                    <div class="widget">
                                        <div class="widget-header">
                                            <span class="widget-title">📜 My History</span>
                                            <span class="widget-badge info">Recently Completed</span>
                                        </div>
                                        <div class="widget-body">
                                            <c:forEach var="t" items="${keeperHistory}">
                                                <div class="list-item">
                                                    <div class="list-item-info">
                                                        <div class="list-item-main"
                                                            style="color: #94a3b8; text-decoration: line-through;">
                                                            ${t.ticketCode}
                                                        </div>
                                                        <div class="list-item-sub">${t.title}</div>
                                                    </div>
                                                    <c:choose>
                                                        <c:when test="${t.status == 'COMPLETED'}">
                                                            <span class="status-badge badge-success">Completed</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="status-badge badge-danger">Rejected</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </c:forEach>
                                            <c:if test="${empty keeperHistory}">
                                                <div class="empty-state">
                                                    <div class="empty-state-icon">📋</div>
                                                    <div class="empty-state-text">No history yet</div>
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>

                                </c:if>

                                <%--==================ROLE: ADMIN (ID 1)==================--%>
                                    <c:if test="${currentUser.roleId == 1}">

                                        <div class="widget" style="grid-column: span 2;">
                                            <div class="widget-header">
                                                <span class="widget-title">👥 Newest Users</span>
                                                <a href="user-list" class="widget-link">Manage Users →</a>
                                            </div>
                                            <div class="widget-body">
                                                <table class="mini-table">
                                                    <thead>
                                                        <tr>
                                                            <th>User</th>
                                                            <th>Role</th>
                                                            <th>Status</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach var="u" items="${userList}">
                                                            <tr>
                                                                <td class="user-info">
                                                                    <strong>${u.username}</strong>
                                                                    <span>${u.email}</span>
                                                                </td>
                                                                <td><span
                                                                        class="status-badge badge-info">${u.roleName}</span>
                                                                </td>
                                                                <td>
                                                                    <span
                                                                        class="status-badge ${u.status == 'active' ? 'badge-success' : 'badge-danger'}">
                                                                        ${u.status}
                                                                    </span>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>

                                        <div class="widget">
                                            <div class="widget-header">
                                                <span class="widget-title">🔐 System Roles</span>
                                            </div>
                                            <div class="widget-body">
                                                <c:forEach var="r" items="${roleList}">
                                                    <div class="list-item">
                                                        <div class="list-item-info">
                                                            <div class="list-item-main">${r.roleName}</div>
                                                            <div class="list-item-sub">${r.roleDescription}</div>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </div>

                                    </c:if>

                    </div>
                </div>

                <jsp:include page="footer.jsp" />
            </body>

            </html>