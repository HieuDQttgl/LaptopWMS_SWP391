<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Customer List</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <a href="add-customer" class="btn btn-primary mb-3"> Add New Customer</a>
        <div class="container mt-4">
            <h2 class="mb-3">Customer List</h2>

            <table class="table table-bordered table-striped">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${customerList}" var="c">
                        <tr>
                            <td>${c.partnerId}</td>
                            <td>${c.partnerName}</td>
                            <td>${c.partnerEmail}</td>
                            <td>${c.partnerPhone}</td>
                            <td>
                                <span class="badge ${c.status == 'active' ? 'bg-success' : 'bg-secondary'}">
                                    ${c.status}
                                </span>
                            </td>
                            <td>
                                <a href="customer-detail?id=${c.partnerId}" class="btn btn-sm btn-info text-white">View</a>

                                <c:choose>
                                    <c:when test="${c.status == 'active'}">
                                        <a href="change-status?id=${c.partnerId}&status=active" 
                                           class="btn btn-sm btn-danger"
                                           onclick="return confirm('Are you sure you want to block this customer?')">Block</a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="change-status?id=${c.partnerId}&status=inactive" 
                                           class="btn btn-sm btn-success"
                                           onclick="return confirm('Are you sure you want to unblock this customer?')">Unblock</a>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </body>
</html>