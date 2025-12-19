<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="Model.Role" %>
<%@ page import="Model.Permission" %>

<!DOCTYPE html>
<html>

    <head>
        <jsp:include page="header.jsp" />
        <meta charset="UTF-8">
        <title>Laptop Warehouse Management System</title>

        <style>
            body {
                font-family: 'Segoe UI', Roboto, Arial, sans-serif;
                background-color: #f5f5f5;
                margin: 0;
                padding: 20px;
            }

            .container {
                max-width: 1200px;
                margin: 0 auto;
                background-color: white;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }

            h1 {
                color: #1f2937;
                margin-bottom: 5px;
                font-size: 24px;
            }

            .subtitle {
                color: #6b7280;
                margin-bottom: 25px;
                font-size: 14px;
            }

            .filter-bar {
                display: flex;
                gap: 15px;
                margin-bottom: 20px;
                background: #f9fafb;
                padding: 15px;
                border-radius: 8px;
                border: 1px solid #e5e7eb;
            }

            .search-input {
                flex: 1;
                padding: 10px 15px;
                border: 1px solid #d1d5db;
                border-radius: 6px;
                font-size: 14px;
                outline: none;
                transition: border-color 0.2s;
            }

            .search-input:focus {
                border-color: #10b981;
                box-shadow: 0 0 0 3px rgba(16, 185, 129, 0.1);
            }

            .table-container {
                max-height: 600px;
                overflow-y: auto;
                border: 1px solid #e5e7eb;
                border-radius: 6px;
            }

            table {
                width: 100%;
                border-collapse: collapse;
            }

            thead th {
                position: sticky;
                top: 0;
                background-color: #f3f4f6;
                z-index: 10;
                padding: 15px;
                text-align: left;
                border-bottom: 2px solid #e5e5e5;
                color: #374151;
                font-size: 13px;
                font-weight: 700;
                text-transform: uppercase;
                box-shadow: 0 2px 2px -1px rgba(0, 0, 0, 0.1);
            }

            thead th.role-header {
                text-align: center;
                min-width: 80px;
            }

            tbody td {
                padding: 12px 15px;
                border-bottom: 1px solid #f0f0f0;
                color: #374151;
                vertical-align: middle;
                font-size: 14px;
            }

            tbody tr:hover {
                background-color: #f9fafb;
            }

            .desc-text {
                font-weight: 600;
                color: #111827;
                display: block;
                margin-bottom: 4px;
            }

            .url-text {
                font-family: monospace;
                color: #6b7280;
                font-size: 12px;
                background: #f3f4f6;
                padding: 2px 6px;
                border-radius: 4px;
            }

            input[type="checkbox"] {
                width: 18px;
                height: 18px;
                cursor: pointer;
                accent-color: #10b981;
            }

            .action-bar {
                margin-top: 25px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding-top: 20px;
                border-top: 1px solid #e5e5e5;
            }

            .btn-save {
                background-color: #10b981;
                color: white;
                padding: 12px 30px;
                border: none;
                border-radius: 6px;
                font-size: 15px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s;
                box-shadow: 0 2px 4px rgba(16, 185, 129, 0.3);
            }

            .btn-save:hover {
                background-color: #059669;
                transform: translateY(-1px);
                box-shadow: 0 4px 6px rgba(16, 185, 129, 0.4);
            }

            .btn-back {
                color: #6b7280;
                text-decoration: none;
                font-weight: 500;
                display: inline-flex;
                align-items: center;
                gap: 5px;
            }

            .btn-back:hover {
                color: #1f2937;
            }
        </style>
    </head>

    <body>

        <div class="container">
            <h1>Role Permissions</h1>
            <div class="subtitle">Control access rights for each role. Check the box to grant permission.
            </div>

            <% List<Role> roles = (List<Role>) request.getAttribute("roles");
                List<Permission> permissions = (List<Permission>) request.getAttribute("permissions");
                Map<Integer, Set<Integer>> rolePermMap = (Map<Integer, Set<Integer>>) request.getAttribute("rolePermMap");

                if (roles == null) {
                    roles = new ArrayList<>();
                }
                if (permissions == null) {
                    permissions = new ArrayList<>();
                }
                if (rolePermMap == null) {
                    rolePermMap = new HashMap<>();
                }
            %>

            <div class="filter-bar">
                <input type="text" id="searchInput" class="search-input"
                       onkeyup="filterTable()"
                       placeholder="Type to search permission description or URL...">
            </div>

            <form action="role-permission" method="post">
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th style="width: 50px;">ID</th>
                                <th style="min-width: 300px;">Permission
                                    Details</th>

                                <%-- Role Columns --%>
                                <% for (Role r : roles) {%>
                                <th class="role-header">
                                    <%= r.getRoleName()%>
                                </th>
                                <% } %>
                            </tr>
                        </thead>
                        <tbody>
                            <% if (!permissions.isEmpty()) {
                                                                                    for (Permission p : permissions) {%>
                            <tr class="perm-row">
                                <td style="color: #9ca3af;">
                                    <%= p.getPermissionId()%>
                                </td>

                                <td>
                                    <span
                                        class="desc-text perm-search-target">
                                        <%=p.getPermissionDescription()%>
                                    </span>
                                    <span
                                        class="url-text perm-search-target">
                                        <%= p.getPermissionURL()%>
                                    </span>
                                </td>

                                <% for (Role r : roles) {
                                        boolean isAdmin = (r.getRoleId() == 1);
                                        Set<Integer> assignedPerms
                                                = rolePermMap.get(r.getRoleId());
                                        boolean checked = (assignedPerms
                                                != null
                                                && assignedPerms.contains(p.getPermissionId()));
                                %>
                                <td style="text-align: center;">
                                    <input type="checkbox"
                                           name="perm_<%= r.getRoleId()%>_<%= p.getPermissionId()%>"
                                           value="true" <%=isAdmin
                                                                                                        ? "checked disabled"
                                                                                                        : (checked ? "checked"
                                                                                                                : "")%>
                                           title="<%= r.getRoleName()%>
                                           - <%=p.getPermissionDescription()%>
                                           ">

                                    <% if (isAdmin) {%>
                                    <input
                                        type="hidden"
                                        name="perm_<%= r.getRoleId()%>_<%= p.getPermissionId()%>"
                                        value="true">
                                    <% } %>
                                </td>
                                <% } %>
                            </tr>
                            <% }
                                                                                } else {%>
                            <tr>
                                <td colspan="<%= 2 + roles.size()%>"
                                    style="text-align: center; padding: 40px; color: #6b7280;">
                                    No permissions data found.
                                </td>
                            </tr>
                            <% }%>
                        </tbody>
                    </table>
                </div>

                <div class="action-bar">
                    <a href="javascript:history.back()"
                       class="btn-back">
                        Back to Dashboard
                    </a>
                    <button type="submit" class="btn-save">Save
                        Permission Changes</button>
                </div>
            </form>
        </div>

        <jsp:include page="footer.jsp" />

        <script>
            function filterTable() {
                var input = document.getElementById("searchInput").value.toUpperCase();
                var rows = document.querySelectorAll(".perm-row");

                rows.forEach(row => {
                    var searchTargets = row.querySelectorAll(".perm-search-target");
                    var textContent = "";
                    searchTargets.forEach(span => textContent += span.innerText + " ");
                    textContent = textContent.toUpperCase();

                    if (textContent.indexOf(input) > -1) {
                        row.style.display = "";
                    } else {
                        row.style.display = "none";
                    }
                });
            }
        </script>

    </body>

</html>