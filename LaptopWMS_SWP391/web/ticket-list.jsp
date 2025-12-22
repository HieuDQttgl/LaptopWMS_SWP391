<%@page import="Model.Ticket" %>
    <%@page import="java.util.List" %>
        <%@page import="java.text.SimpleDateFormat" %>
            <%@page contentType="text/html" pageEncoding="UTF-8" %>
                <!DOCTYPE html>
                <html>

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Tickets | Laptop WMS</title>
                    <link
                        href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap"
                        rel="stylesheet">
                    <style>
                        * {
                            margin: 0;
                            padding: 0;
                            box-sizing: border-box;
                        }

                        body {
                            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
                            background: linear-gradient(135deg, #f0f4ff 0%, #f8fafc 50%, #f0fdf4 100%);
                            min-height: 100vh;
                        }

                        .page-container {
                            max-width: 1400px;
                            margin: 0 auto;
                            padding: 2rem;
                        }

                        /* Page Header */
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

                        .btn-create {
                            display: inline-flex;
                            align-items: center;
                            gap: 0.5rem;
                            padding: 0.875rem 1.75rem;
                            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                            color: white;
                            text-decoration: none;
                            border-radius: 0.75rem;
                            font-weight: 600;
                            font-size: 0.9375rem;
                            transition: all 0.2s ease;
                            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
                        }

                        .btn-create:hover {
                            transform: translateY(-2px);
                            box-shadow: 0 12px 30px rgba(102, 126, 234, 0.5);
                            color: white;
                        }

                        /* Success Message */
                        .success-message {
                            display: flex;
                            align-items: center;
                            gap: 0.75rem;
                            padding: 1rem 1.25rem;
                            background: linear-gradient(135deg, #dcfce7 0%, #bbf7d0 100%);
                            border: 1px solid #86efac;
                            border-radius: 0.75rem;
                            color: #16a34a;
                            font-weight: 500;
                            margin-bottom: 1.5rem;
                            animation: slideDown 0.3s ease-out;
                        }

                        @keyframes slideDown {
                            from {
                                opacity: 0;
                                transform: translateY(-10px);
                            }

                            to {
                                opacity: 1;
                                transform: translateY(0);
                            }
                        }

                        /* Filter Bar */
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
                            color: #334155;
                            outline: none;
                            transition: all 0.2s ease;
                            min-width: 140px;
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
                            font-size: 0.875rem;
                            cursor: pointer;
                            transition: all 0.2s ease;
                        }

                        .btn-search:hover {
                            transform: translateY(-1px);
                            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
                        }

                        .btn-reset {
                            padding: 0.625rem 1.25rem;
                            background: #94a3b8;
                            color: white;
                            text-decoration: none;
                            border-radius: 0.5rem;
                            font-weight: 600;
                            font-size: 0.875rem;
                            transition: all 0.2s ease;
                        }

                        .btn-reset:hover {
                            background: #64748b;
                            color: white;
                        }

                        /* Table Card */
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
                            vertical-align: middle;
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

                        /* Ticket Code */
                        .ticket-code {
                            font-weight: 700;
                            color: #667eea;
                            font-size: 0.9375rem;
                        }

                        /* Type Badge */
                        .type-badge {
                            display: inline-flex;
                            align-items: center;
                            gap: 0.375rem;
                            padding: 0.375rem 0.875rem;
                            border-radius: 2rem;
                            font-size: 0.6875rem;
                            font-weight: 600;
                            text-transform: uppercase;
                            letter-spacing: 0.5px;
                        }

                        .type-import {
                            background: linear-gradient(135deg, #dcfce7 0%, #bbf7d0 100%);
                            color: #16a34a;
                        }

                        .type-export {
                            background: linear-gradient(135deg, #fef3c7 0%, #fde68a 100%);
                            color: #d97706;
                        }

                        /* Status Badge */
                        .status-badge {
                            display: inline-flex;
                            align-items: center;
                            gap: 0.25rem;
                            padding: 0.375rem 0.875rem;
                            border-radius: 2rem;
                            font-size: 0.6875rem;
                            font-weight: 600;
                            text-transform: uppercase;
                            letter-spacing: 0.5px;
                        }

                        .status-pending {
                            background: linear-gradient(135deg, #fef3c7 0%, #fde68a 100%);
                            color: #d97706;
                        }

                        .status-completed {
                            background: linear-gradient(135deg, #dcfce7 0%, #bbf7d0 100%);
                            color: #16a34a;
                        }

                        .status-rejected,
                        .status-cancelled {
                            background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
                            color: #dc2626;
                        }

                        /* Action Buttons */
                        .action-buttons {
                            display: flex;
                            gap: 0.5rem;
                        }

                        .btn-view {
                            display: inline-flex;
                            align-items: center;
                            gap: 0.25rem;
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

                        .btn-edit {
                            display: inline-flex;
                            align-items: center;
                            gap: 0.25rem;
                            padding: 0.5rem 1rem;
                            background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
                            color: white;
                            text-decoration: none;
                            border-radius: 0.5rem;
                            font-size: 0.75rem;
                            font-weight: 600;
                            transition: all 0.2s ease;
                        }

                        .btn-edit:hover {
                            transform: translateY(-1px);
                            box-shadow: 0 4px 12px rgba(245, 158, 11, 0.4);
                            color: white;
                        }

                        /* Partner Badge */
                        .partner-badge {
                            display: inline-flex;
                            align-items: center;
                            gap: 0.25rem;
                            padding: 0.25rem 0.625rem;
                            background: #f1f5f9;
                            border-radius: 0.375rem;
                            font-size: 0.75rem;
                            color: #475569;
                        }

                        /* Empty State */
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

                        .empty-state-text {
                            font-size: 1rem;
                            font-weight: 500;
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

                        /* Responsive */
                        @media (max-width: 1024px) {
                            .table-card {
                                overflow-x: auto;
                            }

                            table {
                                min-width: 900px;
                            }
                        }

                        @media (max-width: 768px) {
                            .page-container {
                                padding: 1rem;
                            }

                            .page-header {
                                flex-direction: column;
                                gap: 1rem;
                                align-items: flex-start;
                            }

                            .filter-bar {
                                flex-direction: column;
                                align-items: stretch;
                            }

                            .filter-group {
                                width: 100%;
                            }

                            .filter-group input,
                            .filter-group select {
                                width: 100%;
                            }
                        }
                    </style>
                </head>

                <body>
                    <%@include file="header.jsp" %>

                        <div class="page-container">
                            <!-- Page Header -->
                            <div class="page-header">
                                <h1 class="page-title">📋 Ticket Management</h1>
                                <% if (currentUser !=null && (currentUser.getRoleId()==1 || currentUser.getRoleId()==2))
                                    {%>
                                    <a href="<%= request.getContextPath()%>/create-ticket" class="btn-create">
                                        ✚ Create Ticket
                                    </a>
                                    <% } %>
                            </div>

                            <% String successMessage=(String) session.getAttribute("successMessage"); if (successMessage
                                !=null) { %>
                                <div class="success-message">
                                    ✓ <%= successMessage%>
                                </div>
                                <% session.removeAttribute("successMessage"); } %>

                                    <!-- Filter Bar -->
                                    <form method="get" action="ticket-list" class="filter-bar">
                                        <div class="filter-group">
                                            <label>Search Partner</label>
                                            <div style="display: flex; gap: 0.5rem;">
                                                <input type="text" name="partnerSearch" placeholder="Partner name..."
                                                    value="${currentPartnerSearch}">
                                                <button type="submit" class="btn-search">🔍</button>
                                            </div>
                                        </div>

                                        <div class="filter-group">
                                            <label>Status</label>
                                            <select name="status" onchange="this.form.submit()">
                                                <option value="all" ${currentStatus==null || currentStatus=='all'
                                                    ? 'selected' : '' }>All Status</option>
                                                <option value="PENDING" ${currentStatus=='PENDING' ? 'selected' : '' }>
                                                    Pending</option>
                                                <option value="COMPLETED" ${currentStatus=='COMPLETED' ? 'selected' : ''
                                                    }>Completed</option>
                                                <option value="CANCELLED" ${currentStatus=='CANCELLED' ? 'selected' : ''
                                                    }>Cancelled</option>
                                            </select>
                                        </div>

                                        <div class="filter-group">
                                            <label>Type</label>
                                            <select name="type" onchange="this.form.submit()">
                                                <option value="all" ${currentType==null || currentType=='all'
                                                    ? 'selected' : '' }>All Types</option>
                                                <option value="IMPORT" ${currentType=='IMPORT' ? 'selected' : '' }>
                                                    Import</option>
                                                <option value="EXPORT" ${currentType=='EXPORT' ? 'selected' : '' }>
                                                    Export</option>
                                            </select>
                                        </div>

                                        <a href="ticket-list" class="btn-reset">Reset</a>
                                    </form>

                                    <!-- Tickets Table -->
                                    <div class="table-card">
                                        <table>
                                            <thead>
                                                <tr>
                                                    <th>Code</th>
                                                    <th>Type</th>
                                                    <th>Title</th>
                                                    <th>Status</th>
                                                    <th>Created By</th>
                                                    <th>Assigned To</th>
                                                    <th>Date</th>
                                                    <th>Partner</th>
                                                    <th>Actions</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <% List<Ticket> tickets = (List<Ticket>)
                                                        request.getAttribute("tickets");
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
                                                                    <%= ticket.getType().equals("IMPORT") ? "📥" : "📤"
                                                                        %>
                                                                        <%= ticket.getType()%>
                                                                </span>
                                                            </td>
                                                            <td>
                                                                <%= ticket.getTitle()%>
                                                            </td>
                                                            <td>
                                                                <span
                                                                    class="status-badge status-<%= ticket.getStatus().toLowerCase()%>">
                                                                    <% if ("COMPLETED".equals(ticket.getStatus())) { %>✓
                                                                        <% } else if
                                                                            ("PENDING".equals(ticket.getStatus())) { %>⏳
                                                                            <% } else { %>✗<% } %>
                                                                                    <%= ticket.getStatus()%>
                                                                </span>
                                                            </td>
                                                            <td>
                                                                <%= ticket.getCreatorName() !=null ?
                                                                    ticket.getCreatorName() : "-" %>
                                                            </td>
                                                            <td>
                                                                <%= ticket.getKeeperName() !=null ?
                                                                    ticket.getKeeperName() : "-" %>
                                                            </td>
                                                            <td>
                                                                <%= ticket.getCreatedAt() !=null ?
                                                                    sdf.format(ticket.getCreatedAt()) : "-" %>
                                                            </td>
                                                            <td>
                                                                <% if (ticket.getPartnerName() !=null) { %>
                                                                    <span class="partner-badge">🏢 <%=
                                                                            ticket.getPartnerName()%></span>
                                                                    <% } else { %>-<% } %>
                                                            </td>
                                                            <td class="action-buttons">
                                                                <a href="<%= request.getContextPath()%>/ticket-detail?id=<%= ticket.getTicketId()%>"
                                                                    class="btn-view">View</a>
                                                                <% if (currentUser !=null && (currentUser.getRoleId()==1
                                                                    || currentUser.getRoleId()==2)) { if
                                                                    ("PENDING".equalsIgnoreCase(ticket.getStatus())) {
                                                                    %>
                                                                    <a href="<%= request.getContextPath()%>/edit-ticket?id=<%= ticket.getTicketId()%>"
                                                                        class="btn-edit">Edit</a>
                                                                    <% } } %>
                                                            </td>
                                                        </tr>
                                                        <% } } else { %>
                                                            <tr>
                                                                <td colspan="9">
                                                                    <div class="empty-state">
                                                                        <div class="empty-state-icon">📭</div>
                                                                        <div class="empty-state-text">No tickets found
                                                                        </div>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                            <% }%>
                                            </tbody>
                                        </table>
                                    </div>

                                    <% Integer totalPages=(Integer) request.getAttribute("totalPages"); Integer
                                        currentPage=(Integer) request.getAttribute("currentPage"); String
                                        currentStatus=(String) request.getAttribute("currentStatus"); String
                                        currentType=(String) request.getAttribute("currentType"); String
                                        currentPartnerSearch=(String) request.getAttribute("currentPartnerSearch"); if
                                        (currentPartnerSearch==null) { currentPartnerSearch="" ; } if (totalPages !=null
                                        && totalPages> 1) {
                                        %>
                                        <div class="pagination">
                                            <% if (currentPage> 1) {%>
                                                <a
                                                    href="?page=<%= currentPage - 1%>&status=<%= currentStatus%>&type=<%= currentType%>&partnerSearch=<%= currentPartnerSearch%>">«</a>
                                                <% } %>

                                                    <% for (int i=1; i <=totalPages; i++) {%>
                                                        <a href="?page=<%= i%>&status=<%= currentStatus%>&type=<%= currentType%>&partnerSearch=<%= currentPartnerSearch%>"
                                                            class="<%= (currentPage == i) ? " active" : "" %>">
                                                            <%= i%>
                                                        </a>
                                                        <% } %>

                                                            <% if (currentPage < totalPages) {%>
                                                                <a
                                                                    href="?page=<%= currentPage + 1%>&status=<%= currentStatus%>&type=<%= currentType%>&partnerSearch=<%= currentPartnerSearch%>">»</a>
                                                                <% } %>
                                        </div>
                                        <% }%>
                        </div>
                </body>

                </html>