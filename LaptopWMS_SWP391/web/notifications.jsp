<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.Notification" %>
<%@ page import="Model.Users" %>
<!DOCTYPE html>
<html>

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Laptop Warehouse Management System</title>
        <style>
            :root {
                --primary-color: #2563eb;
                --primary-hover: #1d4ed8;
                --danger-color: #dc2626;
                --success-color: #16a34a;
                --bg-color: #f8fafc;
                --card-bg: #ffffff;
                --border-color: #e2e8f0;
                --text-main: #1e293b;
                --text-muted: #64748b;
            }

            * {
                box-sizing: border-box;
            }

            body {
                margin: 0;
                font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
                background: var(--bg-color);
                color: var(--text-main);
            }

            .container {
                max-width: 900px;
                margin: 0 auto;
                padding: 30px 20px;
            }

            .page-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 24px;
            }

            .page-header h1 {
                margin: 0;
                font-size: 28px;
                font-weight: 600;
                color: var(--text-main);
            }

            .header-actions {
                display: flex;
                gap: 10px;
            }

            .btn {
                padding: 10px 18px;
                border-radius: 8px;
                border: none;
                font-size: 14px;
                font-weight: 500;
                cursor: pointer;
                transition: all 0.15s ease;
                text-decoration: none;
                display: inline-flex;
                align-items: center;
                gap: 6px;
            }

            .btn-primary {
                background: var(--primary-color);
                color: white;
            }

            .btn-primary:hover {
                background: var(--primary-hover);
            }

            .btn-outline {
                background: white;
                color: var(--text-main);
                border: 1px solid var(--border-color);
            }

            .btn-outline:hover {
                background: var(--bg-color);
            }

            .btn-danger {
                background: var(--danger-color);
                color: white;
            }

            .btn-danger:hover {
                background: #b91c1c;
            }

            .stats-bar {
                display: flex;
                gap: 20px;
                margin-bottom: 24px;
            }

            .stat-item {
                background: var(--card-bg);
                padding: 16px 24px;
                border-radius: 10px;
                border: 1px solid var(--border-color);
            }

            .stat-number {
                font-size: 28px;
                font-weight: 700;
                color: var(--primary-color);
            }

            .stat-label {
                font-size: 13px;
                color: var(--text-muted);
                margin-top: 4px;
            }

            .notification-card {
                background: var(--card-bg);
                border-radius: 12px;
                border: 1px solid var(--border-color);
                overflow: hidden;
            }

            .notification-item {
                display: flex;
                align-items: flex-start;
                padding: 18px 24px;
                border-bottom: 1px solid var(--border-color);
                transition: background 0.15s;
                cursor: pointer;
            }

            .notification-item:last-child {
                border-bottom: none;
            }

            .notification-item:hover {
                background: var(--bg-color);
            }

            .notification-item.unread {
                background: #eff6ff;
                border-left: 4px solid var(--primary-color);
            }

            .notification-item.unread:hover {
                background: #dbeafe;
            }

            .notification-icon {
                width: 48px;
                height: 48px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                margin-right: 16px;
                flex-shrink: 0;
                font-size: 20px;
                background: #e0e7ff;
                color: #4f46e5;
            }

            .notification-body {
                flex: 1;
                min-width: 0;
            }

            .notification-title {
                font-size: 15px;
                font-weight: 600;
                color: var(--text-main);
                margin-bottom: 6px;
            }

            .notification-message {
                font-size: 14px;
                color: var(--text-muted);
                line-height: 1.5;
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
                overflow: hidden;
                text-overflow: ellipsis;
            }

            .notification-meta {
                display: flex;
                align-items: center;
                gap: 16px;
                margin-top: 10px;
                font-size: 12px;
                color: var(--text-muted);
            }

            .notification-actions {
                display: flex;
                gap: 8px;
                margin-left: 16px;
            }

            .action-btn {
                padding: 6px 12px;
                border-radius: 6px;
                border: 1px solid var(--border-color);
                background: white;
                font-size: 12px;
                cursor: pointer;
                transition: all 0.15s;
            }

            .action-btn:hover {
                background: var(--bg-color);
            }

            .action-btn.mark-read {
                border-color: var(--primary-color);
                color: var(--primary-color);
            }

            .action-btn.mark-read:hover {
                background: #eff6ff;
            }

            .action-btn.delete {
                border-color: var(--danger-color);
                color: var(--danger-color);
            }

            .action-btn.delete:hover {
                background: #fef2f2;
            }

            .empty-state {
                text-align: center;
                padding: 60px 40px;
                color: var(--text-muted);
            }

            .empty-state-icon {
                font-size: 48px;
                margin-bottom: 16px;
            }

            .empty-state h3 {
                margin: 0 0 8px;
                color: var(--text-main);
                font-size: 18px;
            }

            .empty-state p {
                margin: 0;
                font-size: 14px;
            }

            .alert {
                padding: 12px 16px;
                border-radius: 8px;
                margin-bottom: 20px;
                font-size: 14px;
            }

            .alert-success {
                background: #dcfce7;
                color: #166534;
                border: 1px solid #bbf7d0;
            }

            .alert-error {
                background: #fee2e2;
                color: #991b1b;
                border: 1px solid #fecaca;
            }

            /* Modal Styles */
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

            .modal-overlay.show {
                display: flex;
            }

            .modal {
                background: white;
                border-radius: 16px;
                width: 90%;
                max-width: 600px;
                max-height: 80vh;
                box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
                overflow: hidden;
                animation: modalSlideIn 0.2s ease-out;
            }

            @keyframes modalSlideIn {
                from {
                    opacity: 0;
                    transform: translateY(-20px);
                }

                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .modal-header {
                display: flex;
                justify-content: space-between;
                align-items: flex-start;
                padding: 24px 24px 16px;
                border-bottom: 1px solid var(--border-color);
            }

            .modal-header h2 {
                margin: 0;
                font-size: 20px;
                font-weight: 600;
                color: var(--text-main);
                line-height: 1.4;
            }

            .modal-close {
                background: none;
                border: none;
                font-size: 24px;
                cursor: pointer;
                color: var(--text-muted);
                padding: 0;
                line-height: 1;
                transition: color 0.15s;
            }

            .modal-close:hover {
                color: var(--text-main);
            }

            .modal-body {
                padding: 24px;
                max-height: 50vh;
                overflow-y: auto;
            }

            .modal-message {
                font-size: 15px;
                line-height: 1.7;
                color: var(--text-main);
                white-space: pre-wrap;
                word-wrap: break-word;
            }

            .modal-meta {
                display: flex;
                align-items: center;
                gap: 16px;
                padding: 16px 24px;
                background: var(--bg-color);
                border-top: 1px solid var(--border-color);
                font-size: 13px;
                color: var(--text-muted);
            }

            .modal-footer {
                display: flex;
                justify-content: flex-end;
                gap: 12px;
                padding: 16px 24px;
                border-top: 1px solid var(--border-color);
            }

            .view-hint {
                font-size: 11px;
                color: var(--text-muted);
                margin-top: 4px;
            }
        </style>
    </head>

    <body>
        <jsp:include page="header.jsp" />

        <div class="container">
            <% Users currentUser = (Users) session.getAttribute("currentUser");
                List<Notification> notifications = (List<Notification>) request.getAttribute("notifications");
                Integer unreadCount = (Integer) request.getAttribute("unreadCount");
                String message = request.getParameter("msg");
                String error = request.getParameter("error");

                if (unreadCount == null)
                    unreadCount = 0;
            %>

            <% if (message != null) {%>
            <div class="alert alert-success">
                <%= message%>
            </div>
            <% } %>

            <% if (error != null) {%>
            <div class="alert alert-error">
                <%= error%>
            </div>
            <% } %>

            <div class="page-header">
                <h1>Notifications</h1>
                <div class="header-actions">
                    <% if (notifications != null && !notifications.isEmpty()
                                                                    && unreadCount > 0) { %>
                    <button class="btn btn-primary" onclick="markAllAsRead()">
                        ✓ Mark All Read
                    </button>
                    <% }%>
                </div>
            </div>

            <div class="stats-bar">
                <div class="stat-item">
                    <div class="stat-number">
                        <%= unreadCount%>
                    </div>
                    <div class="stat-label">Unread</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">
                        <%= notifications != null ? notifications.size() : 0%>
                    </div>
                    <div class="stat-label">Total</div>
                </div>
            </div>

            <div class="notification-card">
                <% if (notifications == null || notifications.isEmpty()) { %>
                <div class="empty-state">
                    <div class="empty-state-icon">🔔</div>
                    <h3>No notifications yet</h3>
                    <p>When you receive notifications, they will appear here.
                    </p>
                </div>
                <% } else { %>
                <% for (Notification n : notifications) {
                        String unreadClass = !n.isRead() ? "unread" : "";
                        String createdAtStr = n.getCreatedAt() != null ? new java.text.SimpleDateFormat("MMM dd, yyyy HH:mm").format(n.getCreatedAt()) : "Unknown"; // Escape single quotes and newlines for JavaScript 
                        String escapedTitle = n.getTitle().replace("'", "\\'").replace("\n", "\\n").replace("\r", "");
                        String escapedMessage = n.getMessage().replace("'", "\\'"
                                                                    ).replace("\n", "\\n").replace("\r", "");
                                                                    String link = n.getLink() != null ? n.getLink() : "";%>
                <div class="notification-item <%= unreadClass%>"
                     id="notification-<%= n.getNotificationId()%>"
                     onclick="openModal('<%= escapedTitle%>', '<%= escapedMessage%>', '<%= createdAtStr%>', <%= n.isRead()%>, <%= n.getNotificationId()%>, '<%= link%>')">
                    <div class="notification-icon">
                        📢
                    </div>
                    <div class="notification-body">
                        <div class="notification-title">
                            <%= n.getTitle()%>
                        </div>
                        <div class="notification-message">
                            <%= n.getMessage()%>
                        </div>
                        <div class="notification-meta">
                            <span>📅 <%= createdAtStr%></span>
                            <% if (n.isRead()) { %>
                            <span>✓ Read</span>
                            <% } %>
                        </div>
                        <div class="view-hint">Click to view full
                            message</div>
                    </div>
                    <div class="notification-actions"
                         onclick="event.stopPropagation()">
                        <% if (!n.isRead()) {%>
                        <button class="action-btn mark-read"
                                onclick="markAsRead(<%= n.getNotificationId()%>)">
                            Mark Read
                        </button>
                        <% }%>
                        <button class="action-btn delete"
                                onclick="deleteNotification(<%= n.getNotificationId()%>)">
                            Delete
                        </button>
                    </div>
                </div>
                <% } %>
                <% }%>
            </div>
        </div>

        <!-- Notification Detail Modal -->
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
                    <a class="btn btn-primary" id="modalGoTo" style="display: none;" href="#">
                        ➡️ Go to Details
                    </a>
                    <button class="btn btn-primary" id="modalMarkRead" style="display: none;"
                            onclick="markAsReadFromModal()">
                        Mark as Read
                    </button>
                </div>
            </div>
        </div>

        <jsp:include page="footer.jsp" />

        <script>
            // Note: contextPath is defined in header.jsp
            var currentNotificationId = null;
            var currentNotificationLink = null;

            function openModal(title, message, date, isRead, notificationId, link) {
                currentNotificationId = notificationId;
                currentNotificationLink = link || null;

                // Decode escaped characters
                document.getElementById('modalTitle').textContent = title.replace(/\\n/g, '\n').replace(/\\'/g, "'");
                document.getElementById('modalMessage').textContent = message.replace(/\\n/g, '\n').replace(/\\'/g, "'");
                document.getElementById('modalDate').textContent = '📅 ' + date;
                document.getElementById('modalStatus').textContent = isRead ? '✓ Read' : '○ Unread';

                // Show/hide mark as read button
                var markReadBtn = document.getElementById('modalMarkRead');
                if (isRead) {
                    markReadBtn.style.display = 'none';
                } else {
                    markReadBtn.style.display = 'inline-flex';
                }

                // Show/hide go to button based on link
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
                if (event && event.target !== document.getElementById('notificationModal')) {
                    return;
                }
                document.getElementById('notificationModal').classList.remove('show');
                document.body.style.overflow = '';
                currentNotificationId = null;
            }

            function markAsReadFromModal() {
                if (currentNotificationId) {
                    markAsRead(currentNotificationId);
                }
            }

            function markAsRead(notificationId) {
                fetch(contextPath + '/notifications?action=markRead&id=' + notificationId, {
                    method: 'POST'
                })
                        .then(response => response.json())
                        .then(result => {
                            if (result.success) {
                                location.reload();
                            } else {
                                alert('Failed to mark as read: ' + result.message);
                            }
                        })
                        .catch(err => {
                            console.error('Error:', err);
                            alert('Failed to mark notification as read');
                        });
            }

            function markAllAsRead() {
                fetch(contextPath + '/notifications?action=markAllRead', {
                    method: 'POST'
                })
                        .then(response => response.json())
                        .then(result => {
                            if (result.success) {
                                location.reload();
                            }
                        })
                        .catch(err => {
                            console.error('Error:', err);
                            alert('Failed to mark all as read');
                        });
            }

            function deleteNotification(notificationId) {
                if (!confirm('Are you sure you want to delete this notification?')) {
                    return;
                }

                fetch(contextPath + '/notifications?action=delete&id=' + notificationId, {
                    method: 'POST'
                })
                        .then(response => response.json())
                        .then(result => {
                            if (result.success) {
                                const element = document.getElementById('notification-' + notificationId);
                                if (element) {
                                    element.remove();
                                }
                                location.reload();
                            } else {
                                alert('Failed to delete: ' + result.message);
                            }
                        })
                        .catch(err => {
                            console.error('Error:', err);
                            alert('Failed to delete notification');
                        });
            }

            // Close modal on Escape key
            document.addEventListener('keydown', function (e) {
                if (e.key === 'Escape') {
                    closeModal();
                }
            });
        </script>
    </body>

</html>