select distinct
    product_id,
    category
from {{ ref('Demo-1-stg_ecommerce') }}