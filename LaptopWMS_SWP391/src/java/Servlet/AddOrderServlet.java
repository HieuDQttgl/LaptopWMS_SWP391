package Servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.math.BigDecimal;

import Model.Order;
import Model.OrderProduct;
import DAO.OrderDAO;
import DAO.CustomerDAO;
import DAO.SupplierDAO;
import DAO.ProductDAO;
import Model.ProductDetail;
import Model.Users;

@WebServlet(name = "AddOrderServlet", urlPatterns = {"/add-order"})
public class AddOrderServlet extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();
    private final CustomerDAO customerDAO = new CustomerDAO();
    private final SupplierDAO supplierDAO = new SupplierDAO();
    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            request.setAttribute("allCustomers", customerDAO.getListCustomers());
            request.setAttribute("allSuppliers", supplierDAO.getListSuppliers());
            request.setAttribute("allProducts", productDAO.getListProducts());
            request.setAttribute("allProductDetails", productDAO.getAllProductDetails());

            request.removeAttribute("tempOrder");
            request.removeAttribute("tempDetails");

            request.getRequestDispatcher("add-order.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Error loading data for form: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        Map<String, String> errors = new HashMap<>();

        String customerIdStr = request.getParameter("customerId");
        String supplierIdStr = request.getParameter("supplierId");
        String description = request.getParameter("description");

        Integer customerId = 0;
        Integer supplierId = 0;

        Users currentUser = (Users) request.getSession().getAttribute("currentUser");
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        Integer createdBy = currentUser.getUserId();

        try {
            if (customerIdStr != null && !customerIdStr.trim().isEmpty() && !customerIdStr.trim().equals("0")) {
                customerId = Integer.valueOf(customerIdStr.trim());
            }
            if (supplierIdStr != null && !supplierIdStr.trim().isEmpty() && !supplierIdStr.trim().equals("0")) {
                supplierId = Integer.valueOf(supplierIdStr.trim());
            }
        } catch (NumberFormatException e) {
            errors.put("party", "ID đối tác không hợp lệ.");
        }

        Order newOrder = new Order();
        if (customerId > 0) {
            newOrder.setCustomerId(customerId);
            newOrder.setSupplierId(null);
        } else if (supplierId > 0) {
            newOrder.setSupplierId(supplierId);
            newOrder.setCustomerId(null);
        } else {
            errors.put("party", "Vui lòng chọn Khách hàng hoặc Nhà cung cấp.");
        }

        newOrder.setDescription(description);
        newOrder.setOrderStatus("Pending");
        newOrder.setCreatedBy(createdBy);

        List<OrderProduct> details = new ArrayList<>();
        boolean hasDetailError = false;

        String[] productDetailIds = request.getParameterValues("productDetailId");
        String[] quantities = request.getParameterValues("quantity");
        String[] unitPrices = request.getParameterValues("unitPrice");

        if (productDetailIds != null && productDetailIds.length > 0) {
            for (int i = 0; i < productDetailIds.length; i++) {
                String detailIdStr = productDetailIds[i];
                String qtyStr = quantities[i];
                String priceStr = unitPrices[i];

                if ((detailIdStr == null || detailIdStr.equals("0")) && (qtyStr == null || qtyStr.isEmpty())) {
                    continue;
                }

                try {
                    int detailId = Integer.parseInt(detailIdStr);
                    int quantity = Integer.parseInt(qtyStr);
                    BigDecimal unitPrice = new BigDecimal(priceStr);

                    if (quantity <= 0) {
                        errors.put("details_line_" + i, "Dòng " + (i + 1) + ": Số lượng phải > 0.");
                        hasDetailError = true;
                    }
                    if (unitPrice.compareTo(BigDecimal.ZERO) < 0) {
                        errors.put("details_line_" + i, "Dòng " + (i + 1) + ": Đơn giá không hợp lệ.");
                        hasDetailError = true;
                    }

                    OrderProduct op = new OrderProduct();
                    op.setProductDetailId(detailId);
                    op.setQuantity(quantity);
                    op.setUnitPrice(unitPrice);
                    details.add(op);

                } catch (Exception e) {
                    errors.put("details_line_" + i, "Dòng " + (i + 1) + ": Dữ liệu số lượng hoặc đơn giá không hợp lệ.");
                    hasDetailError = true;
                }
            }
        }

        if (details.isEmpty() && !hasDetailError) {
            errors.put("details", "Đơn hàng phải có ít nhất 1 sản phẩm.");
        }

        // 3. Xử lý kết quả
        if (!errors.isEmpty() || hasDetailError) {
            request.setAttribute("errors", errors);
            request.setAttribute("tempOrder", newOrder);
            request.setAttribute("tempDetails", details);
            try {
                request.setAttribute("allCustomers", customerDAO.getListCustomers());
                request.setAttribute("allSuppliers", supplierDAO.getListSuppliers());
                request.setAttribute("allProducts", productDAO.getListProducts());
                request.setAttribute("allProductDetails", productDAO.getAllProductDetails());
            } catch (Exception e) {
                e.printStackTrace();
            }
            request.getRequestDispatcher("add-order.jsp").forward(request, response);
        } else {
            try {
                boolean success = orderDAO.addOrder(newOrder, details);

                if (success) {
                    response.sendRedirect(request.getContextPath() + "/order-list?success=true");
                } else {
                    errors.put("general", "Lỗi hệ thống: Không thể lưu đơn hàng vào CSDL.");
                    request.setAttribute("errors", errors);
                    request.setAttribute("allProducts", productDAO.getListProducts());
                    request.setAttribute("allProductDetails", productDAO.getAllProductDetails());
                    request.getRequestDispatcher("add-order.jsp").forward(request, response);
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi Server: " + e.getMessage());
            }
        }
    }
}
