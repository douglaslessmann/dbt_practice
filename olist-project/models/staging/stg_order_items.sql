with renamed as(
    select
        order_id as order_fk,
        order_item_id,
        product_id as product_fk,
        seller_id as seller_fk,
        shipping_limit_date,
        price,
        freight_value
    from
        {{ ref('olist_order_items_dataset') }}
)
select
    *
from
    renamed