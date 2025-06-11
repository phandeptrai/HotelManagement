package com.hotelmanagement.services;

import java.util.List;
import com.hotelmanagement.entities.PaymentMethod;

public interface PaymentMethodService {
    List<PaymentMethod> getAllPaymentMethods();
    PaymentMethod getPaymentMethodById(int id);
    String getMethodNameById(int id);
} 