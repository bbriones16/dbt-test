select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select coupon_amount
from "postgres"."public"."int_order_payments_pivoted"
where coupon_amount is null



      
    ) dbt_internal_test