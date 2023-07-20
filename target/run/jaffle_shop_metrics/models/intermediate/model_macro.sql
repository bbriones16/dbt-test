
  
    

  create  table "postgres"."public"."model_macro__dbt_tmp"
  
  
    as
  
  (
    select
  payment_id,
  
    (amount / 100)::numeric(16, 2)
 as amount_usd
from "postgres"."public"."stg_payments"
  );
  