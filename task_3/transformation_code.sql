CREATE TABLE CSV_OUTPUT AS
SELECT *
FROM (
  SELECT
    TransactionID,
    CASE 
      WHEN TRIM(Category) IS NULL OR TRIM(Category) = '' OR LOWER(Category) LIKE 'invalid%' THEN 'Unknown'
      ELSE Category
    END AS Category,
    
    CASE 
      WHEN TRIM(Product) IS NULL OR TRIM(Product) = '' OR LOWER(Product) LIKE 'invalid%' THEN 'Unknown'
      ELSE Product
    END AS Product,
    
    CASE
      WHEN REGEXP_CONTAINS(TransactionDate, r'^\d{4}-\d{2}-\d{2}$') THEN TransactionDate
      WHEN REGEXP_CONTAINS(TransactionDate, r'^\d{2}-\d{2}-\d{4} \d{2}:\d{2}:\d{2}$') THEN
        FORMAT_TIMESTAMP('%Y-%m-%d', PARSE_TIMESTAMP('%d-%m-%Y %H:%M:%S', TransactionDate))
      ELSE 'Unknown'
    END AS TransactionDate,

    Quantity,
    Price,

    CASE 
      WHEN SAFE_CAST(Quantity AS FLOAT64) IS NOT NULL AND SAFE_CAST(Quantity AS FLOAT64) >= 0
           AND SAFE_CAST(Price AS FLOAT64) IS NOT NULL AND SAFE_CAST(Price AS FLOAT64) >= 0
           AND SAFE_CAST(TotalValue AS FLOAT64) != SAFE_CAST(Quantity AS FLOAT64) * SAFE_CAST(Price AS FLOAT64)
      THEN SAFE_CAST(Quantity AS FLOAT64) * SAFE_CAST(Price AS FLOAT64)
      ELSE SAFE_CAST(TotalValue AS FLOAT64)
    END AS TotalValue,

    CustomerID,
  
    CASE 
      WHEN TRIM(PaymentMethod) IS NULL OR TRIM(PaymentMethod) = '' OR LOWER(PaymentMethod) LIKE 'unknown%' OR LOWER(PaymentMethod) LIKE 'unsupportedmethod' THEN 'Unknown'
      ELSE PaymentMethod
    END AS PaymentMethod,
  
  	CASE 
      WHEN TRIM(ShippingAddress) IS NULL OR TRIM(ShippingAddress) = '' OR LOWER(ShippingAddress) LIKE 'unknown%' THEN 'Unknown'
      ELSE ShippingAddress
    END AS ShippingAddress,
  
  	CASE 
      WHEN TRIM(Email) IS NULL OR TRIM(Email) = '' OR LOWER(Email) LIKE 'invalid_email' OR LOWER(Email) LIKE 'not_an_email' THEN 'Unknown'
      ELSE Email
    END AS Email,
  
  	CASE 
      WHEN TRIM(OrderStatus) IS NULL OR TRIM(OrderStatus) = '' OR LOWER(OrderStatus) LIKE 'unknownstatus' THEN 'Unknown'
      ELSE OrderStatus
    END AS OrderStatus,
  
    DiscountCode,
    PaymentAmount

  FROM csv_input
  WHERE
    SAFE_CAST(Quantity AS FLOAT64) IS NOT NULL AND SAFE_CAST(Quantity AS FLOAT64) >= 0
    AND SAFE_CAST(Price AS FLOAT64) IS NOT NULL AND SAFE_CAST(Price AS FLOAT64) >= 0
    AND SAFE_CAST(TotalValue AS FLOAT64) IS NOT NULL AND SAFE_CAST(Price AS FLOAT64) >= 0
    AND SAFE_CAST(PaymentAmount AS FLOAT64) IS NOT NULL AND SAFE_CAST(Price AS FLOAT64) >= 0
) AS cleaned
WHERE
  (TRIM(DiscountCode) IS NOT NULL AND TRIM(DiscountCode) != ''
    AND SAFE_CAST(TotalValue AS FLOAT64) >= SAFE_CAST(PaymentAmount AS FLOAT64))
  OR ABS(SAFE_CAST(TotalValue AS FLOAT64) - SAFE_CAST(PaymentAmount AS FLOAT64)) < 0.01;