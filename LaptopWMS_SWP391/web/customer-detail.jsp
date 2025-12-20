<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Customer Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card shadow-sm">
                    <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
                        <h4 class="mb-0">Customer Details</h4>
                        <span class="badge bg-light text-dark">ID: ${customer.partnerId}</span>
                    </div>
                    
                    <div class="card-body">
                        <div class="row mb-3">
                            <label class="col-sm-3 fw-bold">Full Name:</label>
                            <div class="col-sm-9">
                                ${customer.partnerName}
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-3 fw-bold">Email:</label>
                            <div class="col-sm-9">
                                ${customer.partnerEmail}
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-3 fw-bold">Phone:</label>
                            <div class="col-sm-9">
                                ${customer.partnerPhone}
                            </div>
                        </div>
                        
                        <div class="row mb-3">
                            <label class="col-sm-3 fw-bold">Type:</label>
                            <div class="col-sm-9">
                                <c:if test="${customer.type == 2}">Customer</c:if>
                                <c:if test="${customer.type == 1}">Supplier</c:if>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-sm-3 fw-bold">Status:</label>
                            <div class="col-sm-9">
                                <c:choose>
                                    <c:when test="${customer.status == 'active'}">
                                        <span class="badge bg-success">Active</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-danger">Inactive</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <hr>
                        
                        <div class="d-flex justify-content-end">
                            <a href="customer-list" class="btn btn-secondary me-2">Back to List</a>
                            </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>