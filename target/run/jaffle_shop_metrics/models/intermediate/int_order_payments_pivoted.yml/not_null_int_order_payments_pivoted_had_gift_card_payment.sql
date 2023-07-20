select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select had_gift_card_payment
from "postgres"."public"."int_order_payments_pivoted"
where had_gift_card_payment is null



      
    ) dbt_internal_test