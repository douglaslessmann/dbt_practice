with stg_order_items as (
    select
        *,
        order_fk || '-' || product_fk as order_product_sk
    from
        {{ ref('stg_order_items') }}
),
itens_by_order as (
    select
        order_fk,
        product_fk,
        order_product_sk,
        price,
        SUM(freight_value) as order_freight_value,
        MAX(order_item_id) as product_quantitie
    from
        stg_order_items
    group by
        order_fk, product_fk, price, order_product_sk
),
itens_by_order_with_order_value as (
    select
        order_fk,
        product_fk,
        order_product_sk,
        price,
        order_freight_value,
        product_quantitie,
        price * product_quantitie as order_value_without_freight,
        (price * product_quantitie) + order_freight_value as order_value_with_freight
    from
        itens_by_order
)
select
    *
from
    itens_by_order_with_order_value