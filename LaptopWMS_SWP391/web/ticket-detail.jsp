<%@page import="Model.TicketItem" %>
<%@page import="Model.Ticket" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Ticket Detail - WMS</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: #f1f5f9;
                min-height: 100vh;
            }

            .container {
                max-width: 1000px;
                margin: 0 auto;
                padding: 30px 20px;
            }

            .btn-back {
                display: inline-block;
                color: #667eea;
                text-decoration: none;
                margin-bottom: 20px;
                font-weight: 500;
            }

            .btn-back:hover {
                text-decoration: underline;
            }

            .card {
                background: #fff;
                border-radius: 16px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
                padding: 32px;
                margin-bottom: 24px;
            }

            .ticket-header {
                display: flex;
                justify-content: space-between;
                align-items: flex-start;
                margin-bottom: 24px;
                flex-wrap: wrap;
                gap: 16px;
            }

            .ticket-code {
                font-size: 28px;
                font-weight: 700;
                color: #1e293b;
            }

            .ticket-title {
                font-size: 18px;
                color: #64748b;
                margin-top: 8px;
            }

            .badge-container {
                display: flex;
                gap: 12px;
            }

            .badge {
                display: inline-block;
                padding: 8px 16px;
                border-radius: 20px;
                font-size: 14px;
                font-weight: 600;
            }

            .type-import {
                background: #dcfce7;
                color: #16a34a;
            }

            .type-export {
                background: #fef3c7;
                color: #d97706;
            }

            .status-pending {
                background: #fef3c7;
                color: #d97706;
            }

            .status-completed {
                background: #dcfce7;
                color: #16a34a;
            }

            .status-cancelled {
                background: #fee2e2;
                color: #dc2626;
            }

            .info-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 24px;
                margin-bottom: 24px;
            }

            .info-item {
                padding: 16px;
                background: #f8fafc;
                border-radius: 12px;
            }

            .info-label {
                font-size: 13px;
                color: #64748b;
                margin-bottom: 6px;
            }

            .info-value {
                font-size: 16px;
                font-weight: 600;
                color: #1e293b;
            }

            .description-box {
                background: #f8fafc;
                border-radius: 12px;
                padding: 16px;
                margin-bottom: 24px;
            }

            .description-box h3 {
                font-size: 14px;
                color: #64748b;
                margin-bottom: 8px;
            }

            .description-box p {
                color: #374151;
                line-height: 1.6;
            }

            .section-title {
                font-size: 18px;
                font-weight: 600;
                color: #1e293b;
                margin-bottom: 16px;
                display: flex;
                align-items: center;
                gap: 8px;
            }

            table {
                width: 100%;
                border-collapse: collapse;
            }

            th,
            td {
                padding: 14px 16px;
                text-align: left;
            }

            th {
                background: #f8fafc;
                font-weight: 600;
                color: #475569;
                font-size: 13px;
                text-transform: uppercase;
            }

            tr {
                border-bottom: 1px solid #f1f5f9;
            }

            .keeper-note {
                background: #eff6ff;
                border-left: 4px solid #3b82f6;
                padding: 16px;
                border-radius: 0 12px 12px 0;
                margin-top: 24px;
            }

            .keeper-note h4 {
                color: #3b82f6;
                margin-bottom: 8px;
            }

            .action-buttons {
                display: flex;
                gap: 16px;
                margin-top: 24px;
            }

            .btn {
                padding: 14px 28px;
                border-radius: 10px;
                font-size: 15px;
                font-weight: 600;
                cursor: pointer;
                border: none;
                transition: all 0.3s;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 8px;
            }

            .btn-complete {
                background: #10b981;
                color: white;
            }

            .btn-complete:hover {
                background: #059669;
            }

            .btn-cancel {
                background: #ef4444;
                color: white;
            }

            .btn-cancel:hover {
                background: #dc2626;
            }

            .success-message {
                background: #dcfce7;
                border: 1px solid #86efac;
                color: #16a34a;
                padding: 12px 20px;
                border-radius: 10px;
                margin-bottom: 20px;
            }

            .error-message {
                background: #fee2e2;
                border: 1px solid #fecaca;
                color: #dc2626;
                padding: 12px 20px;
                border-radius: 10px;
                margin-bottom: 20px;
            }

            .modal-overlay {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5);
                z-index: 1000;
                justify-content: center;
                align-items: center;
            }

            .modal {
                background: white;
                border-radius: 16px;
                padding: 32px;
                max-width: 500px;
                width: 90%;
            }

            .modal h3 {
                margin-bottom: 16px;
            }

            .modal textarea {
                width: 100%;
                padding: 12px;
                border: 2px solid #e5e7eb;
                border-radius: 10px;
                resize: vertical;
                min-height: 100px;
                margin-bottom: 16px;
            }

            .modal-buttons {
                display: flex;
                gap: 12px;
                justify-content: flex-end;
            }

            .btn-secondary {
                background: #e5e7eb;
                color: #374151;
            }
        </style>
    </head>

    <body>
        <%@include file="header.jsp" %>

        <div class="container">
            <a href="<%= request.getContextPath()%>/ticket-list" class="btn-back">← Back to Tickets</a>

            <% String successMessage = (String) request.getAttribute("successMessage"); %>
            <% if (successMessage != null) {%>
            <div class="success-message">✓ <%= successMessage%>
            </div>
            <% } %>

            <% String errorMessage = (String) session.getAttribute("errorMessage"); %>
            <% if (errorMessage != null) {%>
            <div class="error-message">⚠ <%= errorMessage%>
            </div>
            <% session.removeAttribute("errorMessage"); %>
            <% } %>

            <% Ticket ticket = (Ticket) request.getAttribute("ticket");
                SimpleDateFormat sdf = new SimpleDateFormat(
                        "dd/MM/yyyy HH:mm");
                if (ticket != null) {%>

            <div class="card">
                <div class="ticket-header">
                    <div>
                        <div class="ticket-code">
                            <%= ticket.getTicketCode()%>
                        </div>
                        <div class="ticket-title">
                            <%= ticket.getTitle()%>
                        </div>
                    </div>
                    <div class="badge-container">
                        <span
                            class="badge type-<%= ticket.getType().toLowerCase()%>">
                            <%= ticket.getType().equals("IMPORT")
                                    ? "📥 IMPORT" : "📤 EXPORT"%>
                        </span>
                        <span
                            class="badge status-<%= ticket.getStatus().toLowerCase()%>">
                            <%= ticket.getStatus()%>
                        </span>
                    </div>
                </div>

                <div class="info-grid">
                    <div class="info-item">
                        <div class="info-label">Created By</div>
                        <div class="info-value">
                            <%= ticket.getCreatorName() != null
                                    ? ticket.getCreatorName() : "-"%>
                        </div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Assigned Keeper</div>
                        <div class="info-value">
                            <%= ticket.getKeeperName() != null
                                    ? ticket.getKeeperName() : "Not assigned"%>
                        </div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Created At</div>
                        <div class="info-value">
                            <%= ticket.getCreatedAt() != null
                                    ? sdf.format(ticket.getCreatedAt()) : "-"%>
                        </div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Processed At</div>
                        <div class="info-value">
                            <%= ticket.getProcessedAt() != null
                                    ? sdf.format(ticket.getProcessedAt())
                                    : "-"%>
                        </div>
                    </div>
                    <% if (ticket.getPartnerName() != null
                                && !ticket.getPartnerName().isEmpty()) {%>
                    <div class="info-item">
                        <div class="info-label">
                            <%= ticket.getType().equals("IMPORT")
                                    ? "Supplier" : "Customer"%>
                        </div>
                        <div class="info-value">
                            <%= ticket.getPartnerName()%>
                        </div>
                    </div>
                    <% } %>
                </div>

                <% if (ticket.getDescription() != null
                            && !ticket.getDescription().isEmpty()) {%>
                <div class="description-box">
                    <h3>Description</h3>
                    <p>
                        <%= ticket.getDescription()%>
                    </p>
                </div>
                <% } %>

                <% if (ticket.getKeeperNote() != null
                            && !ticket.getKeeperNote().isEmpty()) {%>
                <div class="keeper-note">
                    <h4>📝 Keeper Note</h4>
                    <p>
                        <%= ticket.getKeeperNote()%>
                    </p>
                </div>
                <% } %>
            </div>

            <div class="card">
                <h3 class="section-title">📦 Items</h3>
                <table>
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Product</th>
                            <th>Configuration</th>
                            <th>Quantity</th>
                            <th>Current Stock</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% int index = 1;
                            for (TicketItem item
                                    : ticket.getItems()) {%>
                        <tr>
                            <td>
                                <%= index++%>
                            </td>
                            <td><strong>
                                    <%= item.getProductName()%>
                                </strong></td>
                            <td>
                                <%= item.getProductConfig()%>
                            </td>
                            <td><strong>
                                    <%= item.getQuantity()%>
                                </strong></td>
                            <td>
                                <%= item.getCurrentStock()%>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>

                <% // Show action buttons for Keeper or Admin when ticket is PENDING 
                    boolean canProcess = (currentUser.getRoleId() == 3
                            || currentUser.getRoleId() == 1)
                            && ticket.getStatus().equals("PENDING");
                    if (canProcess) { %>
                <div class="action-buttons">
                    <button class="btn btn-complete"
                            onclick="showModal('complete')">✓
                        Complete</button>
                    <button class="btn btn-cancel"
                            onclick="showModal('cancel')">✕
                        Cancel</button>
                </div>
                <% } %>
            </div>

            <% } else { %>
            <div class="card">
                <p>Ticket not found</p>
            </div>
            <% }%>
        </div>

        <!-- Modal for Complete/Cancel -->
        <div class="modal-overlay" id="actionModal">
            <div class="modal">
                <h3 id="modalTitle">Confirm Action</h3>
                <form method="post" action="<%= request.getContextPath()%>/process-ticket">
                    <input type="hidden" name="ticketId"
                           value="<%= ticket != null ? ticket.getTicketId() : ""%>">
                    <input type="hidden" name="action" id="modalAction">
                    <label>Note (optional):</label>
                    <textarea name="keeperNote" placeholder="Enter your note..."></textarea>
                    <div class="modal-buttons">
                        <button type="button" class="btn btn-secondary"
                                onclick="hideModal()">Cancel</button>
                        <button type="submit" class="btn" id="modalSubmitBtn">Confirm</button>
                    </div>
                </form>
            </div>
        </div>

        <script>
            function showModal(action) {
                document.getElementById('actionModal').style.display = 'flex';
                document.getElementById('modalAction').value = action;

                const submitBtn = document.getElementById('modalSubmitBtn');
                if (action === 'complete') {
                    document.getElementById('modalTitle').textContent = '✓ Complete Ticket';
                    submitBtn.textContent = 'Complete';
                    submitBtn.className = 'btn btn-complete';
                } else {
                    document.getElementById('modalTitle').textContent = '✕ Cancel Ticket';
                    submitBtn.textContent = 'Cancel Ticket';
                    submitBtn.className = 'btn btn-cancel';
                }
            }

            function hideModal() {
                document.getElementById('actionModal').style.display = 'none';
            }

            document.getElementById('actionModal').addEventListener('click', function (e) {
                if (e.target === this) {
                    hideModal();
                }
            });
        </script>
    </body>

</html>