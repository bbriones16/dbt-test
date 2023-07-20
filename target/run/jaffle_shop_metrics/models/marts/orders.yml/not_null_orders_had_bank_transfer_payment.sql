select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select had_bank_transfer_payment
from "postgres"."public"."orders"
where had_bank_transfer_payment is null



      
    ) dbt_internal_test