<!-- Shared Toast & Confirmation Modal Component -->

<style>
    /* Toast Notifications */
    .toast-container {
        position: fixed;
        top: 1.5rem;
        right: 1.5rem;
        z-index: 10000;
        display: flex;
        flex-direction: column;
        gap: 0.75rem;
        pointer-events: none;
    }

    .toast {
        background: white;
        padding: 1rem 1.5rem;
        border-radius: 0.75rem;
        box-shadow: 0 10px 40px rgba(0, 0, 0, 0.15);
        display: flex;
        align-items: center;
        gap: 0.75rem;
        min-width: 300px;
        max-width: 450px;
        pointer-events: auto;
        animation: toastSlideIn 0.3s ease-out;
        border-left: 4px solid #667eea;
    }

    .toast.success {
        border-left-color: #10b981;
    }

    .toast.error {
        border-left-color: #ef4444;
    }

    .toast.warning {
        border-left-color: #f59e0b;
    }

    .toast-icon {
        font-size: 1.25rem;
        flex-shrink: 0;
    }

    .toast-content {
        flex: 1;
    }

    .toast-title {
        font-weight: 600;
        color: #1e293b;
        font-size: 0.9375rem;
    }

    .toast-message {
        color: #64748b;
        font-size: 0.8125rem;
        margin-top: 0.125rem;
    }

    .toast-close {
        background: none;
        border: none;
        color: #94a3b8;
        cursor: pointer;
        padding: 0.25rem;
        font-size: 1.25rem;
        line-height: 1;
    }

    .toast-close:hover {
        color: #475569;
    }

    @keyframes toastSlideIn {
        from {
            opacity: 0;
            transform: translateX(100%);
        }

        to {
            opacity: 1;
            transform: translateX(0);
        }
    }

    @keyframes toastSlideOut {
        from {
            opacity: 1;
            transform: translateX(0);
        }

        to {
            opacity: 0;
            transform: translateX(100%);
        }
    }

    /* Confirmation Modal */
    .confirm-overlay {
        display: none;
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.5);
        z-index: 10001;
        justify-content: center;
        align-items: center;
        backdrop-filter: blur(4px);
    }

    .confirm-overlay.show {
        display: flex;
    }

    .confirm-dialog {
        background: white;
        border-radius: 1rem;
        padding: 2rem;
        max-width: 400px;
        width: 90%;
        box-shadow: 0 25px 50px rgba(0, 0, 0, 0.25);
        animation: confirmSlideIn 0.2s ease-out;
        text-align: center;
    }

    @keyframes confirmSlideIn {
        from {
            opacity: 0;
            transform: scale(0.9) translateY(-20px);
        }

        to {
            opacity: 1;
            transform: scale(1) translateY(0);
        }
    }

    .confirm-icon {
        font-size: 3rem;
        margin-bottom: 1rem;
    }

    .confirm-title {
        font-size: 1.25rem;
        font-weight: 700;
        color: #1e293b;
        margin: 0 0 0.5rem;
    }

    .confirm-message {
        color: #64748b;
        font-size: 0.9375rem;
        line-height: 1.5;
        margin: 0 0 1.5rem;
    }

    .confirm-actions {
        display: flex;
        gap: 0.75rem;
        justify-content: center;
    }

    .confirm-btn {
        padding: 0.75rem 1.5rem;
        border-radius: 0.5rem;
        font-weight: 600;
        font-size: 0.875rem;
        cursor: pointer;
        transition: all 0.2s ease;
        border: none;
    }

    .confirm-btn-cancel {
        background: #f1f5f9;
        color: #475569;
    }

    .confirm-btn-cancel:hover {
        background: #e2e8f0;
    }

    .confirm-btn-danger {
        background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
        color: white;
        box-shadow: 0 4px 14px rgba(239, 68, 68, 0.4);
    }

    .confirm-btn-danger:hover {
        transform: translateY(-1px);
        box-shadow: 0 6px 18px rgba(239, 68, 68, 0.5);
    }

    .confirm-btn-success {
        background: linear-gradient(135deg, #10b981 0%, #059669 100%);
        color: white;
        box-shadow: 0 4px 14px rgba(16, 185, 129, 0.4);
    }

    .confirm-btn-success:hover {
        transform: translateY(-1px);
        box-shadow: 0 6px 18px rgba(16, 185, 129, 0.5);
    }
</style>

<!-- Toast Container -->
<div class="toast-container" id="toastContainer"></div>

<!-- Confirmation Modal -->
<div class="confirm-overlay" id="confirmOverlay" onclick="closeConfirm(event)">
    <div class="confirm-dialog" onclick="event.stopPropagation()">
        <div class="confirm-icon" id="confirmIcon">&#9888;</div>
        <h3 class="confirm-title" id="confirmTitle">Confirm Action</h3>
        <p class="confirm-message" id="confirmMessage">Are you sure you want to proceed?</p>
        <div class="confirm-actions">
            <button class="confirm-btn confirm-btn-cancel" onclick="closeConfirm()">Cancel</button>
            <button class="confirm-btn confirm-btn-danger" id="confirmAction"
                onclick="executeConfirm()">Confirm</button>
        </div>
    </div>
</div>

<script>
    // Toast System
    function showToast(type, title, message, duration = 4000) {
        const container = document.getElementById('toastContainer');
        const toast = document.createElement('div');
        toast.className = 'toast ' + type;

        const icons = { success: '\u2713', error: '\u2717', warning: '\u26A0', info: '\u2139' };

        toast.innerHTML =
            '<span class="toast-icon">' + (icons[type] || icons.info) + '</span>' +
            '<div class="toast-content">' +
            '<div class="toast-title">' + title + '</div>' +
            (message ? '<div class="toast-message">' + message + '</div>' : '') +
            '</div>' +
            '<button class="toast-close" onclick="this.parentElement.remove()">&times;</button>';

        container.appendChild(toast);

        setTimeout(() => {
            toast.style.animation = 'toastSlideOut 0.3s ease-out forwards';
            setTimeout(() => toast.remove(), 300);
        }, duration);
    }

    // Confirmation Modal System
    var pendingConfirmCallback = null;
    var pendingConfirmUrl = null;

    function showConfirm(options) {
        const overlay = document.getElementById('confirmOverlay');
        const icon = document.getElementById('confirmIcon');
        const title = document.getElementById('confirmTitle');
        const message = document.getElementById('confirmMessage');
        const actionBtn = document.getElementById('confirmAction');

        icon.textContent = options.icon || '\u26A0';
        title.textContent = options.title || 'Confirm Action';
        message.textContent = options.message || 'Are you sure you want to proceed?';
        actionBtn.textContent = options.confirmText || 'Confirm';

        // Set button style
        actionBtn.className = 'confirm-btn ' + (options.type === 'success' ? 'confirm-btn-success' : 'confirm-btn-danger');

        pendingConfirmCallback = options.onConfirm || null;
        pendingConfirmUrl = options.url || null;

        overlay.classList.add('show');
        document.body.style.overflow = 'hidden';
    }

    function closeConfirm(event) {
        if (event && event.target !== document.getElementById('confirmOverlay'))
            return;
        document.getElementById('confirmOverlay').classList.remove('show');
        document.body.style.overflow = '';
        pendingConfirmCallback = null;
        pendingConfirmUrl = null;
    }

    function executeConfirm() {
        if (pendingConfirmUrl) {
            window.location.href = pendingConfirmUrl;
        } else if (pendingConfirmCallback) {
            pendingConfirmCallback();
        }
        closeConfirm();
    }

    // Keyboard support
    document.addEventListener('keydown', function (e) {
        if (e.key === 'Escape')
            closeConfirm();
    });

    // Helper function for status toggles
    function confirmStatusChange(url, itemName, isActive) {
        const action = isActive ? 'deactivate' : 'activate';
        const icon = isActive ? '\uD83D\uDD12' : '\uD83D\uDD13';

        showConfirm({
            icon: icon,
            title: isActive ? 'Deactivate ' + itemName + '?' : 'Activate ' + itemName + '?',
            message: isActive
                ? 'This will disable access. You can reactivate it later.'
                : 'This will enable access.',
            confirmText: isActive ? 'Deactivate' : 'Activate',
            type: isActive ? 'danger' : 'success',
            url: url
        });
    }
</script>