with orders as (

    select * from "postgres"."public"."int_order_payments_pivoted"

)
,
customers as (

    select * from "postgres"."public"."int_customer_order_history_joined"

)
,
final as (

    select 
        *
    from orders 
    left join customers using (customer_id)

)

select * from final