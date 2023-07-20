with orders as (

    select * from {{ ref('int_order_payments_pivoted') }}

)
,
customers as (

    select * from {{ ref('raw_customers') }}

)
,
final as (

    select 
        *
    from orders 
    left join customers on orders.customer_id=customers.id

)

select * from final

