select
    order_id,
    customer_id,
    product_id,
    order_date,
    payment_method,
    quantity,
    price,
    discount,
    total_amount,
    shipping_cost,
    profit_margin,
    (quantity * price) - coalesce(discount, 0) + coalesce(shipping_cost, 0) as gross_revenue,
    ( (quantity * price) - coalesce(discount, 0) + coalesce(shipping_cost, 0) ) * coalesce(profit_margin, 0) as estimated_profit,
    delivery_time_days,
    returned
from {{ ref('Demo-1-stg_ecommerce') }}
