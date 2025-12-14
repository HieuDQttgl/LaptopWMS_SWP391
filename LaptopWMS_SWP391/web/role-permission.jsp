<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="Model.Role" %>
<%@ page import="Model.Permission" %>

<%
    List<Role> roles = (List<Role>) request.getAttribute("roles");
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

    Set<String> modules = new HashSet<>();
    for (Permission p : permissions)
        modules.add(p.getModule());
%>
<style>

    .container {
        max-width: 980px;
        margin: 18px auto;
        padding: 12px;
        font-family: "Segoe UI", Roboto, Arial, sans-serif;
        background: #fafafa;
        border: 1px solid #eee;
        border-radius: 6px;
    }


    h2 {
        margin: 0 0 12px 0;
        font-size: 20px;
        color: #222;
    }


    #moduleSelect {
        padding: 6px 10px;
        border-radius: 4px;
        border: 1px solid #ccc;
        background: #fff;
        margin-bottom: 12px;
    }


    table {
        width: 100%;
        border-collapse: collapse;
        background: #fff;
        box-shadow: none;
    }

    table th, table td {
        padding: 8px 10px;
        border: 1px solid #e6e6e6;
        text-align: left;
        font-size: 14px;
    }

    table thead th {
        background: #f3f4f6;
        color: #333;
        font-weight: 600;
    }


    table tbody tr:nth-child(odd) {
        background: #ffffff;
    }
    table tbody tr:nth-child(even) {
        background: #fbfbfb;
    }


    table td input[type="checkbox"] {
        transform: scale(1.05);
        margin: 0;
        display: block;
        margin-left: auto;
        margin-right: auto;
    }


    .permission-meta {
        color: #666;
        font-size: 12px;
    }


    .btn {
        display: inline-block;
        padding: 7px 12px;
        margin: 6px 6px 12px 0;
        text-decoration: none;
        border-radius: 5px;
        border: 1px solid #d0d0d0;
        background: #fff;
        color: #333;
        font-size: 13px;
    }


    .btn.primary {
        background: #e9f5ff;
        border-color: #c7e3ff;
    }


    .badge-active {
        background: #dff0d8;
        color: #2f6627;
        padding: 3px 8px;
        border-radius: 12px;
        font-size: 12px;
    }
    .badge-inactive {
        background: #f8d7da;
        color: #7a2a2a;
        padding: 3px 8px;
        border-radius: 12px;
        font-size: 12px;
    }


    @media (max-width: 640px) {
        .container {
            padding: 8px;
        }
        table th, table td {
            font-size: 13px;
            padding: 6px;
        }
        #moduleSelect {
            width: 100%;
        }
    }
</style>

<body>

<div class="container">
    <h2>Role Permission Management</h2>
    <% if (request.getParameter("success") != null) { %>
        <div class="success-msg">Permissions updated successfully!</div>
    <% } %>

    <div class="controls">
        <select id="moduleSelect" onchange="filterTable()" style="padding: 8px; border-radius: 4px; border: 1px solid #ccc;">
            <option value="all">-- All Modules --</option>
            <% for (String m : modules) { %>
                <option value="<%= m %>"><%= m %></option>
            <% } %>
        </select>

        <input type="text" id="searchInput" onkeyup="filterTable()" placeholder="Search permission description..." >
    </div>

    <form action="role-permission" method="POST">
        <table>
            <thead>
                <tr>
                    <th>Permission (URL)</th>
                    <% for (Role r : roles) { %>
                        <th style="text-align: center;"><%= r.getRoleName() %></th>
                    <% } %>
                </tr>
            </thead>
            <tbody>
                <% for (Permission p : permissions) { %>
                <tr class="perm-row" data-module="<%= p.getModule() %>">
                    <td>
                        <span class="perm-name"><b><%= p.getPermissionDescription() %></b></span>
                        <br>
                        <small style="color: #888;"><%= p.getPermissionURL() %></small>
                    </td>

                    <% for (Role r : roles) { 
                        Set<Integer> rolePerms = rolePermMap.get(r.getRoleId());
                        boolean checked = rolePerms != null && rolePerms.contains(p.getPermissionId());
                        boolean isAdmin = r.getRoleId() == 1;
                    %>
                    <td style="text-align: center;">
                        <input type="checkbox" 
                               name="perm_<%= r.getRoleId() %>_<%= p.getPermissionId() %>"
                               value="true"
                               <%= isAdmin ? "checked disabled" : (checked ? "checked" : "") %>>
                        <% if (isAdmin) { %>
                            <input type="hidden" name="perm_<%= r.getRoleId() %>_<%= p.getPermissionId() %>" value="true">
                        <% } %>
                    </td>
                    <% } %>
                </tr>
                <% } %>
            </tbody>
        </table>

        <button type="submit" class="update-btn">Save Changes</button>
        <div style="clear: both;"></div>
    </form>
</div>

<jsp:include page="footer.jsp"/>

<script>
    function filterTable() {
        var input = document.getElementById("searchInput").value.toUpperCase();
        var selectedModule = document.getElementById("moduleSelect").value;
        var rows = document.querySelectorAll(".perm-row");

        rows.forEach(row => {
            var text = row.querySelector(".perm-name").innerText.toUpperCase();
            var module = row.getAttribute("data-module");
            var matchKeyword = text.indexOf(input) > -1;
            var matchModule = (selectedModule === "all" || selectedModule === module);
            row.style.display = (matchKeyword && matchModule) ? "" : "none";
        });
    }
</script>
</body>
</html>