<%@page import="Model.Ticket" %>
<%@page import="java.util.List" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Ticket List - WMS</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: #f1f5f9;
                min-height: 100vh;
            }

            .container {
                max-width: 1400px;
                margin: 0 auto;
                padding: 30px 20px;
            }

            .page-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 30px;
            }

            h1 {
                color: #1e293b;
                font-size: 28px;
                display: flex;
                align-items: center;
                gap: 12px;
            }

            .btn-create {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                text-decoration: none;
                padding: 12px 24px;
                border-radius: 10px;
                font-weight: 600;
                transition: all 0.3s;
                display: inline-flex;
                align-items: center;
                gap: 8px;
            }

            .btn-create:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
            }

            .filters {
                display: flex;
                gap: 16px;
                margin-bottom: 24px;
                flex-wrap: wrap;
            }

            .filter-group {
                display: flex;
                align-items: center;
                gap: 8px;
            }

            .filter-group label {
                font-weight: 500;
                color: #64748b;
            }

            .filter-group select {
                padding: 10px 16px;
                border: 2px solid #e2e8f0;
                border-radius: 8px;
                font-size: 14px;
                background: white;
            }

            .card {
                background: #fff;
                border-radius: 16px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
                overflow: hidden;
            }

            table {
                width: 100%;
                border-collapse: collapse;
            }

            th,
            td {
                padding: 16px 20px;
                text-align: left;
            }

            th {
                background: #f8fafc;
                font-weight: 600;
                color: #475569;
                font-size: 13px;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            tr {
                border-bottom: 1px solid #f1f5f9;
                transition: background 0.2s;
            }

            tr:hover {
                background: #f8fafc;
            }

            .ticket-code {
                font-weight: 600;
                color: #667eea;
            }

            .type-badge {
                display: inline-block;
                padding: 6px 12px;
                border-radius: 20px;
                font-size: 12px;
                font-weight: 600;
            }

            .type-import {
                background: #dcfce7;
                color: #16a34a;
            }

            .type-export {
                background: #fef3c7;
                color: #d97706;
            }

            .status-badge {
                display: inline-block;
                padding: 6px 12px;
                border-radius: 20px;
                font-size: 12px;
                font-weight: 600;
            }

            .status-pending {
                background: #fef3c7;
                color: #d97706;
            }

            .status-completed {
                background: #dcfce7;
                color: #16a34a;
            }

            .status-cancelled {
                background: #fee2e2;
                color: #dc2626;
            }

            .btn-view {
                background: #667eea;
                color: white;
                text-decoration: none;
                padding: 8px 16px;
                border-radius: 8px;
                font-size: 13px;
                font-weight: 500;
                transition: all 0.3s;
            }

            .btn-view:hover {
                background: #5a67d8;
            }

            .empty-state {
                text-align: center;
                padding: 60px 20px;
                color: #94a3b8;
            }

            .empty-state .icon {
                font-size: 48px;
                margin-bottom: 16px;
            }

            .success-message {
                background: #dcfce7;
                border: 1px solid #86efac;
                color: #16a34a;
                padding: 12px 20px;
                border-radius: 10px;
                margin-bottom: 20px;
                display: flex;
                align-items: center;
                gap: 10px;
            }
        </style>
    </head>

    <body>
        <%@include file="header.jsp" %>

        <div class="container">
            <div class="page-header">
                <h1>📋 Ticket List</h1>
                <% if (currentUser != null && (currentUser.getRoleId() == 1 || currentUser.getRoleId() == 2)) {%>
                <a href="<%= request.getContextPath()%>/create-ticket" class="btn-create">+ Create
                    Ticket</a>
                    <% } %>
            </div>

            <% String successMessage = (String) request.getAttribute("successMessage"); %>
            <% if (successMessage != null) {%>
            <div class="success-message">✓ <%= successMessage%>
            </div>
            <% } %>

            <form method="get" class="filters">
                <div class="filter-group">
                    <label>Status:</label>
                    <select name="status" onchange="this.form.submit()">
                        <option value="all" ${currentStatus==null || currentStatus=='all'
                                              ? 'selected' : '' }>All</option>
                        <option value="PENDING" ${currentStatus=='PENDING' ? 'selected' : ''
                                }>Pending</option>
                        <option value="COMPLETED" ${currentStatus=='COMPLETED' ? 'selected'
                                                    : '' }>Completed</option>
                        <option value="CANCELLED" ${currentStatus=='CANCELLED' ? 'selected'
                                                    : '' }>Cancelled</option>
                    </select>
                </div>
                <div class="filter-group">
                    <label>Type:</label>
                    <select name="type" onchange="this.form.submit()">
                        <option value="all" ${currentType==null || currentType=='all'
                                              ? 'selected' : '' }>All</option>
                        <option value="IMPORT" ${currentType=='IMPORT' ? 'selected' : '' }>
                            Import</option>
                        <option value="EXPORT" ${currentType=='EXPORT' ? 'selected' : '' }>
                            Export</option>
                    </select>
                </div>
            </form>

            <div class="card">
                <table>
                    <thead>
                        <tr>
                            <th>Code</th>
                            <th>Type</th>
                            <th>Title</th>
                            <th>Status</th>
                            <th>Created By</th>
                            <th>Assigned Keeper</th>
                            <th>Created At</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% List<Ticket> tickets = (List<Ticket>) request.getAttribute("tickets");
                            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
                            if (tickets != null && !tickets.isEmpty()) {
                                for (Ticket ticket : tickets) {
                        %>
                        <tr>
                            <td><span class="ticket-code">
                                    <%= ticket.getTicketCode()%>
                                </span></td>
                            <td>
                                <span
                                    class="type-badge type-<%= ticket.getType().toLowerCase()%>">
                                    <%= ticket.getType().equals("IMPORT") ? "📥 "
                                            : "📤 "%>
                                    <%= ticket.getType()%>
                                </span>
                            </td>
                            <td>
                                <%= ticket.getTitle()%>
                            </td>
                            <td>
                                <span
                                    class="status-badge status-<%= ticket.getStatus().toLowerCase()%>">
                                    <%= ticket.getStatus()%>
                                </span>
                            </td>
                            <td>
                                <%= ticket.getCreatorName() != null
                                        ? ticket.getCreatorName() : "-"%>
                            </td>
                            <td>
                                <%= ticket.getKeeperName() != null
                                        ? ticket.getKeeperName() : "-"%>
                            </td>
                            <td>
                                <%= ticket.getCreatedAt() != null
                                        ? sdf.format(ticket.getCreatedAt()) : "-"%>
                            </td>
                            <td>
                                <a href="<%= request.getContextPath()%>/ticket-detail?id=<%= ticket.getTicketId()%>"
                                   class="btn-view">View</a>
                            </td>
                        </tr>
                        <% }
                        } else { %>
                        <tr>
                            <td colspan="8">
                                <div class="empty-state">
                                    <div class="icon">📭</div>
                                    <div>No tickets found</div>
                                </div>
                            </td>
                        </tr>
                        <% }%>
                    </tbody>
                </table>
            </div>
        </div>
    </body>

</html>