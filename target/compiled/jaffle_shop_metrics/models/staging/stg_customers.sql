with source as (
    select * from "postgres"."public"."customer"

),

renamed as (

    select
        id as customer_id,
        first_name,
        last_name

    from source

)

select * from renamed