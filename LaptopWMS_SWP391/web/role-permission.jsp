<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ page import="java.util.*" %>
        <%@ page import="Model.Role" %>
            <%@ page import="Model.Permission" %>
                <!DOCTYPE html>
                <html>

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Role Permissions | Laptop WMS</title>
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
                            margin: 0 auto;
                            padding: 2rem;
                        }

                        .page-header {
                            margin-bottom: 1.5rem;
                        }

                        .page-title {
                            font-size: 1.75rem;
                            font-weight: 700;
                            color: #1e293b;
                            margin: 0 0 0.5rem;
                            display: flex;
                            align-items: center;
                            gap: 0.75rem;
                        }

                        .page-subtitle {
                            color: #64748b;
                            font-size: 0.9375rem;
                        }

                        .card {
                            background: white;
                            border-radius: 1rem;
                            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
                            border: 1px solid #f1f5f9;
                            padding: 1.5rem;
                        }

                        .filter-bar {
                            display: flex;
                            gap: 1rem;
                            margin-bottom: 1.5rem;
                            padding: 1rem;
                            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
                            border-radius: 0.75rem;
                        }

                        .search-input {
                            flex: 1;
                            padding: 0.75rem 1rem;
                            border: 2px solid #e2e8f0;
                            border-radius: 0.5rem;
                            font-size: 0.9375rem;
                            outline: none;
                            transition: all 0.2s ease;
                        }

                        .search-input:focus {
                            border-color: #667eea;
                            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.15);
                        }

                        .table-container {
                            max-height: 500px;
                            overflow-y: auto;
                            border: 1px solid #e2e8f0;
                            border-radius: 0.75rem;
                        }

                        table {
                            width: 100%;
                            border-collapse: collapse;
                        }

                        thead th {
                            position: sticky;
                            top: 0;
                            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                            color: white;
                            padding: 1rem;
                            text-align: left;
                            font-size: 0.75rem;
                            font-weight: 700;
                            text-transform: uppercase;
                            letter-spacing: 0.5px;
                            z-index: 10;
                        }

                        thead th.role-header {
                            text-align: center;
                            min-width: 100px;
                        }

                        tbody td {
                            padding: 0.875rem 1rem;
                            border-bottom: 1px solid #f1f5f9;
                            font-size: 0.875rem;
                            color: #475569;
                        }

                        tbody tr:hover td {
                            background: #f8fafc;
                        }

                        .perm-desc {
                            font-weight: 600;
                            color: #1e293b;
                            display: block;
                            margin-bottom: 0.25rem;
                        }

                        .perm-url {
                            font-family: 'Menlo', monospace;
                            font-size: 0.6875rem;
                            color: #64748b;
                            background: #f1f5f9;
                            padding: 0.25rem 0.5rem;
                            border-radius: 0.25rem;
                        }

                        input[type="checkbox"] {
                            width: 18px;
                            height: 18px;
                            cursor: pointer;
                            accent-color: #667eea;
                        }

                        .action-bar {
                            margin-top: 1.5rem;
                            display: flex;
                            justify-content: space-between;
                            align-items: center;
                            padding-top: 1.5rem;
                            border-top: 1px solid #f1f5f9;
                        }

                        .btn-back {
                            color: #64748b;
                            text-decoration: none;
                            font-weight: 500;
                            font-size: 0.875rem;
                        }

                        .btn-back:hover {
                            color: #667eea;
                        }

                        .btn-save {
                            padding: 0.875rem 2rem;
                            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
                            color: white;
                            border: none;
                            border-radius: 0.5rem;
                            font-weight: 600;
                            font-size: 0.9375rem;
                            cursor: pointer;
                            transition: all 0.2s ease;
                            box-shadow: 0 4px 14px rgba(16, 185, 129, 0.4);
                        }

                        .btn-save:hover {
                            transform: translateY(-2px);
                            box-shadow: 0 6px 20px rgba(16, 185, 129, 0.5);
                        }

                        @media (max-width: 768px) {
                            .page-container {
                                padding: 1rem;
                            }

                            .card {
                                padding: 1rem;
                            }

                            thead th,
                            tbody td {
                                padding: 0.75rem 0.5rem;
                                font-size: 0.75rem;
                            }
                        }
                    </style>
                </head>

                <body>
                    <jsp:include page="header.jsp" />

                    <div class="page-container">
                        <div class="page-header">
                            <h1 class="page-title">🔐 Role Permissions</h1>
                            <p class="page-subtitle">Control access rights for each role. Check the box to grant
                                permission.</p>
                        </div>

                        <% List<Role> roles = (List<Role>) request.getAttribute("roles");
                                List<Permission> permissions = (List<Permission>) request.getAttribute("permissions");
                                        Map<Integer, Set<Integer>> rolePermMap = (Map<Integer, Set<Integer>>)
                                                request.getAttribute("rolePermMap");
                                                if (roles == null) roles = new ArrayList<>();
                                                    if (permissions == null) permissions = new ArrayList<>();
                                                        if (rolePermMap == null) rolePermMap = new HashMap<>();
                                                            %>

                                                            <div class="card">
                                                                <div class="filter-bar">
                                                                    <input type="text" id="searchInput"
                                                                        class="search-input" onkeyup="filterTable()"
                                                                        placeholder="Search permission description or URL...">
                                                                </div>

                                                                <form action="role-permission" method="post">
                                                                    <div class="table-container">
                                                                        <table>
                                                                            <thead>
                                                                                <tr>
                                                                                    <th style="width: 60px;">ID</th>
                                                                                    <th style="min-width: 280px;">
                                                                                        Permission Details</th>
                                                                                    <% for (Role r : roles) { %>
                                                                                        <th class="role-header">
                                                                                            <%= r.getRoleName() %>
                                                                                        </th>
                                                                                        <% } %>
                                                                                </tr>
                                                                            </thead>
                                                                            <tbody>
                                                                                <% if (!permissions.isEmpty()) { for
                                                                                    (Permission p : permissions) { %>
                                                                                    <tr class="perm-row">
                                                                                        <td style="color: #94a3b8;">
                                                                                            <%= p.getPermissionId() %>
                                                                                        </td>
                                                                                        <td>
                                                                                            <span
                                                                                                class="perm-desc perm-search-target">
                                                                                                <%= p.getPermissionDescription()
                                                                                                    %>
                                                                                            </span>
                                                                                            <span
                                                                                                class="perm-url perm-search-target">
                                                                                                <%= p.getPermissionURL()
                                                                                                    %>
                                                                                            </span>
                                                                                        </td>
                                                                                        <% for (Role r : roles) {
                                                                                            boolean
                                                                                            isAdmin=(r.getRoleId()==1);
                                                                                            Set<Integer> assignedPerms =
                                                                                            rolePermMap.get(r.getRoleId());
                                                                                            boolean checked =
                                                                                            (assignedPerms != null &&
                                                                                            assignedPerms.contains(p.getPermissionId()));
                                                                                            %>
                                                                                            <td
                                                                                                style="text-align: center;">
                                                                                                <input type="checkbox"
                                                                                                    name="perm_<%= r.getRoleId() %>_<%= p.getPermissionId() %>"
                                                                                                    value="true"
                                                                                                    <%=isAdmin
                                                                                                    ? "checked disabled"
                                                                                                    : (checked
                                                                                                    ? "checked" : "" )
                                                                                                    %>
                                                                                                title="<%=
                                                                                                    r.getRoleName() %> -
                                                                                                    <%= p.getPermissionDescription()
                                                                                                        %>">
                                                                                                        <% if (isAdmin)
                                                                                                            { %>
                                                                                                            <input
                                                                                                                type="hidden"
                                                                                                                name="perm_<%= r.getRoleId() %>_<%= p.getPermissionId() %>"
                                                                                                                value="true">
                                                                                                            <% } %>
                                                                                            </td>
                                                                                            <% } %>
                                                                                    </tr>
                                                                                    <% } } else { %>
                                                                                        <tr>
                                                                                            <td colspan="<%= 2 + roles.size() %>"
                                                                                                style="text-align: center; padding: 3rem; color: #94a3b8;">
                                                                                                No permissions data
                                                                                                found.
                                                                                            </td>
                                                                                        </tr>
                                                                                        <% } %>
                                                                            </tbody>
                                                                        </table>
                                                                    </div>

                                                                    <div class="action-bar">
                                                                        <a href="javascript:history.back()"
                                                                            class="btn-back">← Back to Dashboard</a>
                                                                        <button type="submit" class="btn-save">Save
                                                                            Permission Changes</button>
                                                                    </div>
                                                                </form>
                                                            </div>
                    </div>

                    <jsp:include page="footer.jsp" />

                    <script>
                        function filterTable() {
                            var input = document.getElementById("searchInput").value.toUpperCase();
                            var rows = document.querySelectorAll(".perm-row");
                            rows.forEach(row => {
                                var targets = row.querySelectorAll(".perm-search-target");
                                var text = "";
                                targets.forEach(span => text += span.innerText + " ");
                                row.style.display = text.toUpperCase().indexOf(input) > -1 ? "" : "none";
                            });
                        }
                    </script>
                </body>

                </html>