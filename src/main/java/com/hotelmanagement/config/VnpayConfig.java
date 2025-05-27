package com.hotelmanagement.config;

public class VnpayConfig {
    public static final String VERSION = "2.1.0";
    public static final String COMMAND = "pay";
    public static final String TMN_CODE = "713V6XB6";
    public static final String HASH_SECRET = "6PLSI1SUMIGHZF432UG3LN7LTI8TL1PY";
    public static final String PAYMENT_URL = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html";
    public static final String RETURN_URL = "http://localhost:8080/HotelManagement/payment/vnpay-return";
}
