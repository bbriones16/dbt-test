
  
    

  create  table "postgres"."public"."revenue__dbt_tmp"
  
  
    as
  
  (
    select *
from -- depends on: "postgres"."public"."dbt_metrics_default_calendar"

(

with calendar as (
    select 
        * 
    from "postgres"."public"."dbt_metrics_default_calendar"
     
)

, model_ea058196f8910d3292d6d8ae211a2cc3__aggregate as (
    
    select
        date_day,
        customer_status,
        bool_or(metric_date_day is not null) as has_data,
        sum(property_to_aggregate__revenue) as revenue
    from (
        select 
            cast(base_model.order_date as date) as metric_date_day,
            calendar.date_day as date_day,
            calendar.date_day as window_filter_date,
            base_model.customer_status,
            (amount) as property_to_aggregate__revenue
        from "postgres"."public"."orders_2" base_model 
        
        left join calendar
            on cast(base_model.order_date as date) = calendar.date_day
        
        where 1=1
        and (
            status = 'completed'
            )
    
        
    ) as base_query

    where 1=1
    group by 1, 2

), model_ea058196f8910d3292d6d8ae211a2cc3__final as (
    
    select
        parent_metric_cte.date_day,
        parent_metric_cte.customer_status,
        coalesce(revenue, 0) as revenue
    from model_ea058196f8910d3292d6d8ae211a2cc3__aggregate as parent_metric_cte
)

select
    date_day ,
    customer_status,
    revenue  
    
from model_ea058196f8910d3292d6d8ae211a2cc3__final
    
order by 1 desc
    
) metric_subq
  );
  