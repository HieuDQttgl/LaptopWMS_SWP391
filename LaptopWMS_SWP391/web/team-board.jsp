<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Team Board | Laptop WMS</title>
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

                .back-link {
                    color: #64748b;
                    text-decoration: none;
                    font-size: 0.875rem;
                    font-weight: 500;
                }

                .back-link:hover {
                    color: #667eea;
                }

                .widget {
                    background: white;
                    padding: 1.5rem;
                    border-radius: 1rem;
                    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
                    border: 1px solid #f1f5f9;
                    margin-bottom: 1.5rem;
                }

                .widget h3 {
                    margin: 0 0 1rem 0;
                    padding-bottom: 0.75rem;
                    border-bottom: 2px solid #f1f5f9;
                    color: #1e293b;
                    font-size: 1rem;
                    font-weight: 700;
                }

                .post-form {
                    display: flex;
                    gap: 0.75rem;
                }

                .post-input {
                    flex: 1;
                    padding: 0.875rem 1rem;
                    border: 2px solid #e2e8f0;
                    border-radius: 0.5rem;
                    font-size: 0.9375rem;
                    outline: none;
                    transition: all 0.2s ease;
                }

                .post-input:focus {
                    border-color: #667eea;
                    box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.15);
                }

                .btn-post {
                    padding: 0.875rem 1.5rem;
                    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                    color: white;
                    border: none;
                    border-radius: 0.5rem;
                    font-weight: 600;
                    cursor: pointer;
                    transition: all 0.2s ease;
                }

                .btn-post:hover {
                    transform: translateY(-1px);
                    box-shadow: 0 4px 12px rgba(102, 126, 234, 0.4);
                }

                .board-item {
                    padding: 1.25rem 0;
                    border-bottom: 1px solid #f1f5f9;
                }

                .board-item:last-child {
                    border-bottom: none;
                }

                .msg-header {
                    display: flex;
                    justify-content: space-between;
                    align-items: flex-start;
                    margin-bottom: 0.75rem;
                }

                .sender-info {
                    display: flex;
                    align-items: center;
                    gap: 0.5rem;
                }

                .sender-name {
                    font-weight: 600;
                    color: #1e293b;
                }

                .sender-badge {
                    padding: 0.25rem 0.5rem;
                    background: linear-gradient(135deg, #eff6ff 0%, #dbeafe 100%);
                    color: #2563eb;
                    border-radius: 0.25rem;
                    font-size: 0.6875rem;
                    font-weight: 600;
                }

                .msg-time {
                    font-size: 0.75rem;
                    color: #94a3b8;
                }

                .msg-actions {
                    display: flex;
                    gap: 0.75rem;
                    font-size: 0.75rem;
                }

                .msg-actions a,
                .msg-actions button {
                    background: none;
                    border: none;
                    color: #64748b;
                    cursor: pointer;
                    text-decoration: none;
                    font-weight: 500;
                    padding: 0;
                }

                .msg-actions a:hover {
                    color: #667eea;
                }

                .msg-actions button.delete {
                    color: #ef4444;
                }

                .msg-actions button.delete:hover {
                    color: #dc2626;
                }

                .msg-content {
                    background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
                    padding: 1rem;
                    border-radius: 0.5rem;
                    border-left: 4px solid #667eea;
                    color: #475569;
                    font-size: 0.9375rem;
                    line-height: 1.6;
                    white-space: pre-wrap;
                }

                .edit-form {
                    display: none;
                    margin-top: 0.75rem;
                }

                .edit-form input {
                    width: 100%;
                    padding: 0.75rem;
                    border: 2px solid #e2e8f0;
                    border-radius: 0.5rem;
                    font-size: 0.875rem;
                    margin-bottom: 0.5rem;
                    box-sizing: border-box;
                }

                .edit-actions {
                    display: flex;
                    gap: 0.5rem;
                }

                .btn-small {
                    padding: 0.5rem 1rem;
                    border-radius: 0.375rem;
                    font-size: 0.75rem;
                    font-weight: 600;
                    cursor: pointer;
                    border: none;
                }

                .btn-save {
                    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                    color: white;
                }

                .btn-cancel {
                    background: #e2e8f0;
                    color: #64748b;
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

                    .page-header {
                        flex-direction: column;
                        gap: 1rem;
                        align-items: flex-start;
                    }

                    .post-form {
                        flex-direction: column;
                    }
                }
            </style>
        </head>

        <body>
            <jsp:include page="header.jsp" />

            <div class="page-container">
                <div class="page-header">
                    <h1 class="page-title">📢 Team Board</h1>
                    <a href="dashboard" class="back-link">← Back to Dashboard</a>
                </div>

                <div class="widget">
                    <h3>✏️ Post New Update</h3>
                    <form action="add-announcement" method="POST" class="post-form">
                        <input type="text" name="content" class="post-input" placeholder="Type a message to the team..."
                            required>
                        <button type="submit" class="btn-post">Post</button>
                    </form>
                </div>

                <div class="widget">
                    <h3>💬 Recent Updates</h3>

                    <c:forEach var="a" items="${announcementList}">
                        <div class="board-item">
                            <div class="msg-header">
                                <div>
                                    <div class="sender-info">
                                        <span class="sender-name">${a.senderName}</span>
                                        <span class="sender-badge">${a.senderRole}</span>
                                    </div>
                                    <span class="msg-time">${a.formattedDate}</span>
                                </div>

                                <c:if test="${currentUser.userId == a.senderId || currentUser.roleId == 1}">
                                    <div class="msg-actions">
                                        <a href="javascript:void(0)" onclick="enableEdit(${a.id})">Edit</a>
                                        <button type="button" class="delete"
                                            onclick="confirmDelete(${a.id})">Delete</button>
                                    </div>
                                </c:if>
                            </div>

                            <div id="view-${a.id}" class="msg-content">${a.content}</div>

                            <form id="edit-${a.id}" action="manage-announcement" method="POST" class="edit-form">
                                <input type="hidden" name="action" value="edit">
                                <input type="hidden" name="id" value="${a.id}">
                                <input type="text" name="content" value="${a.content}">
                                <div class="edit-actions">
                                    <button type="submit" class="btn-small btn-save">Save</button>
                                    <button type="button" onclick="cancelEdit(${a.id})"
                                        class="btn-small btn-cancel">Cancel</button>
                                </div>
                            </form>
                        </div>
                    </c:forEach>

                    <c:if test="${empty announcementList}">
                        <div class="empty-state">
                            <div style="font-size: 3rem; margin-bottom: 0.5rem;">📝</div>
                            No updates yet. Be the first to post!
                        </div>
                    </c:if>
                </div>
            </div>

            <jsp:include page="footer.jsp" />

            <script>
                function enableEdit(id) {
                    document.getElementById('view-' + id).style.display = 'none';
                    document.getElementById('edit-' + id).style.display = 'block';
                }
                function cancelEdit(id) {
                    document.getElementById('view-' + id).style.display = 'block';
                    document.getElementById('edit-' + id).style.display = 'none';
                }
            </script>

            <form id="deleteForm" action="manage-announcement" method="POST" style="display:none;">
                <input type="hidden" name="action" value="delete">
                <input type="hidden" name="id" id="deleteId" value="">
            </form>

            <jsp:include page="common-dialogs.jsp" />

            <script>
                function confirmDelete(id) {
                    showConfirm({
                        icon: '🗑️',
                        title: 'Delete this note?',
                        message: 'This action cannot be undone.',
                        confirmText: 'Delete',
                        type: 'danger',
                        onConfirm: function () {
                            document.getElementById('deleteId').value = id;
                            document.getElementById('deleteForm').submit();
                        }
                    });
                }
            </script>
        </body>

        </html>