<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="header.jsp"/>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Role Management</title>

    <style>
        body {
            margin: 0;
            font-family: "Segoe UI", sans-serif;
            background: #f5f6fa;
        }

        .container {
            width: 90%;
            margin: 40px auto;
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.07);
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #2c3e50;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            border-radius: 8px;
            overflow: hidden;
        }

        th {
            background: #2c3e50;
            color: white;
            padding: 12px;
            text-align: left;
            font-size: 15px;
        }

        td {
            padding: 12px;
            font-size: 15px;
            border-bottom: 1px solid #e1e1e1;
        }

        tr:hover td {
            background: #f0f3f7;
        }

        .status-active {
            color: #27ae60;
            font-weight: bold;
        }

        .status-inactive {
            color: #e74c3c;
            font-weight: bold;
        }

        button {
            padding: 8px 14px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            color: white;
            transition: 0.2s;
        }

        .btn-active {
            background: #27ae60;
        }

        .btn-active:hover {
            background: #1f8f4f;
        }

        .btn-inactive {
            background: #e74c3c;
        }

        .btn-inactive:hover {
            background: #c0392b;
        }
    </style>

</head>
<body>

    <div class="container">
        <h2>Role Management</h2>

        <table>
            <tr>
                <th>ID</th>
                <th>Role Name</th>
                <th>Status</th>
                <th>Action</th>
            </tr>

            <c:forEach var="role" items="${roles}">
                <tr>
                    <td>${role.roleId}</td>
                    <td>${role.roleName}</td>

                    <td>
                        <c:if test="${role.status eq 'active'}">
                            <span class="status-active">Active</span>
                        </c:if>

                        <c:if test="${role.status ne 'active'}">
                            <span class="status-inactive">Inactive</span>
                        </c:if>
                    </td>

                    <td>
                        <form action="role-status" method="post">
                            <input type="hidden" name="roleId" value="${role.roleId}">
                            <input type="hidden" name="status" value="${role.status}">

                            <c:if test="${role.status eq 'active'}">
                                <button class="btn-inactive" type="submit">Deactivate</button>
                            </c:if>

                            <c:if test="${role.status ne 'active'}">
                                <button class="btn-active" type="submit">Activate</button>
                            </c:if>
                        </form>
                    </td>
                </tr>
            </c:forEach>

        </table>
    </div>
<jsp:include page="footer.jsp"/>
</body>
</html>
