<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>Customer Details | Laptop WMS</title>
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap"
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
                    max-width: 700px;
                    margin: 2rem auto;
                    padding: 2rem;
                }

                .card {
                    background: white;
                    border-radius: 1rem;
                    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
                    overflow: hidden;
                    border: 1px solid #f1f5f9;
                    animation: fadeIn 0.3s ease-out;
                }

                @keyframes fadeIn {
                    from {
                        opacity: 0;
                        transform: translateY(-10px);
                    }

                    to {
                        opacity: 1;
                        transform: translateY(0);
                    }
                }

                .card-header {
                    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                    color: white;
                    padding: 1.5rem 2rem;
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                }

                .card-header h2 {
                    margin: 0;
                    font-size: 1.375rem;
                    font-weight: 700;
                    display: flex;
                    align-items: center;
                    gap: 0.5rem;
                }

                .id-badge {
                    background: rgba(255, 255, 255, 0.2);
                    padding: 0.375rem 0.875rem;
                    border-radius: 2rem;
                    font-size: 0.8125rem;
                    font-weight: 600;
                }

                .card-body {
                    padding: 2rem;
                }

                .detail-row {
                    display: flex;
                    padding: 1rem 0;
                    border-bottom: 1px solid #f1f5f9;
                }

                .detail-row:last-child {
                    border-bottom: none;
                }

                .detail-label {
                    width: 140px;
                    font-weight: 600;
                    color: #64748b;
                    font-size: 0.875rem;
                }

                .detail-value {
                    flex: 1;
                    font-size: 0.9375rem;
                    color: #1e293b;
                    font-weight: 500;
                }

                .status-badge {
                    display: inline-flex;
                    align-items: center;
                    gap: 0.25rem;
                    padding: 0.375rem 0.875rem;
                    border-radius: 2rem;
                    font-size: 0.6875rem;
                    font-weight: 600;
                    text-transform: uppercase;
                }

                .status-active {
                    background: linear-gradient(135deg, #dcfce7 0%, #bbf7d0 100%);
                    color: #16a34a;
                }

                .status-inactive {
                    background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
                    color: #dc2626;
                }

                .type-badge {
                    display: inline-flex;
                    align-items: center;
                    gap: 0.25rem;
                    padding: 0.375rem 0.875rem;
                    background: linear-gradient(135deg, #fef3c7 0%, #fde68a 100%);
                    color: #d97706;
                    border-radius: 2rem;
                    font-size: 0.6875rem;
                    font-weight: 600;
                    text-transform: uppercase;
                }

                .form-actions {
                    display: flex;
                    justify-content: flex-end;
                    gap: 1rem;
                    margin-top: 1.5rem;
                    padding-top: 1.5rem;
                    border-top: 1px solid #f1f5f9;
                }

                .btn {
                    padding: 0.75rem 1.5rem;
                    border-radius: 0.5rem;
                    font-weight: 600;
                    font-size: 0.875rem;
                    border: none;
                    cursor: pointer;
                    transition: all 0.2s ease;
                    text-decoration: none;
                    display: inline-flex;
                    align-items: center;
                    gap: 0.5rem;
                }

                .btn-back {
                    background: #94a3b8;
                    color: white;
                }

                .btn-back:hover {
                    background: #64748b;
                    color: white;
                }

                .back-link {
                    display: inline-flex;
                    align-items: center;
                    gap: 0.5rem;
                    margin-bottom: 1.5rem;
                    font-size: 0.875rem;
                    color: #64748b;
                    text-decoration: none;
                    font-weight: 500;
                }

                .back-link:hover {
                    color: #667eea;
                }

                @media (max-width: 640px) {
                    .page-container {
                        padding: 1rem;
                        margin: 1rem;
                    }

                    .card-body {
                        padding: 1.5rem;
                    }

                    .detail-row {
                        flex-direction: column;
                        gap: 0.25rem;
                    }

                    .detail-label {
                        width: 100%;
                    }

                    .form-actions {
                        flex-direction: column;
                    }

                    .btn {
                        width: 100%;
                        justify-content: center;
                    }
                }
            </style>
        </head>

        <body>
            <jsp:include page="header.jsp" />

            <div class="page-container">
                <a href="customer-list" class="back-link">← Back to Customers</a>

                <div class="card">
                    <div class="card-header">
                        <h2>🛒 Customer Details</h2>
                        <span class="id-badge">ID: ${customer.partnerId}</span>
                    </div>

                    <div class="card-body">
                        <div class="detail-row">
                            <div class="detail-label">Full Name</div>
                            <div class="detail-value"><strong>${customer.partnerName}</strong></div>
                        </div>

                        <div class="detail-row">
                            <div class="detail-label">Email</div>
                            <div class="detail-value">${empty customer.partnerEmail ? '—' : customer.partnerEmail}</div>
                        </div>

                        <div class="detail-row">
                            <div class="detail-label">Phone</div>
                            <div class="detail-value">${empty customer.partnerPhone ? '—' : customer.partnerPhone}</div>
                        </div>

                        <div class="detail-row">
                            <div class="detail-label">Type</div>
                            <div class="detail-value">
                                <span class="type-badge">
                                    <c:choose>
                                        <c:when test="${customer.type == 1}">🏭 Supplier</c:when>
                                        <c:when test="${customer.type == 2}">🛒 Customer</c:when>
                                    </c:choose>
                                </span>
                            </div>
                        </div>

                        <div class="detail-row">
                            <div class="detail-label">Status</div>
                            <div class="detail-value">
                                <c:choose>
                                    <c:when test="${customer.status == 'active'}">
                                        <span class="status-badge status-active">● Active</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-badge status-inactive">● Inactive</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <div class="form-actions">
                            <a href="customer-list" class="btn btn-back">← Back to List</a>
                        </div>
                    </div>
                </div>
            </div>

            <jsp:include page="footer.jsp" />
        </body>

        </html>