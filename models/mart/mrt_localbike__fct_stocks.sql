
WITH stocks AS (
    SELECT 
        stocks_id,
        store_id,
        product_id,
        stock_quantity 
    FROM {{ ref('stg_localbike__stocks') }}
),

products AS (
    SELECT 
        product_id,
        unit_price
    FROM {{ ref('stg_localbike__products') }}
)

SELECT

    s.stocks_id,                    --  PRIMARY KEY

    s.store_id,                     --  dim_stores
    s.product_id,                   --  dim_products
    
    s.stock_quantity,               

    s.stock_quantity * p.unit_price                     AS stock_value, 

    CASE
        WHEN s.stock_quantity = 0 THEN 'out_of_stock'
        WHEN s.stock_quantity <= 9 THEN 'low_stock'
        WHEN s.stock_quantity >= 10 THEN 'in_stock'
    END                                                 AS stock_status

FROM stocks AS s
LEFT JOIN products AS p
    ON s.product_id = p.product_id