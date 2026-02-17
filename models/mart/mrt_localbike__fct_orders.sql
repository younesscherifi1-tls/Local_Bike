SELECT
    order_id,                       -- → PRIMARY KEY
    
    customer_id,                    -- → dim_customers
    store_id,                       -- → dim_stores
    staff_id,                       -- → dim_staffs

    order_status,
    CASE order_status
            WHEN 1 THEN 'Pending'
            WHEN 2 THEN 'Processing'
            WHEN 3 THEN 'Rejected'
            WHEN 4 THEN 'Completed'
            ELSE 'Other'
            END                         AS order_status_description,
    order_created_at,
    order_required_at,
    shipped_at,
    
    total_line_items,
    total_distinct_products,
    total_items_quantity,

    ROUND(total_gross_amount,2)         AS total_gross_amount,
    ROUND(total_discount_amount,2)      AS total_discount_amount,
    ROUND(total_revenue_net,2)          AS total_revenue_net,              

    max_discount_rate                   AS maximum_discount_rate,
    ROUND(avg_unit_price,2)             AS average_unit_price,
    ROUND(min_unit_price,2)             AS minimum_unit_price,
    ROUND(max_unit_price,2)             AS maximum_unit_price

FROM {{ ref('int_localbike__orders_aggregated') }}