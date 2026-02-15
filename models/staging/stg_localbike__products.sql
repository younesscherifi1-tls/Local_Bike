select
    product_id,
    brand_id,
    category_id,
    product_name,     
    model_year,
    CAST(list_price AS NUMERIC) AS unit_price
from {{ source('local_bike_raw', 'products_products_csv') }}