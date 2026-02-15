select
    CONCAT(order_id, '_', item_id)          AS order_item_id,
    order_id,
    product_id,
    quantity                                AS order_item_quantity,
    CAST(list_price AS NUMERIC)             AS unit_price,
    CAST(discount   AS NUMERIC)             AS order_item_discount,
    quantity * list_price                   AS gross_amount,
    quantity * list_price * discount        AS discount_amount,
    quantity * list_price * (1 - discount)  AS revenue_net
from {{ source('local_bike_raw', 'order_items_order_items_csv') }}