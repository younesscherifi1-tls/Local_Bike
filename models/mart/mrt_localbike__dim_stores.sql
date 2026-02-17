SELECT
    store_id,   --  PRIMARY KEY
    
    store_name,
    store_phone,
    store_email,
    store_street,
    store_city,
    store_state,
    store_zip_code

FROM {{ ref('stg_localbike__stores') }}