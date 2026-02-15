select
    category_id,
    category_name
from {{ source('local_bike_raw', 'categories_categories_csv') }}