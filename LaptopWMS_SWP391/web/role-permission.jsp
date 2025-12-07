<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="Model.Role" %>
<%@ page import="Model.Permission" %>

<%
    List<Role> roles = (List<Role>) request.getAttribute("roles");
    List<Permission> permissions = (List<Permission>) request.getAttribute("permissions");
    Map<Integer, Set<Integer>> rolePermMap = (Map<Integer, Set<Integer>>) request.getAttribute("rolePermMap");
    
    if (roles == null) roles = new ArrayList<>();
    if (permissions == null) permissions = new ArrayList<>();
    if (rolePermMap == null) rolePermMap = new HashMap<>();
%>

<html>
<head>
    <title>Role Permission Management</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f6f8;
            padding: 20px;
            color: #333;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        h2 { border-bottom: 2px solid #0056b3; padding-bottom: 10px; color: #0056b3; }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px 15px;
            border-bottom: 1px solid #ddd;
            text-align: left;
        }
        th {
            background-color: #f1f1f1;
            font-weight: 600;
            text-align: center;
        }
        /* Sticky Header for long lists */
        thead th { position: sticky; top: 0; background: #e9ecef; z-index: 1; }
        
        /* Zebra striping and hover effects */
        tbody tr:nth-child(even) { background-color: #f9f9f9; }
        tbody tr:hover { background-color: #e2e6ea; }
        
        /* Center checkboxes */
        td.check-col { text-align: center; }
        input[type="checkbox"] { cursor: pointer; width: 18px; height: 18px; }

        .btn {
            background-color: #28a745;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 20px;
            float: right;
        }
        .btn:hover { background-color: #218838; }
    </style>
</head>

<body>

<div class="container">
    <h2>Role Permission Management</h2>

    <form method="post" action="role-permission">
        <table>
            <thead>
            <tr>
                <th>Permission</th>
                <% for (Role r : roles) { %>
                    <th><%= r.getRoleName() %></th>
                <% } %>
            </tr>
            </thead>

            <tbody>
            <% for (Permission p : permissions) { %>
                <tr>
                    <td><%= p.getPermissionDescription() %></td>

                    <% for (Role r : roles) { 
                        Set<Integer> rolePerms = rolePermMap.get(r.getRoleId());
                        boolean checked = (rolePerms != null && rolePerms.contains(p.getPermissionId()));
                    %>
                        <td class="check-col">
                            <input type="checkbox"
                                   name="perm_<%= r.getRoleId() %>"
                                   value="<%= p.getPermissionId() %>"
                                   <%= checked ? "checked" : "" %> />
                        </td>
                    <% } %>
                </tr>
            <% } %>
            </tbody>
        </table>

        <button type="submit" class="btn">Update Permissions</button>
        <div style="clear:both;"></div>
    </form>
</div>

</body>
</html>