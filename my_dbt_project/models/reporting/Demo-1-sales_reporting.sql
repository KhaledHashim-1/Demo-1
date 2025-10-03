select
    f.order_id,
    f.date_key,
    f.payment_method,
    f.quantity,
    f.unit_price,
    f.discount,
    f.shipping_cost,

    -- Derived
    (f.quantity * f.unit_price - coalesce(f.discount,0) + coalesce(f.shipping_cost,0)) as total_amount,
    (f.quantity * f.unit_price - coalesce(f.discount,0) + coalesce(f.shipping_cost,0)) as gross_revenue,
    ((f.quantity * f.unit_price - coalesce(f.discount,0) + coalesce(f.shipping_cost,0)) * coalesce(s.profit_margin,0)) as estimated_profit,

    d.year,
    d.month,
    d.month_name,
    d.quarter,
    c.customer_gender,
    c.customer_age,
    c.region,
    p.category,
    f.returned,
    f.delivery_time_days
from {{ ref('Demo-1-fact_orders') }} f
left join {{ ref('Demo-1-dim_dates') }} d on f.date_key = d.date_key
left join {{ ref('Demo-1-dim_products') }} p on f.product_id = p.product_id
left join {{ ref('Demo-1-dim_customers') }} c on f.customer_id = c.customer_id
left join {{ ref('Demo-1-stg_ecommerce') }} s on f.order_id = s.order_id