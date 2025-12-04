

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <table border="1" cellpadding="10">
            <tr>
                <th>ID</th>
                <th>Role Name</th>
                <th>Status</th>
                <th>Action</th>
            </tr>

            <%
                List<Role> roles = (List<Role>) request.getAttribute("roles");
                for (Role role : roles) {
            %>

            <tr>
                <td><%= role.getRoleId() %></td>
                <td><%= role.getName() %></td>
                <td>
                    <%= "active".equals(role.getStatus()) 
                        ? "<span style='color:green'>Active</span>" 
                        : "<span style='color:red'>Inactive</span>" %>
                </td>
                <td>
                    <form action="role-status" method="post">
                        <input type="hidden" name="roleId" value="<%= role.getRoleId() %>">
                        <input type="hidden" name="status" value="<%= role.getStatus() %>">
                        <button type="submit">
                            <%= role.getStatus().equals("active") ? "Deactivate" : "Activate" %>
                        </button>
                    </form>
                </td>
            </tr>

            <% } %>
        </table>

    </body>
</html>
