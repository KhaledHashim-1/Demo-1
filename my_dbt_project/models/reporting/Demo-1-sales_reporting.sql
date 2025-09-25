SELECT
    f.order_id,
    f.order_date,
    f.payment_method,
    f.quantity,
    f.price,
    f.discount,
    f.total_amount,
    f.shipping_cost,
    f.gross_revenue,
    f.estimated_profit,
    d.year,
    d.month,
    d.day,
    p.category,
    c.customer_gender,
    c.customer_age,
    c.region,
    f.returned
FROM {{ ref('Demo-1-fact_orders') }} f
LEFT JOIN {{ ref('Demo-1-dim_dates') }} d 
    ON f.order_date = d.order_date
LEFT JOIN {{ ref('Demo-1-dim_products') }} p 
    ON f.product_id = p.product_id
LEFT JOIN {{ ref('Demo-1-dim_customers') }} c 
    ON f.customer_id = c.customer_id
