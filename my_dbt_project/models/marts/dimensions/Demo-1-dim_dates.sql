select distinct
    order_date as date_key,
    extract(year from order_date) as year,
    extract(month from order_date) as month,
    extract(day from order_date) as day,
    format_date('%B', order_date) as month_name,
    extract(quarter from order_date) as quarter,
    extract(dayofweek from order_date) as day_of_week,
    case when extract(dayofweek from order_date) in (1,7) then true else false end as is_weekend
from {{ ref('Demo-1-stg_ecommerce') }}
where order_date is not null