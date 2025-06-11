-- Tạo bảng paymentmethods
CREATE TABLE paymentmethods (
    paymentMethodID INT PRIMARY KEY,
    methodName VARCHAR(50) NOT NULL
);

-- Chèn dữ liệu mẫu
INSERT INTO paymentmethods (paymentMethodID, methodName) VALUES 
(1, 'vnpay'),    -- ID 1 cho VNPay
(2, 'cash');     -- ID 2 cho thanh toán tiền mặt 