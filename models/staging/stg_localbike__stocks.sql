select
    CONCAT(store_id, '_', product_id)   AS stocks_id,
    store_id,
    product_id,
    quantity                            AS stock_quantity
from {{ source('local_bike_raw', 'stocks_stocks_csv') }}