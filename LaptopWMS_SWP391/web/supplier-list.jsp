<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Supplier List</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>

    <body>
        <a href="add-supplier" class="btn btn-primary mb-3"> Add New Supplier</a>
        <div class="container mt-4">
            <h2 class="mb-3">Supplier List</h2>

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
                    <c:forEach items="${supplierList}" var="s">
                        <tr>
                            <td>${s.partnerId}</td>
                            <td>${s.partnerName}</td>
                            <td>${s.partnerEmail}</td>
                            <td>${s.partnerPhone}</td>
                            <td>
                                <span class="badge ${s.status == 'active' ? 'bg-success' : 'bg-secondary'}">
                                    ${s.status}
                                </span>
                            </td>
                            <td>
                                <a href="supplier-detail?id=${s.partnerId}"
                                   class="btn btn-sm btn-info text-white">View</a>

                                <c:choose>
                                    <c:when test="${s.status == 'active'}">
                                        <a href="supplier-status?id=${s.partnerId}&status=active"
                                           class="btn btn-sm btn-danger"
                                           onclick="return confirm('Are you sure you want to block this supplier?')">Block</a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="supplier-status?id=${s.partnerId}&status=inactive"
                                           class="btn btn-sm btn-success"
                                           onclick="return confirm('Are you sure you want to unblock this supplier?')">Unblock</a>
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