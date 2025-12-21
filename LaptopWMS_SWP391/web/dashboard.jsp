<%-- Document : dashboard Created on : Dec 18, 2025, 9:59:24 AM Author : super --%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

    <head>
        <title>Dashboard | Laptop WMS</title>
        <style>
            body {
                font-family: "Segoe UI", sans-serif;
                background: #f5f6fa;
                padding: 0;
                margin: 0;
                min-height: 100vh;
            }

            .welcome-banner {
                background: white;
                padding: 20px;
                border-radius: 8px;
                margin-bottom: 20px;
                margin-top: 40px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
            }

            h1 {
                margin: 0;
                color: #2c3e50;
                font-size: 24px;
            }

            .dash-container {
                display: flex;
                gap: 20px;
                flex-wrap: wrap;
            }

            .widget {
                flex: 1;
                min-width: 300px;
                background: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
            }

            .widget h3 {
                margin-top: 0;
                border-bottom: 2px solid #f0f0f0;
                padding-bottom: 10px;
                color: #34495e;
                font-size: 18px;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .list-item {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 12px 0;
                border-bottom: 1px solid #f9f9f9;
            }

            .list-item:last-child {
                border-bottom: none;
            }

            .item-main {
                font-weight: 600;
                color: #333;
                display: block;
            }

            .item-sub {
                display: block;
                font-size: 12px;
                color: #7f8c8d;
                margin-top: 2px;
            }

            .badge {
                padding: 4px 8px;
                border-radius: 4px;
                font-size: 12px;
                font-weight: bold;
            }

            .badge-green {
                background: #e8f8f5;
                color: #27ae60;
            }

            .badge-orange {
                background: #fef5e7;
                color: #e67e22;
            }

            .badge-red {
                background: #fdedec;
                color: #c0392b;
            }

            .badge-blue {
                background: #ebf5fb;
                color: #3498db;
            }

            .btn-action {
                background: #3498db;
                color: white;
                text-decoration: none;
                padding: 6px 12px;
                border-radius: 4px;
                font-size: 12px;
                font-weight: 600;
                transition: background 0.2s;
            }

            .btn-action:hover {
                background: #2980b9;
            }

            .btn-purple {
                background: #8e44ad;
            }

            .btn-purple:hover {
                background: #71368a;
            }
        </style>
    </head>

    <body>

        <jsp:include page="header.jsp" />

        <div class="welcome-banner">
            <h1>Welcome back, ${currentUser != null ? currentUser.fullName : 'Guest'}</h1>
            <p style="color: #7f8c8d; margin: 5px 0 0;">
                Role:
                <c:choose>
                    <c:when test="${currentUser.roleId == 1}">Administrator</c:when>
                    <c:when test="${currentUser.roleId == 2}">Sales Staff</c:when>
                    <c:when test="${currentUser.roleId == 3}">Warehouse Keeper</c:when>
                    <c:otherwise>User</c:otherwise>
                </c:choose>
            </p>

            <h3 style="margin-top: 40px;">
                Team Updates
                <a href="team-board"
                   style="font-size:16px; float:right; text-decoration: none; color: black;">View Board
                    &rarr;</a>
            </h3>

            <div style="min-height: 100px;">
                <c:forEach var="a" items="${announcementList}">
                    <div style="margin-bottom: 10px; border-bottom: 1px solid #f0f0f0; padding-bottom: 5px;">
                        <div style="font-size: 11px; color: #999;">
                            <strong>${a.senderName}</strong> • ${a.formattedDate}
                        </div>
                        <div
                            style="font-size: 13px; color: #444; overflow: hidden; white-space: nowrap; text-overflow: ellipsis;">
                            ${a.content}
                        </div>
                    </div>
                </c:forEach>
                <c:if test="${empty announcementList}">
                    <p style="color:#ccc; text-align:center;">No updates.</p>
                </c:if>
            </div>

            <div style="text-align: center; margin-top: 10px;">
                <form action="add-announcement" method="POST" style="display:flex; gap:5px;">
                    <input type="text" name="content" placeholder="Quick post..."
                           style="flex:1; padding:5px; font-size:12px;">
                    <button type="submit" class="btn-action">Post</button>
                </form>
            </div>
        </div>

        <div class="dash-container">

            <%--==================ROLE: SALES STAFF (ID 2)==================--%>
            <c:if test="${currentUser.roleId == 2}">

                <div class="widget">
                    <h3>High Availability <span style="font-size:12px; color:#27ae60">Ready to Sell</span>
                    </h3>
                    <c:forEach var="p" items="${topProducts}">
                        <div class="list-item">
                            <div>
                                <span class="item-main">${p.cpu}</span>
                                <span class="item-sub">${p.ram}</span>
                            </div>
                            <span class="badge badge-green">${p.quantity} Units</span>
                        </div>
                    </c:forEach>
                </div>

                <div class="widget">
                    <h3>My Recent Tickets <a href="ticket-list"
                                             style="font-size:12px; text-decoration: none;">View All</a></h3>
                        <%-- FIXED: Iterate 'myTickets' , use Ticket properties --%>
                        <c:forEach var="t" items="${myTickets}">
                        <div class="list-item">
                            <div>
                                <span class="item-main">${t.ticketCode}</span>
                                <span class="item-sub">${t.title}</span>
                            </div>
                            <c:choose>
                                <c:when test="${t.status == 'COMPLETED'}">
                                    <span class="badge badge-green">COMPLETED</span>
                                </c:when>
                                <c:when test="${t.status == 'REJECTED'}">
                                    <span class="badge badge-red">REJECTED</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge badge-orange"
                                          style="background:#fff3e0; color:#e67e22;">PENDING</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </c:forEach>
                    <c:if test="${empty myTickets}">
                        <div style="text-align: center; padding: 30px 10px; color: #95a5a6;">
                            <strong>No history yet.</strong><br>
                            You haven't created any tickets recently.
                        </div>
                    </c:if>
                </div>

                <div class="widget">
                    <h3>Low Stock Alert</h3>
                    <c:forEach var="p" items="${lowStock}">
                        <div class="list-item">
                            <div>
                                <span class="item-main">${p.cpu}</span>
                                <span class="item-sub">Restock needed</span>
                            </div>
                            <span class="badge badge-red">${p.quantity} Left</span>
                        </div>
                    </c:forEach>
                </div>
            </c:if>

            <%--==================ROLE: KEEPER (ID 3)==================--%>
            <c:if test="${currentUser.roleId == 3}">

                <div class="widget">
                    <h3>Work Queue <span class="badge badge-orange">Pending Action</span></h3>
                    <%-- FIXED: Iterate 'pendingTickets' --%>
                    <c:forEach var="t" items="${pendingTickets}">
                        <div class="list-item">
                            <div>
                                <span class="item-main">${t.ticketCode}</span>
                                <span class="item-sub">
                                    ${t.type} Request
                                </span>
                            </div>
                            <a href="ticket-detail?id=${t.ticketId}" class="btn-action">Process</a>
                        </div>
                    </c:forEach>
                    <c:if test="${empty pendingTickets}">
                        <p style="color:#999; text-align:center; padding:10px;">No pending tickets.
                        </p>
                    </c:if>
                </div>

                <div class="widget">
                    <h3>Low Stock Alert</h3>
                    <c:forEach var="p" items="${lowStock}">
                        <div class="list-item">
                            <div>
                                <span class="item-main">${p.cpu}</span>
                                <span class="item-sub">Restock needed</span>
                            </div>
                            <span class="badge badge-red">${p.quantity} Left</span>
                        </div>
                    </c:forEach>
                    <c:if test="${empty lowStock}">
                        <div style="text-align: center; padding: 30px 10px; color: #95a5a6;">
                            <div style="font-size: 24px; margin-bottom: 5px;">✅</div>
                            <strong>Healthy Inventory</strong><br>
                            All products have sufficient stock.
                        </div>
                    </c:if>
                </div>

                <div class="widget">
                    <h3>My History <span style="font-size:12px; color:#7f8c8d">Recently Completed</span>
                    </h3>

                    <c:forEach var="t" items="${keeperHistory}">
                        <div class="list-item">
                            <div>
                                <span class="item-main"
                                      style="color: #7f8c8d; text-decoration: line-through;">
                                    ${t.ticketCode}
                                </span>
                                <span class="item-sub">${t.title}</span>
                            </div>
                            <c:choose>
                                <c:when test="${t.status == 'COMPLETED'}">
                                    <span class="badge badge-green">Completed</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge badge-red">Rejected</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </c:forEach>

                    <%-- Empty State --%>
                    <c:if test="${empty keeperHistory}">
                        <div style="text-align: center; padding: 20px; color: #ccc;">
                            No recent history.
                        </div>
                    </c:if>
                </div>
            </c:if>

            <%--==================ROLE: ADMIN (ID 1)==================--%>
            <c:if test="${currentUser.roleId == 1}">

                <div class="widget" style="flex: 2;">
                    <h3>Newest Users <a href="user-list"
                                        style="font-size:12px; text-decoration: none;">Manage Users</a></h3>
                    <table style="width: 100%; border-collapse: collapse; font-size: 13px;">
                        <thead>
                            <tr
                                style="text-align: left; color: #7f8c8d; border-bottom: 1px solid #eee;">
                                <th style="padding: 8px;">User</th>
                                <th style="padding: 8px;">Role</th>
                                <th style="padding: 8px;">Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="u" items="${userList}">
                                <tr style="border-bottom: 1px solid #f9f9f9;">
                                    <td style="padding: 8px;">
                                        <strong style="color:#333;">${u.username}</strong><br>
                                        <span
                                            style="color: #999; font-size: 11px;">${u.email}</span>
                                    </td>
                                    <td style="padding: 8px;"><span
                                            class="badge badge-blue">${u.roleName}</span></td>
                                    <td style="padding: 8px;">
                                        <span
                                            style="color: ${u.status == 'active' ? '#27ae60' : '#c0392b'}; font-weight: bold;">
                                            ${u.status}
                                        </span>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <div class="widget" style="flex: 1;">
                    <h3>System Roles</h3>
                    <table style="width: 100%; border-collapse: collapse; font-size: 13px;">
                        <thead>
                            <tr
                                style="text-align: left; color: #7f8c8d; border-bottom: 1px solid #eee;">
                                <th style="padding: 8px;">Role Name</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="r" items="${roleList}">
                                <tr style="border-bottom: 1px solid #f9f9f9;">
                                    <td style="padding: 10px 8px;">${r.roleName}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>

        </div>

        <jsp:include page="footer.jsp" />
    </body>

</html>