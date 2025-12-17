    <%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add to Inventory</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body { background-color: #f8f9fa; }
            .card { margin-top: 50px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); }
            .header-title { color: #333; font-weight: bold; margin-bottom: 20px; }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>

        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="card p-4">
                        <h2 class="header-title text-center">Added</h2>

                        <c:if test="${param.error == 'duplicate'}">
                            <div class="alert alert-danger">This products is already in inventory</div>
                        </c:if>
                        <c:if test="${param.error == 'invalid'}">
                            <div class="alert alert-warning">Input is invalid</div>
                        </c:if>
                        <c:if test="${param.error == 'system'}">
                            <div class="alert alert-danger">Cant connect to system</div>
                        </c:if>

                        <form action="add-inventory" method="POST">
                            <div class="mb-3">
                                <label class="form-label fw-bold">Choose a products</label>
                                <select name="productId" class="form-select" required>
                                    <option value="" selected disabled>Choose a products</option>
                                    <c:forEach items="${products}" var="p">
                                        <option value="${p.productId}">${p.productName} (ID: ${p.productId})</option>
                                    </c:forEach>
                                </select>
                                <div class="form-text italic text-muted">Only non localized Products</div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-bold">Choose location:</label>
                                <select name="locationId" class="form-select" required>
                                    <c:forEach items="${locations}" var="l">
                                        <option value="${l.locationId}">${l.locationName}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-bold">Quantity:</label>
                                <input type="text" class="form-control" value="0" readonly disabled>
                                <small class="text-secondary">Quantity set to 0.</small>
                            </div>

                            <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-4">
                                <a href="inventory" class="btn btn-secondary me-md-2">Back</a>
                                <button type="submit" class="btn btn-primary px-4">Submit</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="footer.jsp"></jsp:include>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>