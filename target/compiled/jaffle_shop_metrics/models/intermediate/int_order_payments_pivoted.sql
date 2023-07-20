

with orders as (

    select * from "postgres"."public_dbt_test"."orderStaging"

),

payments as (

    select * from "postgres"."public"."stg_payments"

),

order_payments as (

    select
        order_id,

        sum(case when payment_method = 'credit_card' then amount else 0 end) as credit_card_amount,
        sum(case when payment_method = 'coupon' then amount else 0 end) as coupon_amount,
        sum(case when payment_method = 'bank_transfer' then amount else 0 end) as bank_transfer_amount,
        sum(case when payment_method = 'gift_card' then amount else 0 end) as gift_card_amount,
        sum(amount) as total_amount

    from payments

    group by order_id

),

final as (

    select
        orders.order_id,
        orders.customer_id,
        orders.order_date,
        orders.status,

        order_payments.credit_card_amount,
        case 
            when credit_card_amount is not null then true
            else false 
        end as had_credit_card_payment,

        order_payments.coupon_amount,
        case 
            when coupon_amount is not null then true
            else false 
        end as had_coupon_payment,

        order_payments.bank_transfer_amount,
        case 
            when bank_transfer_amount is not null then true
            else false 
        end as had_bank_transfer_payment,

        order_payments.gift_card_amount,
        case 
            when gift_card_amount is not null then true
            else false 
        end as had_gift_card_payment,

        order_payments.total_amount as amount

    from orders


    left join order_payments
        on orders.order_id = order_payments.order_id

)

select * from final