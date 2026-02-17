SELECT
    c.customer_id,  --  PRIMARY KEY

    c.customer_full_name,
    c.customer_email,
    c.customer_phone,
    c.customer_street,
    c.customer_city,
    c.customer_state,
    c.customer_zip_code,
    
    cm.first_order_date,
    cm.last_order_date,
    cm.days_since_last_order,       
    cm.customer_lifetime_days,
    
    COALESCE(cm.is_new_customer, FALSE) AS is_new_customer,
    COALESCE(cm.is_returning_customer, FALSE) AS is_returning_customer,
    COALESCE(cm.is_high_value_customer, FALSE) AS is_high_value_customer,
    COALESCE(cm.is_at_risk_customer, FALSE) AS is_at_risk_customer

FROM {{ ref('stg_localbike__customers') }} AS c
LEFT JOIN {{ ref('int_localbike_customer__aggregated') }} AS cm
    ON c.customer_id = cm.customer_id