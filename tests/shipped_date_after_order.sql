  SELECT
  order_id,
  order_created_at,
  shipped_at
  
FROM {{ ref('stg_localbike__orders') }}
WHERE 
  -- Only check orders that have been shipped (not NULL)
  shipped_at IS NOT NULL
  
  -- Violation: shipped_date is before order_date
  AND shipped_at < order_created_at