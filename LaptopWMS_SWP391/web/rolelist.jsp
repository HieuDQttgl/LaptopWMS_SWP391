<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Role Status Management | Laptop WMS</title>
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
                    max-width: 900px;
                    margin: 0 auto;
                    padding: 2rem;
                }

                .page-title {
                    font-size: 1.75rem;
                    font-weight: 700;
                    color: #1e293b;
                    margin-bottom: 1.5rem;
                    display: flex;
                    align-items: center;
                    gap: 0.75rem;
                }

                .card {
                    background: white;
                    border-radius: 1rem;
                    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
                    border: 1px solid #f1f5f9;
                    overflow: hidden;
                }

                table {
                    width: 100%;
                    border-collapse: collapse;
                }

                th {
                    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                    color: white;
                    padding: 1rem 1.25rem;
                    text-align: left;
                    font-size: 0.8125rem;
                    font-weight: 600;
                    text-transform: uppercase;
                    letter-spacing: 0.5px;
                }

                td {
                    padding: 1rem 1.25rem;
                    font-size: 0.9375rem;
                    border-bottom: 1px solid #f1f5f9;
                    color: #475569;
                }

                tr:hover td {
                    background: #f8fafc;
                }

                .role-name {
                    font-weight: 600;
                    color: #1e293b;
                }

                .badge {
                    display: inline-flex;
                    align-items: center;
                    gap: 0.25rem;
                    padding: 0.375rem 0.75rem;
                    border-radius: 2rem;
                    font-size: 0.75rem;
                    font-weight: 600;
                }

                .badge-active {
                    background: linear-gradient(135deg, #dcfce7 0%, #bbf7d0 100%);
                    color: #16a34a;
                }

                .badge-inactive {
                    background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
                    color: #dc2626;
                }

                .btn {
                    padding: 0.5rem 1rem;
                    border-radius: 0.5rem;
                    font-weight: 600;
                    font-size: 0.75rem;
                    cursor: pointer;
                    transition: all 0.2s ease;
                    border: none;
                    color: white;
                }

                .btn-activate {
                    background: linear-gradient(135deg, #10b981 0%, #059669 100%);
                }

                .btn-activate:hover {
                    transform: translateY(-1px);
                    box-shadow: 0 4px 12px rgba(16, 185, 129, 0.4);
                }

                .btn-deactivate {
                    background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
                }

                .btn-deactivate:hover {
                    transform: translateY(-1px);
                    box-shadow: 0 4px 12px rgba(239, 68, 68, 0.4);
                }

                .empty-state {
                    text-align: center;
                    padding: 3rem;
                    color: #94a3b8;
                }

                @media (max-width: 768px) {
                    .page-container {
                        padding: 1rem;
                    }

                    th,
                    td {
                        padding: 0.75rem;
                    }
                }
            </style>
        </head>

        <body>
            <jsp:include page="header.jsp" />

            <div class="page-container">
                <h1 class="page-title">🛡️ Role Status Management</h1>

                <div class="card">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Role Name</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="role" items="${roles}">
                                <tr>
                                    <td>${role.roleId}</td>
                                    <td class="role-name">${role.roleName}</td>
                                    <td>
                                        <c:if test="${role.status eq 'active'}">
                                            <span class="badge badge-active">✓ Active</span>
                                        </c:if>
                                        <c:if test="${role.status ne 'active'}">
                                            <span class="badge badge-inactive">✗ Inactive</span>
                                        </c:if>
                                    </td>
                                    <td>
                                        <c:if test="${role.status eq 'active'}">
                                            <button class="btn btn-deactivate" type="button"
                                                onclick="confirmStatusChange('role-status?roleId=${role.roleId}&status=${role.status}', 'this role', true)">Deactivate</button>
                                        </c:if>
                                        <c:if test="${role.status ne 'active'}">
                                            <button class="btn btn-activate" type="button"
                                                onclick="confirmStatusChange('role-status?roleId=${role.roleId}&status=${role.status}', 'this role', false)">Activate</button>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>

                            <c:if test="${empty roles}">
                                <tr>
                                    <td colspan="4" class="empty-state">No roles found.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>

            <%@include file="common-dialogs.jsp" %>
                <jsp:include page="footer.jsp" />
        </body>

        </html>