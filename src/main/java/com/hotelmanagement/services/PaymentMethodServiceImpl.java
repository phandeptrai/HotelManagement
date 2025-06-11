package com.hotelmanagement.services;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.hotelmanagement.entities.PaymentMethod;
import com.hotelmanagement.daos.PaymentMethodDAO;

@Service
public class PaymentMethodServiceImpl implements PaymentMethodService {

    @Autowired
    private PaymentMethodDAO paymentMethodDAO;

    @Override
    public List<PaymentMethod> getAllPaymentMethods() {
        return paymentMethodDAO.getAllPaymentMethods();
    }

    @Override
    public PaymentMethod getPaymentMethodById(int id) {
        return paymentMethodDAO.getPaymentMethodById(id);
    }

    @Override
    public String getMethodNameById(int id) {
        return paymentMethodDAO.getMethodNameById(id);
    }
} 