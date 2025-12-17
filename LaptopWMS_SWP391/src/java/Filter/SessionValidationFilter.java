package Filter;

import DAO.UserDAO;
import Model.Users;
import java.io.IOException;
import java.sql.Timestamp;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebFilter(filterName = "SessionValidationFilter", urlPatterns = { "/*" })
public class SessionValidationFilter implements Filter {

    // Paths that don't require session validation
    private static final String[] EXCLUDED_PATHS = {
            "/login",
            "/logout",
            "/forgot",
            "/css",
            "/js",
            "/images",
            "/fonts",
            "/header.jsp",
            "/footer.jsp"
    };

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization if needed
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        // Get request path
        String path = req.getRequestURI().substring(req.getContextPath().length());
        // Check if path is excluded from validation
        for (String excluded : EXCLUDED_PATHS) {
            if (path.startsWith(excluded) || path.equals("/") || path.isEmpty()) {
                chain.doFilter(request, response);
                return;
            }
        }

        // Validate session if user is logged in
        if (session != null && session.getAttribute("currentUser") != null) {
            Users currentUser = (Users) session.getAttribute("currentUser");
            Long sessionCreatedAt = (Long) session.getAttribute("sessionCreatedAt");

            // If sessionCreatedAt is null (old sessions), allow but add it
            if (sessionCreatedAt == null) {
                session.setAttribute("sessionCreatedAt", System.currentTimeMillis());
            } else {
                // Get password changed timestamp from database
                UserDAO dao = new UserDAO();
                Timestamp passwordChangedAt = dao.getPasswordChangedAt(currentUser.getUserId());

                // If password was changed AFTER session was created, invalidate session
                if (passwordChangedAt != null && sessionCreatedAt < passwordChangedAt.getTime()) {
                    session.invalidate();
                    resp.sendRedirect(req.getContextPath() +
                            "/login?msg=Your password was changed. Please login again.");
                    return;
                }
            }
        }

        // Continue with the request
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Cleanup if needed
    }
}
