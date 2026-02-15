
-- TEST: required_date must be >= order_date
-- Business rule: A customer cannot request a delivery date before the order date
-- This test returns orders that VIOLATE this rule (should return 0 rows)


SELECT
  order_id,
  order_created_at,
  order_required_at
  
FROM {{ ref('stg_localbike__orders') }}

WHERE 
  -- Violation: required_date is before order_date
  order_required_at < order_created_at