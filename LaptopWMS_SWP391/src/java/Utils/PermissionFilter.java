package Utils;

import Model.Users;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

/**
 *
 * @author super
 */
@WebFilter(filterName = "PermissionFilter", urlPatterns = {"/*"})
public class PermissionFilter implements Filter {

    private static final List<String> PUBLIC_PAGES = Arrays.asList(
            "/landing",
            "/login",
            "/register",
            "/forgot-password"
    );

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        String requestURI = req.getRequestURI();
        String contextPath = req.getContextPath();
        String path = requestURI.substring(contextPath.length());

        if (path.startsWith("/css/") || path.startsWith("/js/")
                || path.startsWith("/images/") || path.startsWith("/img/")
                || path.startsWith("/assets/") || path.startsWith("/fonts/")) {
            chain.doFilter(request, response);
            return;
        }

        if (PUBLIC_PAGES.contains(path)) {
            chain.doFilter(request, response);
            return;
        }

        if (session == null || session.getAttribute("currentUser") == null) {
            resp.sendRedirect(contextPath + "/login");
            return;
        }

        List<String> userPermissions = (List<String>) session.getAttribute("userPermissions");

        if (userPermissions != null && userPermissions.contains(path)) {
            chain.doFilter(request, response);
        } else {
            req.setAttribute("errorMessage", "You don't have permission to access this page.");
            req.getRequestDispatcher("/error-403.jsp").forward(req, resp);
        }
    }
}
