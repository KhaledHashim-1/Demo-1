with source as (
    select * from {{ source('khaled_projects', 'Demo-1-raw_ecommerce') }}
),
cleaned as (
    select
        cast(order_id as string) as order_id,
        cast(customer_id as string) as customer_id,
        cast(product_id as string) as product_id,
        cast(category as string) as category,
        safe_cast(price as numeric) as price,
        safe_cast(discount as numeric) as discount,
        safe_cast(quantity as int64) as quantity,
        cast(payment_method as string) as payment_method,
        cast(order_date as date) as order_date,
        safe_cast(delivery_time_days as int64) as delivery_time_days,
        cast(region as string) as region,
        cast(returned as string) as returned,
        safe_cast(total_amount as numeric) as total_amount,
        safe_cast(shipping_cost as numeric) as shipping_cost,
        safe_cast(profit_margin as numeric) as profit_margin,
        safe_cast(customer_age as int64) as customer_age,
        cast(customer_gender as string) as customer_gender
    from source
)
select * from cleaned