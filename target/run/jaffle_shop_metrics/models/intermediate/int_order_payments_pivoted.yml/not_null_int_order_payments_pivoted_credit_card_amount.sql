select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select credit_card_amount
from "postgres"."public"."int_order_payments_pivoted"
where credit_card_amount is null



      
    ) dbt_internal_test