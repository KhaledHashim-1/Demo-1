select distinct
    product_id,
    category,
    price,
    discount,
    profit_margin
from {{ ref('Demo-1-stg_ecommerce') }}
