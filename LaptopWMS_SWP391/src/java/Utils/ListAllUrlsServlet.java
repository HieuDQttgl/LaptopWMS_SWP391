package Utils;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.annotation.Annotation;
import java.util.*;
import jakarta.servlet.ServletContext;

@WebServlet("/list-all-urls")
public class ListAllUrlsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        out.println("<!DOCTYPE html>");
        out.println("<html><head><title>All URLs</title>");
        out.println("<style>");
        out.println("body { font-family: Arial; margin: 20px; }");
        out.println("table { border-collapse: collapse; width: 100%; }");
        out.println("th, td { border: 1px solid #ddd; padding: 12px; text-align: left; }");
        out.println("th { background-color: #4CAF50; color: white; }");
        out.println("tr:nth-child(even) { background-color: #f2f2f2; }");
        out.println(".copy-btn { background: #2196F3; color: white; border: none; padding: 5px 10px; cursor: pointer; }");
        out.println("</style></head><body>");
        out.println("<h1>All Servlet URL Patterns in Your Project</h1>");

        // Get all servlet registrations
        ServletContext context = getServletContext();
        Map<String, ? extends jakarta.servlet.ServletRegistration> servlets = context.getServletRegistrations();

        out.println("<table>");
        out.println("<tr><th>#</th><th>Servlet Name</th><th>URL Pattern</th><th>SQL Insert</th></tr>");

        int count = 1;
        Set<String> allUrls = new TreeSet<>(); // TreeSet for sorting

        for (Map.Entry<String, ? extends jakarta.servlet.ServletRegistration> entry : servlets.entrySet()) {
            String servletName = entry.getKey();
            Collection<String> mappings = entry.getValue().getMappings();

            for (String mapping : mappings) {
                allUrls.add(mapping);
                out.println("<tr>");
                out.println("<td>" + count++ + "</td>");
                out.println("<td>" + servletName + "</td>");
                out.println("<td><strong>" + mapping + "</strong></td>");

                // Generate SQL
                String sql = String.format(
                        "INSERT INTO permissions (permission_url, permission_description, module) VALUES ('%s', 'Access %s', 'general');",
                        mapping, servletName
                );
                out.println("<td><code>" + sql + "</code></td>");
                out.println("</tr>");
            }
        }

        out.println("</table>");

        // Generate complete SQL script
        out.println("<h2>Copy All SQL Statements:</h2>");
        out.println("<textarea style='width:100%; height:300px; font-family:monospace;'>");
        for (String url : allUrls) {
            out.println(String.format("INSERT INTO permissions (permission_url, permission_description, module, created_at, updated_at) VALUES ('%s', 'Access to %s', 'general', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);", url, url));
        }
        out.println("</textarea>");

        out.println("</body></html>");
    }
}
