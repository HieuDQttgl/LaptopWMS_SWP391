<%-- 
    Document   : dashboard
    Created on : Dec 18, 2025, 9:59:24 AM
    Author     : super
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                marginL: 0;
            }

            .welcome-banner {
                background: white;
                padding: 20px;
                border-radius: 8px;
                margin-bottom: 20px;
                margin-top: 40px;
                box-shadow: 0 2px 5px rgba(0,0,0,0.05);
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
                box-shadow: 0 4px 10px rgba(0,0,0,0.05);
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
        </div>

        <div class="dash-container">

            <c:if test="${currentUser.roleId == 2}">

                <div class="widget">
                    <h3>High Availability <span style="font-size:12px; color:#27ae60">Ready to Sell</span></h3>
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
                    <h3>My Recent Orders <a href="order-list" style="font-size:12px; text-decoration: none;">View All</a></h3>
                    <c:forEach var="o" items="${myOrders}">
                        <div class="list-item">
                            <div>
                                <span class="item-main">${o.orderCode}</span>
                                <span class="item-sub">${o.supplierId > 0 ? 'Import' : 'Export'} - ID: ${o.orderId}</span>
                            </div>

                            <c:choose>
                                <c:when test="${o.supplierId > 0}">
                                    <c:choose>
                                        <c:when test="${o.orderStatus == 'pending' || o.orderStatus == 'approved'}">
                                            <a href="order-status?orderId=${o.orderId}" class="btn-action">Manage Import</a>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-orange">${o.orderStatus}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </c:when>

                                <c:otherwise>
                                    <c:choose>
                                        <c:when test="${o.orderStatus == 'pending' || o.orderStatus == 'approved'}">
                                            <span class="badge badge-orange" style="background:#fff3e0; color:#e67e22; border:1px solid #e67e22">Waiting for Warehouse</span>
                                        </c:when>
                                        <c:when test="${o.orderStatus == 'shipping'}">
                                            <a href="order-status?orderId=${o.orderId}" class="btn-action">Confirm Delivery</a>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-green">${o.orderStatus}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </c:forEach>
                </div>

                <div class="widget">
                    <h3>New Arrivals</h3>
                    <c:forEach var="i" items="${newArrivals}">
                        <div class="list-item">
                            <div>
                                <span class="item-main">${i.itemNote}</span> 
                                <span class="item-sub">SN: ${i.serialNumber}</span>
                            </div>
                            <span class="badge badge-blue">New</span>
                        </div>
                    </c:forEach>
                </div>
            </c:if>

            <c:if test="${currentUser.roleId == 3}">

                <div class="widget">
                    <h3>Work Queue <span class="badge badge-orange">${pendingOrders.size()} Active</span></h3>
                    <c:forEach var="o" items="${pendingOrders}">
                        <div class="list-item">
                            <div>
                                <span class="item-main">${o.orderCode}</span>
                                <span class="item-sub">
                                    ${o.supplierId > 0 ? 'Import Request' : 'Export Request'}
                                </span>
                            </div>

                            <c:choose>
                                <c:when test="${o.supplierId > 0}">
                                    <c:if test="${o.orderStatus == 'pending' || o.orderStatus == 'approved'}">
                                        <span class="badge badge-orange" style="background:#fff3e0; color:#e67e22; border:1px solid #e67e22">Waiting for Sales</span>
                                    </c:if>
                                    <c:if test="${o.orderStatus == 'shipping'}">
                                        <a href="order-status?orderId=${o.orderId}" class="btn-action btn-purple">Receive Goods</a>
                                    </c:if>
                                </c:when>

                                <c:otherwise>
                                    <c:if test="${o.orderStatus == 'pending' || o.orderStatus == 'approved'}">
                                        <a href="order-status?orderId=${o.orderId}" class="btn-action">Check & Ship</a>
                                    </c:if>
                                    <c:if test="${o.orderStatus == 'shipping'}">
                                        <span class="badge badge-blue">Shipped</span>
                                    </c:if>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </c:forEach>
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

                <div class="widget">
                    <h3>Problem / Damaged</h3>
                    <c:forEach var="i" items="${problemItems}">
                        <div class="list-item">
                            <div>
                                <span class="item-main">${i.serialNumber}</span>
                                <span class="item-sub">${i.itemNote}</span>
                            </div>
                            <span class="badge badge-red">${i.status}</span>
                        </div>
                    </c:forEach>
                </div>
            </c:if>

            <c:if test="${currentUser.roleId == 1}">

                <div class="widget" style="flex: 2;"> 
                    <h3>Newest Users <a href="user-list" style="font-size:12px; text-decoration: none;">Manage Users</a></h3>

                    <table style="width: 100%; border-collapse: collapse; font-size: 13px;">
                        <thead>
                            <tr style="text-align: left; color: #7f8c8d; border-bottom: 1px solid #eee;">
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
                                        <span style="color: #999; font-size: 11px;">${u.email}</span>
                                    </td>
                                    <td style="padding: 8px;">
                                        <span class="badge badge-blue">${u.roleName}</span>
                                    </td>
                                    <td style="padding: 8px;">
                                        <c:choose>
                                            <c:when test="${u.status == 'active'}">
                                                <span style="color: #27ae60; font-weight: bold;">Active</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span style="color: #c0392b; font-weight: bold;">Inactive</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <div class="widget" style="flex: 1;">
                    <h3>System Roles <a href="role-list" style="font-size:12px; text-decoration: none;">View All</a></h3>

                    <table style="width: 100%; border-collapse: collapse; font-size: 13px;">
                        <thead>
                            <tr style="text-align: left; color: #7f8c8d; border-bottom: 1px solid #eee;">
                                <th style="padding: 8px;">Role Name</th>
                                <th style="padding: 8px;">Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="r" items="${roleList}">
                                <tr style="border-bottom: 1px solid #f9f9f9;">
                                    <td style="padding: 10px 8px;">${r.roleName}</td>
                                    <td style="padding: 10px 8px;">
                                        <span class="badge ${r.status == 'active' ? 'badge-green' : 'badge-red'}">
                                            ${r.status}
                                        </span>
                                    </td>
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