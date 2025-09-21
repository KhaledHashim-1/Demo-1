select distinct
    customer_id,
    customer_age,
    customer_gender,
    region
from {{ ref('Demo-1-stg_ecommerce') }}
