select
    order_id,
    customer_id,
    store_id,
    staff_id,
    CAST(order_status AS INT64)         AS order_status,
    order_date                          AS order_created_at,
    required_date                       AS order_required_at,
    DATE(NULLIF(shipped_date, 'NULL'))  AS shipped_at
from {{ source('local_bike_raw', 'orders_orders_csv') }}