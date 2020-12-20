with fct_orders as(
    select
        order_fk,
        product_fk,
        price,
        product_quantitie,
        order_value_without_freight
    from
        {{ ref('fct_orders') }}
),
dim_products as (
    select
        product_pk,
        product_category_name
    from
        {{ ref('dim_products') }}
),
dim_orders as (
    select
        order_pk,
        cast(order_purchase_timestamp as date) as order_date
    from
        {{ ref('dim_orders') }}
),
ordered_products_by_month as (
    select
        b.product_category_name,
        date_trunc('month', c.order_date) as order_month,
        sum(a.product_quantitie) as sum_product_quantitie,
        sum(a.order_value_without_freight) as sum_order_value_without_freight,
        avg(a.order_value_without_freight) as avg_order_value_without_freight
    from
        fct_orders a
        inner join dim_products b on a.product_fk = b.product_pk
        inner join dim_orders c on a.order_fk = c.order_pk
    group by
        product_category_name,
        order_month
)
select
    *
from
    ordered_products_by_month