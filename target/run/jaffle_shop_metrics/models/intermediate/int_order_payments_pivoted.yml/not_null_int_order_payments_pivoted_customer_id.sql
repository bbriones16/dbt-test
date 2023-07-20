select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select customer_id
from "postgres"."public"."int_order_payments_pivoted"
where customer_id is null



      
    ) dbt_internal_test