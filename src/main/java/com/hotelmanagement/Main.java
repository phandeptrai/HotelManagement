package com.hotelmanagement;

import java.sql.Connection;

import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import com.hotelmanagement.utils.DatabaseConfig;

public class Main {
    public static void main(String[] args) {
        // Tạo context từ config class
        AnnotationConfigApplicationContext context =
                new AnnotationConfigApplicationContext(DatabaseConfig.class);

        // Lấy bean DatabaseConfig
        DatabaseConfig dbConfig = context.getBean(DatabaseConfig.class);

        // Kiểm tra kết nối
        try (Connection conn = dbConfig.getConnection()) {
            if (conn != null && !conn.isClosed()) {
                System.out.println("✅ Kết nối thành công đến cơ sở dữ liệu!");
            } else {
                System.out.println("❌ Kết nối thất bại.");
            }
        } catch (Exception e) {
            System.out.println("❌ Lỗi khi kết nối: " + e.getMessage());
            e.printStackTrace();
        } finally {
            context.close();
        }
    }
}
