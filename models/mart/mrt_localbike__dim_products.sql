SELECT

    p.product_id,   --  PRIMARY KEY

    p.product_name,
    p.model_year,
    p.unit_price,                   
    b.brand_name,
    cat.category_name

FROM {{ ref('stg_localbike__products') }} AS p
LEFT JOIN {{ ref('stg_localbike__brands') }} AS b
    ON p.brand_id = b.brand_id
LEFT JOIN {{ ref('stg_localbike__categories') }} AS cat
    ON p.category_id = cat.category_id