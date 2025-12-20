<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Team Board | Laptop WMS</title>
        <style>
            body { font-family: "Segoe UI", sans-serif; background: #f5f6fa; padding: 0; margin: 0; min-height: 100vh; }
            .container { max-width: 900px; margin: 40px auto; padding: 0 20px; }

            .widget { background: white; padding: 20px; border-radius: 8px; box-shadow: 0 4px 10px rgba(0,0,0,0.05); margin-bottom: 20px; }
            .widget h3 { margin-top: 0; border-bottom: 2px solid #f0f0f0; padding-bottom: 10px; color: #34495e; font-size: 18px; }

            .board-item { 
                display: block; 
                padding: 15px 0; 
                border-bottom: 1px solid #f9f9f9; 
            }
            .board-item:last-child { border-bottom: none; }

            .msg-header {
                display: flex;
                justify-content: space-between;
                align-items: flex-start;
                margin-bottom: 8px;
            }

            .item-main { font-weight: 600; color: #333; display: block; }
            .item-sub { display: block; font-size: 12px; color: #7f8c8d; margin-top: 2px; }

            .msg-content {
                display: block;
                width: 100%;            
                background: #f8f9fa;   
                padding: 12px;         
                border-radius: 6px;     
                border-left: 4px solid #3498db; 
                box-sizing: border-box;

                color: #444; 
                font-size: 14px; 
                line-height: 1.5; 
                white-space: pre-wrap;   
                margin-top: 5px;      
            }

            .badge { padding: 4px 8px; border-radius: 4px; font-size: 11px; font-weight: bold; background: #ebf5fb; color: #3498db; }
            .btn-action { color: #3498db; text-decoration: none; font-size: 12px; font-weight: 600; cursor: pointer; border: none; background: none; padding: 0; margin-left: 10px;}
            .post-input { width: 100%; padding: 12px; border: 1px solid #eee; border-radius: 4px; }
        </style>
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
    </head>
    <body>
        <jsp:include page="header.jsp" />

        <div class="container">
            <div style="margin-bottom: 20px; display: flex; justify-content: space-between; align-items: center;">
                <h1 style="color: #2c3e50; font-size: 24px; margin: 0;">Team Board</h1>
                <a href="dashboard" style="text-decoration: none; color: #7f8c8d; font-size: 14px;">&larr; Back to Dashboard</a>
            </div>

            <div class="widget">
                <h3>Post New Update</h3>
                <form action="add-announcement" method="POST" style="margin-top: 15px;">
                    <div style="display: flex; gap: 10px;">
                        <input type="text" name="content" class="post-input" placeholder="Type a message to the team..." required>
                        <button type="submit" class="btn-action" style="height: 42px;">Post</button>
                    </div>
                </form>
            </div>

            <div class="widget">
                <h3>Recent Updates</h3>

                <c:forEach var="a" items="${announcementList}">
                    <div class="list-item">
                        <div style="display: flex; justify-content: space-between; align-items: flex-start;">
                            <div>
                                <span class="item-main">
                                    ${a.senderName} 
                                    <span class="badge badge-blue" style="margin-left: 5px; font-weight: normal;">${a.senderRole}</span>
                                </span>
                                <span class="item-sub">${a.formattedDate}</span>
                            </div>

                            <c:if test="${currentUser.userId == a.senderId || currentUser.roleId == 1}">
                                <div style="font-size: 12px;">
                                    <a href="javascript:void(0)" onclick="enableEdit(${a.id})" style="color: #3498db; text-decoration: none; margin-right: 10px;">Edit</a>

                                    <form action="manage-announcement" method="POST" style="display:inline;" onsubmit="return confirm('Delete this note?');">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="id" value="${a.id}">
                                        <button type="submit" style="background: none; border: none; color: #e74c3c; cursor: pointer; padding: 0;">Delete</button>
                                    </form>
                                </div>
                            </c:if>
                        </div>

                        <div id="view-${a.id}" class="msg-content">${a.content}</div>

                        <form id="edit-${a.id}" action="manage-announcement" method="POST" style="display:none; margin-top: 10px;">
                            <input type="hidden" name="action" value="edit">
                            <input type="hidden" name="id" value="${a.id}">

                            <input type="text" name="content" value="${a.content}" class="post-input" style="padding: 8px; font-size: 13px;">

                            <div class="edit-controls">
                                <button type="submit" class="btn-action">Save Changes</button>
                                <button type="button" onclick="cancelEdit(${a.id})" class="btn-action" style="background: #95a5a6;">Cancel</button>
                            </div>
                        </form>
                    </div>
                </c:forEach>

                <c:if test="${empty announcementList}">
                    <div style="padding: 40px; text-align: center; color: #95a5a6;">
                        No updates yet. Be the first to post!
                    </div>
                </c:if>
            </div>
        </div>

        <jsp:include page="footer.jsp" />
    </body>
</html>