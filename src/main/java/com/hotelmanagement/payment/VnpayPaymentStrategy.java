package com.hotelmanagement.payment;

import com.hotelmanagement.utils.VnpayUtils;
import com.hotelmanagement.config.VnpayConfig;
import com.hotelmanagement.dtos.PaymentRequest;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Component;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.*;

@Component("vnpay")
public class VnpayPaymentStrategy implements PaymentStrategy {

    @Override
    public String pay(HttpServletRequest req, PaymentRequest paymentRequest) {
        try {
            int amount = paymentRequest.getAmount() * 100; 

            String vnp_TxnRef = String.valueOf(System.currentTimeMillis());
            String vnp_OrderInfo = "Thanh toan dat phong";
            String orderType = "other";
            String vnp_IpAddr = req.getRemoteAddr();
            String locate = "vn";
            String currCode = "VND";
            String bankCode = "NCB";

            Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
            SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
            String vnp_CreateDate = formatter.format(cld.getTime());
            cld.add(Calendar.MINUTE, 15);
            String vnp_ExpireDate = formatter.format(cld.getTime());

            Map<String, String> vnp_Params = new HashMap<>();
            vnp_Params.put("vnp_Version", VnpayConfig.VERSION);
            vnp_Params.put("vnp_Command", VnpayConfig.COMMAND);
            vnp_Params.put("vnp_TmnCode", VnpayConfig.TMN_CODE);
            vnp_Params.put("vnp_Amount", String.valueOf(amount));
            vnp_Params.put("vnp_CurrCode", currCode);
            vnp_Params.put("vnp_BankCode", bankCode);
            vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
            vnp_Params.put("vnp_OrderInfo", vnp_OrderInfo);
            vnp_Params.put("vnp_OrderType", orderType);
            vnp_Params.put("vnp_Locale", locate);
            vnp_Params.put("vnp_ReturnUrl", VnpayConfig.RETURN_URL);
            vnp_Params.put("vnp_IpAddr", vnp_IpAddr);
            vnp_Params.put("vnp_CreateDate", vnp_CreateDate);
            vnp_Params.put("vnp_ExpireDate", vnp_ExpireDate);

            List<String> fieldNames = new ArrayList<>(vnp_Params.keySet());
            Collections.sort(fieldNames);

            StringBuilder hashData = new StringBuilder();
            StringBuilder query = new StringBuilder();

            for (int i = 0; i < fieldNames.size(); i++) {
                String fieldName = fieldNames.get(i);
                String fieldValue = vnp_Params.get(fieldName);
                hashData.append(fieldName).append('=').append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII));
                query.append(fieldName).append('=').append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII));
                if (i != fieldNames.size() - 1) {
                    hashData.append('&');
                    query.append('&');
                }
            }

            String vnp_SecureHash = VnpayUtils.hmacSHA512(VnpayConfig.HASH_SECRET, hashData.toString());
            query.append("&vnp_SecureHash=").append(vnp_SecureHash);

            return "redirect:" + VnpayConfig.PAYMENT_URL + "?" + query;

        } catch (Exception e) {
            e.printStackTrace();
            return "errorPage";
        }
    }
}
