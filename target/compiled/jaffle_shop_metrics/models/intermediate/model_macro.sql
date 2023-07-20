select
  payment_id,
  
    (amount / 100)::numeric(16, 2)
 as amount_usd
from "postgres"."public"."stg_payments"