SELECT
    order_item_id,              --  PRIMARY KEY
    
    order_id,                   --  fct_orders 
    product_id,                 --  dim_products
    
    order_item_quantity,
    
    ROUND(unit_price, 2)        AS unit_price,
    order_item_discount,
    
    ROUND(gross_amount, 2)      AS gross_amount,
    ROUND(discount_amount, 2)   AS discount_amount,
    ROUND(revenue_net, 2)       AS revenue_net 

FROM {{ ref('stg_localbike__order_items') }}