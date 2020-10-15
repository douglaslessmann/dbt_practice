with renamed as(
    select
        order_id as order_pk,
        customer_id as customer_fk,
        order_status,
        order_purchase_timestamp,
        order_approved_at,
        order_delivered_carrier_date,
        order_delivered_customer_date,
        order_estimated_delivery_date
    from
        {{ ref('olist_orders_dataset') }}
)
select
    *
from
    renamed