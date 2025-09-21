with source as (
    select * from {{ source('khaled_projects', 'Demo-1-raw_ecommerce') }}
),
cleaned as (
    select
        cast(order_id as string) as order_id,
        cast(customer_id as string) as customer_id,
        cast(product_id as string) as product_id,
        category,
        cast(price as numeric) as price,
        cast(discount as numeric) as discount,
        cast(quantity as int64) as quantity,
        payment_method,
        order_date,
        cast(delivery_time_days as int64) as delivery_time_days,
        region,
        returned,
        cast(total_amount as numeric) as total_amount,
        cast(shipping_cost as numeric) as shipping_cost,
        cast(profit_margin as numeric) as profit_margin,
        cast(customer_age as int64) as customer_age,
        customer_gender
    from source
)
select * from cleaned
