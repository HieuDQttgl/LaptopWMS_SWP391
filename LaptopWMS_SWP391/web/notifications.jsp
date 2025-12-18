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
            }

            .notification-icon.password-reset {
                background: #fef3c7;
                color: #d97706;
            }

            .notification-icon.default {
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
                white-space: pre-wrap;
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
                        String iconClass = "password_reset".equals(n.getType())
                                ? "password-reset" : "default";
                        String icon = "password_reset".equals(n.getType()) ? "🔑" : "📢";
                        String unreadClass = !n.isRead() ? "unread" : "";%>
                <div class="notification-item <%= unreadClass%>"
                     id="notification-<%= n.getNotificationId()%>">
                    <div class="notification-icon <%= iconClass%>">
                        <%= icon%>
                    </div>
                    <div class="notification-body">
                        <div class="notification-title">
                            <%= n.getTitle()%>
                        </div>
                        <div class="notification-message">
                            <%= n.getMessage()%>
                        </div>
                        <div class="notification-meta">
                            <span>📅 <%= n.getCreatedAt() != null ? new java.text.SimpleDateFormat("MMM dd, yyyy HH:mm").format(n.getCreatedAt())
                                    : "Unknown"%></span>
                                <% if (n.getRelatedUserFullName() != null) {
                                %>
                            <span>👤 <%= n.getRelatedUserFullName()%></span>
                            <% } %>
                            <% if (n.isRead() && n.getReadAt()
                                            != null) {%>
                                <span>✓ Read at <%= new java.text.SimpleDateFormat("MMM dd, HH:mm").format(n.getReadAt())%></span>
                                <% } %>
                        </div>
                    </div>
                    <div class="notification-actions">
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

        <jsp:include page="footer.jsp" />

        <script>
            const contextPath = '<%= request.getContextPath()%>';

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
        </script>
    </body>

</html>