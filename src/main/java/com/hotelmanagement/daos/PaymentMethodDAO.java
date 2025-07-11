package com.hotelmanagement.daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hotelmanagement.entities.PaymentMethod;


@Repository
public class PaymentMethodDAO {
	private final DataSource dataSource;
	
	@Autowired
    public PaymentMethodDAO(DataSource dataSource) {
		this.dataSource = dataSource;
	}

	public List<PaymentMethod> getAllPaymentMethods() {
        List<PaymentMethod> methods = new ArrayList<>();
        String sql = "SELECT * FROM paymentmethods";
        
        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                PaymentMethod method = new PaymentMethod();
                method.setPaymentMethodID(rs.getInt("paymentMethodID"));
                method.setMethodName(rs.getString("methodName"));
                methods.add(method);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return methods;
    }
    
    public PaymentMethod getPaymentMethodById(int id) {
        String sql = "SELECT * FROM paymentmethods WHERE paymentMethodID = ?";
        
        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    PaymentMethod method = new PaymentMethod();
                    method.setPaymentMethodID(rs.getInt("paymentMethodID"));
                    method.setMethodName(rs.getString("methodName"));
                    return method;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public String getMethodNameById(int id) {
        PaymentMethod method = getPaymentMethodById(id);
        return method != null ? method.getMethodName() : null;
    }
} 