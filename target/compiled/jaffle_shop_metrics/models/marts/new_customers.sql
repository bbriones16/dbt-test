select *,'statusss' as customer_status, '2018-01-01' as order_date
from -- depends on: "postgres"."public"."dbt_metrics_default_calendar"

(

with calendar as (
    select 
        * 
    from "postgres"."public"."dbt_metrics_default_calendar"
     
)

, model_97eaeb34ff7e06a477b06444c8f2a185__aggregate as (
    
    select
        first_name,
        count(distinct property_to_aggregate__rolling_new_customers) as rolling_new_customers
    from (
        select 
            
            base_model.first_name,
            (customer_id) as property_to_aggregate__rolling_new_customers
        from "postgres"."public"."stg_customers" base_model 
        
        where 1=1
        
    ) as base_query

    where 1=1
    group by 1

), model_97eaeb34ff7e06a477b06444c8f2a185__final as (
    
    select
        parent_metric_cte.first_name,
        coalesce(rolling_new_customers, 0) as rolling_new_customers
    from model_97eaeb34ff7e06a477b06444c8f2a185__aggregate as parent_metric_cte
)

select
    first_name,
    rolling_new_customers  
    
from model_97eaeb34ff7e06a477b06444c8f2a185__final
    
) metric_subq