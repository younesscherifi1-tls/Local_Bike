WITH orders_aggregated AS (
    SELECT
        order_id,
        customer_id,
        --store_id,
        --staff_id,
        --order_status,
        order_created_at,
        --order_required_at,
        --shipped_at,
        --total_line_items,
        total_distinct_products,
        total_items_quantity,
        --total_gross_amount,
        total_discount_amount,
        total_revenue_net
        --,max_discount_rate,       
        --avg_unit_price,
        --min_unit_price,
        --max_unit_price
    FROM {{ ref('int_localbike__orders_aggregated') }}
    WHERE total_items_quantity > 0
    )


select
    customer_id,
    COUNT(DISTINCT order_id)                                    AS total_orders,
    SUM(total_items_quantity)                                   AS total_items_purchased,
    AVG(total_revenue_net)                                      AS avg_order_value,
    SUM(total_discount_amount)                                  AS total_discount_received,
    AVG(total_items_quantity)                                   AS avg_items_per_order,
    SUM(total_distinct_products)                                AS total_distinct_products_purchased,
        
    MIN(order_created_at)                                       AS first_order_date,
    MAX(order_created_at)                                       AS last_order_date,
    DATE_DIFF(CURRENT_DATE(), MAX(order_created_at), DAY)       AS days_since_last_order,
    DATE_DIFF(MAX(order_created_at), MIN(order_created_at), DAY) 
                                                                AS customer_lifetime_days,
    CASE WHEN COUNT(DISTINCT order_id) = 1 THEN TRUE ELSE FALSE END 
                                                                AS is_new_customer,
    CASE WHEN COUNT(DISTINCT order_id) >= 2 THEN TRUE ELSE FALSE END 
                                                                AS is_returning_customer,
    CASE WHEN SUM(total_revenue_net) > 1000 THEN TRUE ELSE FALSE END 
                                                                AS is_high_value_customer,
    CASE WHEN DATE_DIFF(CURRENT_DATE(), MAX(order_created_at), DAY) > 365 
    THEN TRUE ELSE FALSE END                                    AS is_at_risk_customer

FROM orders_aggregated 
GROUP BY customer_id