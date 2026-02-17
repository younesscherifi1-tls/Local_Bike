
WITH staffs AS (
    SELECT 
        staff_id,
        staff_first_name,
        staff_last_name,
        staff_full_name,
        staff_email,
        staff_phone,
        store_id,
        manager_id,
        is_active
     FROM {{ ref('stg_localbike__staffs') }}
)

    SELECT
        s.staff_id,
        s.staff_full_name,
        s.staff_first_name,
        s.staff_last_name,
        s.staff_email,
        s.staff_phone,
        s.store_id,
        s.manager_id,
        s.is_active,

        m.staff_full_name AS manager_name
        
    FROM staffs AS s
    LEFT JOIN staffs AS m
        ON s.manager_id = m.staff_id


