# Step5 Table DDL
轉出的Varchar跟Decimal大小需要再依需求調整
```
CREATE TABLE rebate_setting (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    product_type VARCHAR(255) NOT NULL,
    sub_product_type VARCHAR(255) NOT NULL,
    system_name VARCHAR(255) NOT NULL,
    sub_system_name VARCHAR(255) NOT NULL,
    commission_parameter VARCHAR(255) NOT NULL,
    order_product VARCHAR(255) NOT NULL,
    order_product_type VARCHAR(255) NOT NULL,
    commission_rate DECIMAL(12, 6) NOT NULL,
    rebate_rate DECIMAL(12, 6) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
```