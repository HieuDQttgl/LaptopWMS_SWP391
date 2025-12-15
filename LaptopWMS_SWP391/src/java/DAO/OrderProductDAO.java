package DAO;

import DTO.OrderProductDetailDTO;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class OrderProductDAO {
    

    public List<OrderProductDetailDTO> getProductsDetailByOrderId(int orderId) {
        List<OrderProductDetailDTO> list = new ArrayList<>();

        String SQL = "SELECT "
                + "op.order_product_id, "
                + "op.product_id, "
                + "p.product_name, "
                + "op.quantity, "
                + "op.unit_price "
                + "FROM order_products op "
                + "JOIN products p ON op.product_id = p.product_id "
                + "WHERE op.order_id = ?";
        
        try (Connection conn = new DBContext().getConnection(); 
             PreparedStatement ps = conn.prepareStatement(SQL)) {
            
            ps.setInt(1, orderId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int opId = rs.getInt("order_product_id");
                    int pId = rs.getInt("product_id");
                    String productName = rs.getString("product_name");
                    int quantity = rs.getInt("quantity");
                    BigDecimal unitPrice = rs.getBigDecimal("unit_price");
                    
                    OrderProductDetailDTO dto = new OrderProductDetailDTO(
                            opId, 
                            pId, 
                            productName, 
                            quantity, 
                            unitPrice
                    );
                    list.add(dto);
                }
            }
        } catch (SQLException e) {
            System.err.println("Lỗi khi truy vấn chi tiết sản phẩm đơn hàng: " + e.getMessage());
        } catch (Exception ex) {
            System.err.println("Lỗi kết nối DB: " + ex.getMessage());
        }
        return list;
    }
}