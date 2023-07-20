with orders as (

    select * from "postgres"."public"."int_order_payments_pivoted"

)
,
customers as (

    select * from "postgres"."public"."raw_customers"

)
,
final as (

    select 
        *
    from orders 
    left join customers on orders.customer_id=customers.id

)

select * from final