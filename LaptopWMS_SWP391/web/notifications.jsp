<%@ page contentType="text/html;charset=UTF-8" %>
    <%@ page import="java.util.List" %>
        <%@ page import="Model.Notification" %>
            <%@ page import="Model.Users" %>
                <!DOCTYPE html>
                <html>

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Notifications | Laptop WMS</title>
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
                            max-width: 900px;
                            margin: 0 auto;
                            padding: 2rem;
                        }

                        .page-header {
                            display: flex;
                            justify-content: space-between;
                            align-items: center;
                            margin-bottom: 1.5rem;
                        }

                        .page-title {
                            font-size: 1.75rem;
                            font-weight: 700;
                            color: #1e293b;
                            display: flex;
                            align-items: center;
                            gap: 0.75rem;
                        }

                        .btn {
                            padding: 0.625rem 1.25rem;
                            border-radius: 0.5rem;
                            font-weight: 600;
                            font-size: 0.875rem;
                            cursor: pointer;
                            transition: all 0.2s ease;
                            text-decoration: none;
                            display: inline-flex;
                            align-items: center;
                            gap: 0.5rem;
                            border: none;
                        }

                        .btn-primary {
                            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                            color: white;
                            box-shadow: 0 4px 14px rgba(102, 126, 234, 0.4);
                        }

                        .btn-primary:hover {
                            transform: translateY(-1px);
                            box-shadow: 0 6px 18px rgba(102, 126, 234, 0.5);
                        }

                        .alert {
                            display: flex;
                            align-items: center;
                            gap: 0.5rem;
                            padding: 1rem 1.25rem;
                            border-radius: 0.75rem;
                            margin-bottom: 1.5rem;
                            font-weight: 500;
                        }

                        .alert-success {
                            background: linear-gradient(135deg, #dcfce7 0%, #bbf7d0 100%);
                            color: #16a34a;
                            border: 1px solid #86efac;
                        }

                        .alert-error {
                            background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
                            color: #dc2626;
                            border: 1px solid #fca5a5;
                        }

                        .stats-bar {
                            display: flex;
                            gap: 1rem;
                            margin-bottom: 1.5rem;
                        }

                        .stat-item {
                            background: white;
                            padding: 1.25rem 1.5rem;
                            border-radius: 0.75rem;
                            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
                            border: 1px solid #f1f5f9;
                        }

                        .stat-number {
                            font-size: 2rem;
                            font-weight: 800;
                            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                            -webkit-background-clip: text;
                            -webkit-text-fill-color: transparent;
                            background-clip: text;
                        }

                        .stat-label {
                            font-size: 0.75rem;
                            color: #64748b;
                            margin-top: 0.25rem;
                            text-transform: uppercase;
                            font-weight: 600;
                            letter-spacing: 0.5px;
                        }

                        .notification-card {
                            background: white;
                            border-radius: 1rem;
                            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
                            border: 1px solid #f1f5f9;
                            overflow: hidden;
                        }

                        .notification-item {
                            display: flex;
                            align-items: flex-start;
                            padding: 1.25rem 1.5rem;
                            border-bottom: 1px solid #f1f5f9;
                            cursor: pointer;
                            transition: all 0.2s ease;
                        }

                        .notification-item:last-child {
                            border-bottom: none;
                        }

                        .notification-item:hover {
                            background: #f8fafc;
                        }

                        .notification-item.unread {
                            background: linear-gradient(135deg, #eff6ff 0%, #f0fdf4 100%);
                            border-left: 4px solid #667eea;
                        }

                        .notification-icon {
                            width: 48px;
                            height: 48px;
                            border-radius: 50%;
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            margin-right: 1rem;
                            font-size: 1.25rem;
                            background: linear-gradient(135deg, #e0e7ff 0%, #f0fdf4 100%);
                            flex-shrink: 0;
                        }

                        .notification-body {
                            flex: 1;
                            min-width: 0;
                        }

                        .notification-title {
                            font-size: 0.9375rem;
                            font-weight: 600;
                            color: #1e293b;
                            margin-bottom: 0.375rem;
                        }

                        .notification-message {
                            font-size: 0.875rem;
                            color: #64748b;
                            line-height: 1.5;
                            display: -webkit-box;
                            -webkit-line-clamp: 2;
                            -webkit-box-orient: vertical;
                            overflow: hidden;
                        }

                        .notification-meta {
                            display: flex;
                            gap: 1rem;
                            margin-top: 0.625rem;
                            font-size: 0.75rem;
                            color: #94a3b8;
                        }

                        .notification-actions {
                            display: flex;
                            gap: 0.5rem;
                            margin-left: 1rem;
                        }

                        .action-btn {
                            padding: 0.375rem 0.75rem;
                            border-radius: 0.375rem;
                            border: 1px solid #e2e8f0;
                            background: white;
                            font-size: 0.6875rem;
                            font-weight: 600;
                            cursor: pointer;
                            transition: all 0.15s ease;
                        }

                        .action-btn.mark-read {
                            border-color: #667eea;
                            color: #667eea;
                        }

                        .action-btn.mark-read:hover {
                            background: #eff6ff;
                        }

                        .action-btn.delete {
                            border-color: #ef4444;
                            color: #ef4444;
                        }

                        .action-btn.delete:hover {
                            background: #fef2f2;
                        }

                        .empty-state {
                            text-align: center;
                            padding: 4rem 2rem;
                            color: #94a3b8;
                        }

                        .empty-state-icon {
                            font-size: 4rem;
                            margin-bottom: 1rem;
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
                            backdrop-filter: blur(4px);
                        }

                        .modal-overlay.show {
                            display: flex;
                        }

                        .modal {
                            background: white;
                            border-radius: 1rem;
                            width: 90%;
                            max-width: 600px;
                            max-height: 80vh;
                            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.25);
                            overflow: hidden;
                            animation: modalSlideIn 0.2s ease-out;
                        }

                        @keyframes modalSlideIn {
                            from {
                                opacity: 0;
                                transform: translateY(-20px) scale(0.95);
                            }

                            to {
                                opacity: 1;
                                transform: translateY(0) scale(1);
                            }
                        }

                        .modal-header {
                            display: flex;
                            justify-content: space-between;
                            align-items: flex-start;
                            padding: 1.5rem;
                            border-bottom: 1px solid #f1f5f9;
                        }

                        .modal-header h2 {
                            margin: 0;
                            font-size: 1.25rem;
                            font-weight: 700;
                            color: #1e293b;
                        }

                        .modal-close {
                            background: none;
                            border: none;
                            font-size: 1.5rem;
                            cursor: pointer;
                            color: #94a3b8;
                            padding: 0;
                        }

                        .modal-body {
                            padding: 1.5rem;
                            max-height: 50vh;
                            overflow-y: auto;
                        }

                        .modal-message {
                            font-size: 0.9375rem;
                            line-height: 1.7;
                            color: #475569;
                            white-space: pre-wrap;
                        }

                        .modal-meta {
                            padding: 1rem 1.5rem;
                            background: #f8fafc;
                            border-top: 1px solid #f1f5f9;
                            font-size: 0.8125rem;
                            color: #64748b;
                            display: flex;
                            gap: 1rem;
                        }

                        .modal-footer {
                            display: flex;
                            justify-content: flex-end;
                            gap: 0.75rem;
                            padding: 1rem 1.5rem;
                            border-top: 1px solid #f1f5f9;
                        }

                        .btn-outline {
                            background: white;
                            color: #475569;
                            border: 1px solid #e2e8f0;
                        }

                        .btn-outline:hover {
                            background: #f1f5f9;
                        }

                        @media (max-width: 768px) {
                            .page-container {
                                padding: 1rem;
                            }

                            .page-header {
                                flex-direction: column;
                                gap: 1rem;
                                align-items: flex-start;
                            }

                            .stats-bar {
                                flex-direction: column;
                            }
                        }
                    </style>
                </head>

                <body>
                    <jsp:include page="header.jsp" />

                    <div class="page-container">
                        <% Users currentUser=(Users) session.getAttribute("currentUser"); List<Notification>
                            notifications = (List<Notification>) request.getAttribute("notifications");
                                Integer unreadCount = (Integer) request.getAttribute("unreadCount");
                                String message = request.getParameter("msg");
                                String error = request.getParameter("error");
                                if (unreadCount == null) unreadCount = 0;
                                %>

                                <% if (message !=null) { %>
                                    <div class="alert alert-success">✓ <%= message %>
                                    </div>
                                    <% } %>

                                        <% if (error !=null) { %>
                                            <div class="alert alert-error">⚠ <%= error %>
                                            </div>
                                            <% } %>

                                                <div class="page-header">
                                                    <h1 class="page-title">🔔 Notifications</h1>
                                                    <% if (notifications !=null && !notifications.isEmpty() &&
                                                        unreadCount> 0) { %>
                                                        <button class="btn btn-primary" onclick="markAllAsRead()">✓ Mark
                                                            All Read</button>
                                                        <% } %>
                                                </div>

                                                <div class="stats-bar">
                                                    <div class="stat-item">
                                                        <div class="stat-number">
                                                            <%= unreadCount %>
                                                        </div>
                                                        <div class="stat-label">Unread</div>
                                                    </div>
                                                    <div class="stat-item">
                                                        <div class="stat-number">
                                                            <%= notifications !=null ? notifications.size() : 0 %>
                                                        </div>
                                                        <div class="stat-label">Total</div>
                                                    </div>
                                                </div>

                                                <div class="notification-card">
                                                    <% if (notifications==null || notifications.isEmpty()) { %>
                                                        <div class="empty-state">
                                                            <div class="empty-state-icon">🔔</div>
                                                            <h3 style="margin: 0 0 0.5rem; color: #1e293b;">No
                                                                notifications yet</h3>
                                                            <p style="margin: 0;">When you receive notifications, they
                                                                will appear here.</p>
                                                        </div>
                                                        <% } else { %>
                                                            <% for (Notification n : notifications) { String
                                                                unreadClass=!n.isRead() ? "unread" : "" ; String
                                                                createdAtStr=n.getCreatedAt() !=null ? new
                                                                java.text.SimpleDateFormat("MMM dd, yyyy HH:mm").format(n.getCreatedAt()) : "Unknown" ; String
                                                                escapedTitle=n.getTitle().replace("'", "\\'"
                                                                ).replace("\n", "\\n" ).replace("\r", "" ); String
                                                                escapedMessage=n.getMessage().replace("'", "\\'"
                                                                ).replace("\n", "\\n" ).replace("\r", "" ); String
                                                                link=n.getLink() !=null ? n.getLink() : "" ; %>
                                                                <div class="notification-item <%= unreadClass %>"
                                                                    id="notification-<%= n.getNotificationId() %>"
                                                                    onclick="openModal('<%= escapedTitle %>', '<%= escapedMessage %>', '<%= createdAtStr %>', <%= n.isRead() %>, <%= n.getNotificationId() %>, '<%= link %>')">
                                                                    <div class="notification-icon">📢</div>
                                                                    <div class="notification-body">
                                                                        <div class="notification-title">
                                                                            <%= n.getTitle() %>
                                                                        </div>
                                                                        <div class="notification-message">
                                                                            <%= n.getMessage() %>
                                                                        </div>
                                                                        <div class="notification-meta">
                                                                            <span>📅 <%= createdAtStr %></span>
                                                                            <% if (n.isRead()) { %><span>✓ Read</span>
                                                                                <% } %>
                                                                        </div>
                                                                    </div>
                                                                    <div class="notification-actions"
                                                                        onclick="event.stopPropagation()">
                                                                        <% if (!n.isRead()) { %>
                                                                            <button class="action-btn mark-read"
                                                                                onclick="markAsRead(<%= n.getNotificationId() %>)">Mark
                                                                                Read</button>
                                                                            <% } %>
                                                                                <button class="action-btn delete"
                                                                                    onclick="deleteNotification(<%= n.getNotificationId() %>)">Delete</button>
                                                                    </div>
                                                                </div>
                                                                <% } %>
                                                                    <% } %>
                                                </div>
                    </div>

                    <div class="modal-overlay" id="notificationModal" onclick="closeModal(event)">
                        <div class="modal" onclick="event.stopPropagation()">
                            <div class="modal-header">
                                <h2 id="modalTitle"></h2>
                                <button class="modal-close" onclick="closeModal()">&times;</button>
                            </div>
                            <div class="modal-body">
                                <div class="modal-message" id="modalMessage"></div>
                            </div>
                            <div class="modal-meta">
                                <span id="modalDate"></span>
                                <span id="modalStatus"></span>
                            </div>
                            <div class="modal-footer">
                                <button class="btn btn-outline" onclick="closeModal()">Close</button>
                                <a class="btn btn-primary" id="modalGoTo" style="display: none;" href="#">➡️ Go to
                                    Details</a>
                                <button class="btn btn-primary" id="modalMarkRead" style="display: none;"
                                    onclick="markAsReadFromModal()">Mark as Read</button>
                            </div>
                        </div>
                    </div>

                    <jsp:include page="footer.jsp" />

                    <script>
                        var currentNotificationId = null;

                        function openModal(title, message, date, isRead, notificationId, link) {
                            currentNotificationId = notificationId;
                            document.getElementById('modalTitle').textContent = title.replace(/\\n/g, '\n').replace(/\\'/g, "'");
                            document.getElementById('modalMessage').textContent = message.replace(/\\n/g, '\n').replace(/\\'/g, "'");
                            document.getElementById('modalDate').textContent = '📅 ' + date;
                            document.getElementById('modalStatus').textContent = isRead ? '✓ Read' : '○ Unread';

                            document.getElementById('modalMarkRead').style.display = isRead ? 'none' : 'inline-flex';

                            var goToBtn = document.getElementById('modalGoTo');
                            if (link && link.length > 0) {
                                goToBtn.style.display = 'inline-flex';
                                goToBtn.href = contextPath + link;
                            } else {
                                goToBtn.style.display = 'none';
                            }

                            document.getElementById('notificationModal').classList.add('show');
                            document.body.style.overflow = 'hidden';
                        }

                        function closeModal(event) {
                            if (event && event.target !== document.getElementById('notificationModal')) return;
                            document.getElementById('notificationModal').classList.remove('show');
                            document.body.style.overflow = '';
                            currentNotificationId = null;
                        }

                        function markAsReadFromModal() {
                            if (currentNotificationId) markAsRead(currentNotificationId);
                        }

                        function markAsRead(id) {
                            fetch(contextPath + '/notifications?action=markRead&id=' + id, { method: 'POST' })
                                .then(r => r.json())
                                .then(result => { if (result.success) location.reload(); else showToast('error', 'Failed', result.message); })
                                .catch(() => showToast('error', 'Error', 'Failed to mark as read'));
                        }

                        function markAllAsRead() {
                            fetch(contextPath + '/notifications?action=markAllRead', { method: 'POST' })
                                .then(r => r.json())
                                .then(result => { if (result.success) location.reload(); })
                                .catch(() => showToast('error', 'Error', 'Failed to mark all as read'));
                        }

                        function deleteNotification(id) {
                            showConfirm({
                                icon: '🗑️',
                                title: 'Delete Notification?',
                                message: 'This action cannot be undone.',
                                confirmText: 'Delete',
                                type: 'danger',
                                onConfirm: function () {
                                    fetch(contextPath + '/notifications?action=delete&id=' + id, { method: 'POST' })
                                        .then(r => r.json())
                                        .then(result => { if (result.success) location.reload(); else showToast('error', 'Failed', result.message); })
                                        .catch(() => showToast('error', 'Error', 'Failed to delete'));
                                }
                            });
                        }

                        document.addEventListener('keydown', e => { if (e.key === 'Escape') closeModal(); });
                    </script>
                    <%@include file="common-dialogs.jsp" %>
                </body>

                </html>