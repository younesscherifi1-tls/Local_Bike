select
        staff_id,
        first_name                                  AS staff_first_name,
        last_name                                   AS staff_last_name,
        CONCAT(first_name, ' ', last_name)          AS staff_full_name,
        email                                       AS staff_email,
        phone                                       AS staff_phone,
        store_id,
        CAST(NULLIF(manager_id, 'NULL')AS INT)      AS manager_id,
    CAST(active AS bool)                            AS is_active
from {{ source('local_bike_raw', 'staffs_staffs_csv') }}