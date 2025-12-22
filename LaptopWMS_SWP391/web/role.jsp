<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ page import="java.util.*" %>
        <%@ page import="Model.Users" %>
            <%@ page import="Model.Role" %>
                <!DOCTYPE html>
                <html>

                <head>
                    <meta charset="UTF-8">
                    <title>Roles | Laptop WMS</title>
                    <link
                        href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap"
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

                        .button-group {
                            display: flex;
                            gap: 0.75rem;
                        }

                        .btn {
                            display: inline-flex;
                            align-items: center;
                            gap: 0.5rem;
                            padding: 0.625rem 1.25rem;
                            color: white;
                            text-decoration: none;
                            border-radius: 0.5rem;
                            font-weight: 600;
                            font-size: 0.8125rem;
                            transition: all 0.2s ease;
                        }

                        .btn-add {
                            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
                            box-shadow: 0 4px 14px rgba(16, 185, 129, 0.4);
                        }

                        .btn-add:hover {
                            transform: translateY(-2px);
                            box-shadow: 0 6px 20px rgba(16, 185, 129, 0.5);
                            color: white;
                        }

                        .btn-secondary {
                            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                            box-shadow: 0 4px 14px rgba(102, 126, 234, 0.4);
                        }

                        .btn-secondary:hover {
                            transform: translateY(-2px);
                            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.5);
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

                        .role-name {
                            font-weight: 600;
                            color: #1e293b;
                        }

                        .role-desc {
                            color: #64748b;
                            font-size: 0.8125rem;
                            font-style: italic;
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

                        .action-link {
                            color: #3b82f6;
                            text-decoration: none;
                            font-weight: 500;
                            font-size: 0.875rem;
                            transition: color 0.2s ease;
                        }

                        .action-link:hover {
                            color: #1d4ed8;
                        }

                        .empty-state {
                            text-align: center;
                            padding: 4rem 2rem;
                            color: #94a3b8;
                        }

                        .pagination {
                            display: flex;
                            justify-content: center;
                            gap: 0.5rem;
                            margin-top: 2rem;
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

                        .footer-info {
                            margin-top: 1.5rem;
                            color: #64748b;
                            font-size: 0.875rem;
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

                            .button-group {
                                flex-wrap: wrap;
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
                            <h1 class="page-title">🔐 Role Management</h1>
                            <div class="button-group">
                                <a href="add-role" class="btn btn-add">+ Add Role</a>
                                <a href="role-list" class="btn btn-secondary">Status Settings</a>
                                <a href="role-permission" class="btn btn-secondary">Permissions</a>
                            </div>
                        </div>

                        <div class="table-card">
                            <table>
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Role Name</th>
                                        <th>Description</th>
                                        <th>Status</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% List<Role> roleList = (List<Role>) request.getAttribute("roleList");
                                            if (roleList != null && !roleList.isEmpty()) {
                                            for (Role role : roleList) {
                                            %>
                                            <tr>
                                                <td><strong>#<%= role.getRoleId()%></strong></td>
                                                <td><span class="role-name">
                                                        <%= role.getRoleName()%>
                                                    </span></td>
                                                <td><span class="role-desc">
                                                        <%= (role.getRoleDescription() !=null) ?
                                                            role.getRoleDescription() : "-" %>
                                                    </span></td>
                                                <td>
                                                    <% if ("active".equals(role.getStatus())) { %>
                                                        <span class="status-badge status-active">● Active</span>
                                                        <% } else { %>
                                                            <span class="status-badge status-inactive">● Inactive</span>
                                                            <% }%>
                                                </td>
                                                <td>
                                                    <a href="edit-role?id=<%= role.getRoleId()%>"
                                                        class="action-link">Edit</a>
                                                </td>
                                            </tr>
                                            <% } } else { %>
                                                <tr>
                                                    <td colspan="5" class="empty-state">
                                                        <div style="font-size: 3rem; margin-bottom: 0.5rem;">🔐</div>
                                                        No roles found
                                                    </td>
                                                </tr>
                                                <% }%>
                                </tbody>
                            </table>
                        </div>

                        <% Integer cpObj=(Integer) request.getAttribute("currentPage"); Integer tpObj=(Integer)
                            request.getAttribute("totalPages"); int currentPage=(cpObj !=null) ? cpObj : 1; int
                            totalPages=(tpObj !=null) ? tpObj : 1; String baseLink="role?page=" ; if (totalPages> 1) {
                            %>
                            <div class="pagination">
                                <% if (currentPage> 1) { %>
                                    <a href="<%= baseLink + (currentPage - 1)%>">« Prev</a>
                                    <% } %>

                                        <% for (int i=1; i <=totalPages; i++) {%>
                                            <a href="<%= baseLink + i%>" class="<%= i == currentPage ? " active" : ""
                                                %>"><%= i%></a>
                                            <% } %>

                                                <% if (currentPage < totalPages) {%>
                                                    <a href="<%= baseLink + (currentPage + 1)%>">Next »</a>
                                                    <% }%>
                            </div>
                            <% } %>

                                <div class="footer-info">
                                    Showing <%= roleList !=null ? roleList.size() : 0 %> roles on this page.
                                </div>

                                <a href="<%= request.getContextPath()%>/dashboard" class="back-link">← Back to
                                    Dashboard</a>
                    </div>

                    <jsp:include page="footer.jsp" />
                </body>

                </html>