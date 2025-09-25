select distinct
    order_date,
    extract(year from order_date) as year,
    extract(month from order_date) as month,
    extract(day from order_date) as day,
    format_date('%B', order_date) as month_name,
    extract(quarter from order_date) as quarter
from {{ ref('Demo-1-stg_ecommerce') }}
where order_date is not null
