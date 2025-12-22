<%@page import="Model.TicketItem" %>
    <%@page import="Model.Ticket" %>
        <%@page import="java.text.SimpleDateFormat" %>
            <%@page contentType="text/html" pageEncoding="UTF-8" %>
                <!DOCTYPE html>
                <html>

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Ticket Detail | Laptop WMS</title>
                    <link
                        href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap"
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
                            max-width: 1000px;
                            margin: 0 auto;
                            padding: 2rem;
                        }

                        .back-link {
                            display: inline-flex;
                            align-items: center;
                            gap: 0.5rem;
                            margin-bottom: 1.5rem;
                            font-size: 0.875rem;
                            color: #667eea;
                            text-decoration: none;
                            font-weight: 500;
                        }

                        .back-link:hover {
                            color: #764ba2;
                        }

                        .card {
                            background: white;
                            border-radius: 1rem;
                            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
                            padding: 2rem;
                            margin-bottom: 1.5rem;
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

                        .success-message {
                            display: flex;
                            align-items: center;
                            gap: 0.5rem;
                            padding: 1rem 1.25rem;
                            background: linear-gradient(135deg, #dcfce7 0%, #bbf7d0 100%);
                            border: 1px solid #86efac;
                            border-radius: 0.75rem;
                            color: #16a34a;
                            font-weight: 500;
                            margin-bottom: 1.5rem;
                        }

                        .error-message {
                            display: flex;
                            align-items: center;
                            gap: 0.5rem;
                            padding: 1rem 1.25rem;
                            background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
                            border: 1px solid #fca5a5;
                            border-radius: 0.75rem;
                            color: #dc2626;
                            font-weight: 500;
                            margin-bottom: 1.5rem;
                        }

                        .ticket-header {
                            display: flex;
                            justify-content: space-between;
                            align-items: flex-start;
                            flex-wrap: wrap;
                            gap: 1rem;
                            margin-bottom: 1.5rem;
                        }

                        .ticket-code {
                            font-size: 1.75rem;
                            font-weight: 800;
                            color: #1e293b;
                        }

                        .ticket-title {
                            font-size: 1rem;
                            color: #64748b;
                            margin-top: 0.5rem;
                        }

                        .badge-container {
                            display: flex;
                            gap: 0.75rem;
                        }

                        .badge {
                            display: inline-flex;
                            align-items: center;
                            gap: 0.25rem;
                            padding: 0.5rem 1rem;
                            border-radius: 2rem;
                            font-size: 0.75rem;
                            font-weight: 600;
                            text-transform: uppercase;
                        }

                        .type-import {
                            background: linear-gradient(135deg, #dcfce7 0%, #bbf7d0 100%);
                            color: #16a34a;
                        }

                        .type-export {
                            background: linear-gradient(135deg, #fef3c7 0%, #fde68a 100%);
                            color: #d97706;
                        }

                        .status-pending {
                            background: linear-gradient(135deg, #fef3c7 0%, #fde68a 100%);
                            color: #d97706;
                        }

                        .status-completed {
                            background: linear-gradient(135deg, #dcfce7 0%, #bbf7d0 100%);
                            color: #16a34a;
                        }

                        .status-cancelled {
                            background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
                            color: #dc2626;
                        }

                        .info-grid {
                            display: grid;
                            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                            gap: 1rem;
                            margin-bottom: 1.5rem;
                        }

                        .info-item {
                            padding: 1rem;
                            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
                            border-radius: 0.75rem;
                        }

                        .info-label {
                            font-size: 0.6875rem;
                            font-weight: 600;
                            color: #64748b;
                            text-transform: uppercase;
                            letter-spacing: 0.5px;
                            margin-bottom: 0.375rem;
                        }

                        .info-value {
                            font-size: 0.9375rem;
                            font-weight: 600;
                            color: #1e293b;
                        }

                        .description-box {
                            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
                            border-radius: 0.75rem;
                            padding: 1rem;
                            margin-bottom: 1.5rem;
                        }

                        .description-box h3 {
                            font-size: 0.75rem;
                            font-weight: 600;
                            color: #64748b;
                            text-transform: uppercase;
                            letter-spacing: 0.5px;
                            margin-bottom: 0.5rem;
                        }

                        .description-box p {
                            color: #475569;
                            line-height: 1.6;
                            font-size: 0.9375rem;
                        }

                        .section-title {
                            font-size: 1.125rem;
                            font-weight: 700;
                            color: #1e293b;
                            margin-bottom: 1rem;
                            display: flex;
                            align-items: center;
                            gap: 0.5rem;
                        }

                        table {
                            width: 100%;
                            border-collapse: collapse;
                        }

                        th {
                            padding: 1rem;
                            text-align: left;
                            font-size: 0.6875rem;
                            font-weight: 600;
                            text-transform: uppercase;
                            letter-spacing: 0.5px;
                            color: #64748b;
                            background: linear-gradient(135deg, #f8fafc 0%, white 100%);
                            border-bottom: 2px solid #e2e8f0;
                        }

                        td {
                            padding: 1rem;
                            font-size: 0.875rem;
                            color: #475569;
                            border-bottom: 1px solid #f1f5f9;
                        }

                        tbody tr {
                            transition: all 0.2s ease;
                        }

                        tbody tr:hover {
                            background: linear-gradient(135deg, #f8fafc 0%, #f0fdf4 100%);
                        }

                        .keeper-note {
                            background: linear-gradient(135deg, #eff6ff 0%, #dbeafe 100%);
                            border-left: 4px solid #3b82f6;
                            padding: 1rem;
                            border-radius: 0 0.75rem 0.75rem 0;
                            margin-top: 1.5rem;
                        }

                        .keeper-note h4 {
                            color: #2563eb;
                            font-size: 0.875rem;
                            margin-bottom: 0.5rem;
                        }

                        .keeper-note p {
                            color: #1e40af;
                            font-size: 0.9375rem;
                        }

                        .action-buttons {
                            display: flex;
                            gap: 1rem;
                            margin-top: 1.5rem;
                        }

                        .btn {
                            padding: 0.875rem 1.75rem;
                            border-radius: 0.5rem;
                            font-size: 0.9375rem;
                            font-weight: 600;
                            cursor: pointer;
                            border: none;
                            transition: all 0.2s ease;
                            text-decoration: none;
                            display: inline-flex;
                            align-items: center;
                            gap: 0.5rem;
                        }

                        .btn-complete {
                            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
                            color: white;
                            box-shadow: 0 4px 14px rgba(16, 185, 129, 0.4);
                        }

                        .btn-complete:hover {
                            transform: translateY(-2px);
                            box-shadow: 0 6px 20px rgba(16, 185, 129, 0.5);
                        }

                        .btn-cancel {
                            background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
                            color: white;
                            box-shadow: 0 4px 14px rgba(239, 68, 68, 0.4);
                        }

                        .btn-cancel:hover {
                            transform: translateY(-2px);
                            box-shadow: 0 6px 20px rgba(239, 68, 68, 0.5);
                        }

                        .modal-overlay {
                            display: none;
                            position: fixed;
                            top: 0;
                            left: 0;
                            width: 100%;
                            height: 100%;
                            background: rgba(0, 0, 0, 0.5);
                            backdrop-filter: blur(4px);
                            z-index: 1000;
                            justify-content: center;
                            align-items: center;
                        }

                        .modal {
                            background: white;
                            border-radius: 1rem;
                            padding: 2rem;
                            max-width: 500px;
                            width: 90%;
                            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.25);
                            animation: modalIn 0.3s ease-out;
                        }

                        @keyframes modalIn {
                            from {
                                opacity: 0;
                                transform: scale(0.95) translateY(-20px);
                            }

                            to {
                                opacity: 1;
                                transform: scale(1) translateY(0);
                            }
                        }

                        .modal h3 {
                            font-size: 1.25rem;
                            font-weight: 700;
                            color: #1e293b;
                            margin-bottom: 1rem;
                        }

                        .modal label {
                            display: block;
                            font-size: 0.875rem;
                            font-weight: 600;
                            color: #475569;
                            margin-bottom: 0.5rem;
                        }

                        .modal textarea {
                            width: 100%;
                            padding: 0.875rem 1rem;
                            border: 2px solid #e2e8f0;
                            border-radius: 0.5rem;
                            resize: vertical;
                            min-height: 100px;
                            margin-bottom: 1.5rem;
                            font-family: inherit;
                            font-size: 0.9375rem;
                            outline: none;
                            box-sizing: border-box;
                            transition: all 0.2s ease;
                        }

                        .modal textarea:focus {
                            border-color: #667eea;
                            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.15);
                        }

                        .modal-buttons {
                            display: flex;
                            gap: 0.75rem;
                            justify-content: flex-end;
                        }

                        .btn-secondary {
                            background: #e2e8f0;
                            color: #475569;
                        }

                        .btn-secondary:hover {
                            background: #cbd5e1;
                        }

                        @media (max-width: 768px) {
                            .page-container {
                                padding: 1rem;
                            }

                            .card {
                                padding: 1.5rem;
                            }

                            .ticket-header {
                                flex-direction: column;
                            }

                            .action-buttons {
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
                    <%@include file="header.jsp" %>

                        <div class="page-container">
                            <a href="<%= request.getContextPath()%>/ticket-list" class="back-link">← Back to Tickets</a>

                            <% String successMessage=(String) request.getAttribute("successMessage"); %>
                                <% if (successMessage !=null) {%>
                                    <div class="success-message">✓ <%= successMessage%>
                                    </div>
                                    <% } %>

                                        <% String errorMessage=(String) session.getAttribute("errorMessage"); %>
                                            <% if (errorMessage !=null) {%>
                                                <div class="error-message">⚠ <%= errorMessage%>
                                                </div>
                                                <% session.removeAttribute("errorMessage"); %>
                                                    <% } %>

                                                        <% Ticket ticket=(Ticket) request.getAttribute("ticket");
                                                            SimpleDateFormat sdf=new SimpleDateFormat("dd/MM/yyyy HH:mm"); if (ticket !=null) {%>

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
                                                                                ? "📥 IMPORT" : "📤 EXPORT" %>
                                                                        </span>
                                                                        <span
                                                                            class="badge status-<%= ticket.getStatus().toLowerCase()%>">
                                                                            <% if
                                                                                ("COMPLETED".equals(ticket.getStatus()))
                                                                                { %>✓<% } else if
                                                                                    ("PENDING".equals(ticket.getStatus()))
                                                                                    { %>⏳<% } else { %>✗<% } %>
                                                                                            <%= ticket.getStatus()%>
                                                                        </span>
                                                                    </div>
                                                                </div>

                                                                <div class="info-grid">
                                                                    <div class="info-item">
                                                                        <div class="info-label">Created By</div>
                                                                        <div class="info-value">
                                                                            <%= ticket.getCreatorName() !=null ?
                                                                                ticket.getCreatorName() : "-" %>
                                                                        </div>
                                                                    </div>
                                                                    <div class="info-item">
                                                                        <div class="info-label">Assigned Keeper</div>
                                                                        <div class="info-value">
                                                                            <%= ticket.getKeeperName() !=null ?
                                                                                ticket.getKeeperName() : "Not assigned"
                                                                                %>
                                                                        </div>
                                                                    </div>
                                                                    <div class="info-item">
                                                                        <div class="info-label">Created At</div>
                                                                        <div class="info-value">
                                                                            <%= ticket.getCreatedAt() !=null ?
                                                                                sdf.format(ticket.getCreatedAt()) : "-"
                                                                                %>
                                                                        </div>
                                                                    </div>
                                                                    <div class="info-item">
                                                                        <div class="info-label">Processed At</div>
                                                                        <div class="info-value">
                                                                            <%= ticket.getProcessedAt() !=null ?
                                                                                sdf.format(ticket.getProcessedAt())
                                                                                : "-" %>
                                                                        </div>
                                                                    </div>
                                                                    <% if (ticket.getPartnerName() !=null &&
                                                                        !ticket.getPartnerName().isEmpty()) {%>
                                                                        <div class="info-item">
                                                                            <div class="info-label">
                                                                                <%= ticket.getType().equals("IMPORT")
                                                                                    ? "Supplier" : "Customer" %>
                                                                            </div>
                                                                            <div class="info-value">
                                                                                <%= ticket.getPartnerName()%>
                                                                            </div>
                                                                        </div>
                                                                        <% } %>
                                                                </div>

                                                                <% if (ticket.getDescription() !=null &&
                                                                    !ticket.getDescription().isEmpty()) {%>
                                                                    <div class="description-box">
                                                                        <h3>Description</h3>
                                                                        <p>
                                                                            <%= ticket.getDescription()%>
                                                                        </p>
                                                                    </div>
                                                                    <% } %>

                                                                        <% if (ticket.getKeeperNote() !=null &&
                                                                            !ticket.getKeeperNote().isEmpty()) {%>
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
                                                                        <% int index=1; for (TicketItem item :
                                                                            ticket.getItems()) {%>
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

                                                                <% boolean canProcess=(currentUser.getRoleId()==3 ||
                                                                    currentUser.getRoleId()==1) &&
                                                                    ticket.getStatus().equals("PENDING"); if
                                                                    (canProcess) { %>
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
                                                                    <p
                                                                        style="text-align: center; color: #64748b; padding: 2rem;">
                                                                        Ticket not found</p>
                                                                </div>
                                                                <% }%>
                        </div>

                        <!-- Modal -->
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