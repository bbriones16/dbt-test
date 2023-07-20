


with source as (
    select * from "postgres"."public"."order"

),
source_2 as (
    select * from "postgres"."public"."customer"

),
source_3 as (

    select * from "postgres"."public"."stg_customers"

),
source_4 as (

    select user_id from "postgres"."public"."raw_orders"

),


renamed as (

    select
        id as order_id,
        user_id as customer_id,
        order_date,
        status

    from source
	where order_date in ('2018-01-14')

)

select * from renamed