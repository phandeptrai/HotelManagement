package com.hotelmanagement.entities;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "paymentmethods")
public class PaymentMethod {
    
    @Id
    private int paymentMethodID;
    private String methodName;
    
    public PaymentMethod() {
    }
    
    public PaymentMethod(int paymentMethodID, String methodName) {
        this.paymentMethodID = paymentMethodID;
        this.methodName = methodName;
    }
    
    public int getPaymentMethodID() {
        return paymentMethodID;
    }
    
    public void setPaymentMethodID(int paymentMethodID) {
        this.paymentMethodID = paymentMethodID;
    }
    
    public String getMethodName() {
        return methodName;
    }
    
    public void setMethodName(String methodName) {
        this.methodName = methodName;
    }
} 