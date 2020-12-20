select
    product_pk,
    case
        when product_category_name is null then 'sem_categoria'
        else product_category_name
    end as product_category_name,
    product_name_lenght,
    product_description_lenght,
    product_photos_qty,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm
from
    {{ ref('stg_products') }}