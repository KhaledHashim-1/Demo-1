select
    order_id,
    customer_id,
    product_id,
    order_date as date_key,
    payment_method,
    quantity,
    price as unit_price,
    discount,
    shipping_cost,
    returned,
    delivery_time_days
from {{ ref('Demo-1-stg_ecommerce') }}