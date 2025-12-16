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
            // Tải dữ liệu cần thiết cho dropdown list (JSP)
            request.setAttribute("allCustomers", customerDAO.getListCustomers());
            request.setAttribute("allSuppliers", supplierDAO.getListSuppliers());
            request.setAttribute("allProducts", productDAO.getListProducts());
            
            request.getRequestDispatcher("add-order.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading data for form: " + e.getMessage());
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
        
        // --- 1. KIỂM TRA ĐĂNG NHẬP ---
        Users currentUser = (Users) request.getSession().getAttribute("currentUser");
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        Integer createdBy = currentUser.getUserId();

        // >>> BẮT ĐẦU SỬA: THÊM LOGIC PARSE ID ĐỐI TÁC <<<
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
        // >>> KẾT THÚC SỬA: ID đối tác đã được set đúng <<<

        // Khởi tạo đối tượng Order
        Order newOrder = new Order();
        newOrder.setCustomerId(customerId);
        newOrder.setSupplierId(supplierId);
        newOrder.setDescription(description);
        newOrder.setOrderStatus("Pending");
        newOrder.setCreatedBy(createdBy);

        // --- 3. VALIDATION VÀ PARSE CHI TIẾT ĐƠN HÀNG (LOGIC SỬA LỖI MAPPING TÊN SẢN PHẨM) ---
        List<OrderProduct> details = new ArrayList<>();
        // Map mới để lưu trữ tên sản phẩm đã gõ khi form bị lỗi (Key: Index, Value: Tên SP)
        Map<Integer, String> errorProductNames = new HashMap<>(); 
        
        int index = 0;
        boolean hasDetails = false;
        boolean hasDetailError = false; // Cờ báo lỗi chi tiết

        while (true) {
            String productIdKey = "details[" + index + "].productId";
            String quantityKey = "details[" + index + "].quantity";
            String unitPriceKey = "details[" + index + "].unitPrice";
            String productNameKey = "productName_TEMP_" + index; // Lấy tên tạm thời từ JSP
            
            String detailProductIdStr = request.getParameter(productIdKey);
            String detailQuantityStr = request.getParameter(quantityKey);
            String detailUnitPriceStr = request.getParameter(unitPriceKey);
            String detailProductName = request.getParameter(productNameKey);

            if (detailProductIdStr == null && detailQuantityStr == null && detailUnitPriceStr == null) {
                break; 
            }
            
            // Nếu chỉ tìm thấy một vài tham số, có thể là lỗi cấu trúc form, nhưng ta vẫn xử lý
            if (detailProductIdStr == null || detailQuantityStr == null || detailUnitPriceStr == null) {
                 errors.put("details", "Missing fields for product line " + (index + 1) + ". Check the form structure.");
                 index++;
                 hasDetailError = true;
                 continue;
            }

            hasDetails = true;
            
            Integer productId = null;
            Integer quantity = null;
            BigDecimal unitPrice = null;

            try {
                // PARSE DỮ LIỆU
                if (!detailProductIdStr.trim().isEmpty()) {
                    productId = Integer.valueOf(detailProductIdStr.trim());
                }
                if (!detailQuantityStr.trim().isEmpty()) {
                    quantity = Integer.valueOf(detailQuantityStr.trim());
                }
                if (!detailUnitPriceStr.trim().isEmpty()) {
                    unitPrice = new BigDecimal(detailUnitPriceStr.trim());
                }
                
                // --- Validation chi tiết ---
                if (productId == null || productId <= 0) {
                    errors.put("details", "Product ID at line " + (index + 1) + " is invalid or missing. Ensure product is selected.");
                    hasDetailError = true;
                } else if (quantity == null || quantity <= 0) {
                    errors.put("details", "Quantity at line " + (index + 1) + " must be a positive number.");
                    hasDetailError = true;
                } else if (unitPrice == null || unitPrice.compareTo(BigDecimal.ZERO) < 0) {
                    errors.put("details", "Unit Price at line " + (index + 1) + " must be a non-negative number.");
                    hasDetailError = true;
                } else {
                    // Thêm vào danh sách nếu hợp lệ
                    OrderProduct detail = new OrderProduct();
                    detail.setProductId(productId);
                    detail.setQuantity(quantity);
                    detail.setUnitPrice(unitPrice);
                    details.add(detail);
                }

            } catch (NumberFormatException e) {
                errors.put("details", "Product data at line " + (index + 1) + " contains incorrect number syntax.");
                hasDetailError = true;
            }
            
            // >>> LƯU TÊN SẢN PHẨM GÕ TAY VÀO MAP DỰ TẠM <<<
            // Nếu có lỗi chi tiết (hoặc ID sản phẩm bằng 0/null), chúng ta cần lưu lại tên SP gõ tay
            // để giữ UX khi quay lại JSP.
            if (detailProductName != null && !detailProductName.trim().isEmpty()) {
                errorProductNames.put(index, detailProductName);
            }
            
            index++; 
        }
        
        // Kiểm tra điều kiện đơn hàng phải có ít nhất 1 chi tiết
        if (!hasDetails) {
            errors.put("details", "Order must have at least 1 product.");
        }
        
        // --- 4. XỬ LÝ KẾT QUẢ ---
        if (!errors.isEmpty() || hasDetailError) {
            request.setAttribute("errors", errors);
            request.setAttribute("tempOrder", newOrder);
            
            // >>> TRUYỀN MAP TÊN SẢN PHẨM GÕ TAY BỊ LỖI VỀ JSP <<<
            request.setAttribute("errorProductNames", errorProductNames); 
            
            // Truyền tất cả các chi tiết đã parse thành công (details)
            // Lưu ý: Nếu có lỗi, 'details' chỉ chứa các dòng hợp lệ.
            // Để JSP hiển thị lại đúng số dòng, ta cần dựa vào logic JSP.
            request.setAttribute("tempDetails", details); 
            
            // Tải lại dữ liệu cho form
            try {
                request.setAttribute("allCustomers", customerDAO.getListCustomers());
                request.setAttribute("allSuppliers", supplierDAO.getListSuppliers());
                request.setAttribute("allProducts", productDAO.getListProducts());
            } catch (Exception e) {
                 e.printStackTrace();
                 errors.put("general", "Lỗi tải lại dữ liệu danh mục.");
            }
            
            request.getRequestDispatcher("add-order.jsp").forward(request, response);
            
        } else {
            // ... (Logic lưu DB thành công hoặc thất bại) ...
            try {
                boolean success = orderDAO.addOrder(newOrder, details);

                if (success) {
                    request.getSession().setAttribute("message", "Add new order success!");
                    response.sendRedirect(request.getContextPath() + "/order-list");
                } else {
                    errors.put("general", "System error: Cannot save order, please try again.");
                    request.setAttribute("errors", errors);
                    request.setAttribute("tempOrder", newOrder);
                    request.setAttribute("tempDetails", details);
                    request.setAttribute("allCustomers", customerDAO.getListCustomers());
                    request.setAttribute("allSuppliers", supplierDAO.getListSuppliers());
                    request.setAttribute("allProducts", productDAO.getListProducts());
                    
                    request.getRequestDispatcher("add-order.jsp").forward(request, response);
                }
            } catch (Exception e) {
                 e.printStackTrace();
                 errors.put("general", "Lỗi DB/Server nghiêm trọng: " + e.getMessage());
                 request.setAttribute("errors", errors);
                 request.setAttribute("tempOrder", newOrder);
                 request.setAttribute("tempDetails", details);
                 
                 try {
                     request.setAttribute("allCustomers", customerDAO.getListCustomers());
                     request.setAttribute("allSuppliers", supplierDAO.getListSuppliers());
                     request.setAttribute("allProducts", productDAO.getListProducts());
                 } catch (Exception ex) { /* Bỏ qua lỗi này */ }
                 
                 request.getRequestDispatcher("add-order.jsp").forward(request, response);
            }
        }
    }
}