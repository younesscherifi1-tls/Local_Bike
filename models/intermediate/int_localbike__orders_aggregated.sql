WITH order_items_agg AS (
    SELECT
        order_id,
        COUNT(*)                    AS total_line_items,
        COUNT(DISTINCT product_id)  AS total_distinct_products,
        SUM(order_item_quantity)    AS total_items_quantity,
        SUM(gross_amount)           AS total_gross_amount,
        SUM(discount_amount)        AS total_discount_amount,
        SUM(revenue_net)            AS total_revenue_net,
        MAX(order_item_discount)    AS max_discount_rate,       
        AVG(unit_price)             AS avg_unit_price,
        MIN(unit_price)             AS min_unit_price,
        MAX(unit_price)             AS max_unit_price
    FROM {{ ref('stg_localbike__order_items') }}
    GROUP BY order_id
)

SELECT
    o.order_id,
    o.customer_id,
    o.store_id,
    o.staff_id,
    o.order_status,
    o.order_created_at,
    o.order_required_at,
    o.shipped_at,
    oi.total_line_items,
    oi.total_distinct_products,
    oi.total_items_quantity,
    oi.total_gross_amount,
    oi.total_discount_amount,
    oi.total_revenue_net,
    oi.max_discount_rate,       
    oi.avg_unit_price,
    oi.min_unit_price,
    oi.max_unit_price
FROM {{ ref('stg_localbike__orders') }} o
LEFT JOIN order_items_agg oi
    ON o.order_id = oi.order_id