select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select had_credit_card_payment
from "postgres"."public"."int_order_payments_pivoted"
where had_credit_card_payment is null



      
    ) dbt_internal_test