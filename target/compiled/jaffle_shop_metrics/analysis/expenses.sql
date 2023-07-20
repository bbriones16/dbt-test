select * 
from -- depends on: "postgres"."public"."dbt_metrics_default_calendar"

(

with calendar as (
    select 
        * 
    from "postgres"."public"."dbt_metrics_default_calendar"
     
)

, model_e3e19d6da530c9e5ae6ef0cd58faeb9b__aggregate as (
    
    select
        date_week,
        bool_or(metric_date_day is not null) as has_data,
        sum(property_to_aggregate__expenses) as expenses
    from (
        select 
            cast(base_model.order_date as date) as metric_date_day,
            calendar.date_week as date_week,
            calendar.date_day as window_filter_date,
            (amount / 4) as property_to_aggregate__expenses
        from "postgres"."public"."orders" base_model 
        
        left join calendar
            on cast(base_model.order_date as date) = calendar.date_day
        
        where 1=1
        and (
            status = 'completed'
            )
    
        
    ) as base_query

    where 1=1
    group by 1

), model_e3e19d6da530c9e5ae6ef0cd58faeb9b__final as (
    
    select
        parent_metric_cte.date_week,
        coalesce(expenses, 0) as expenses
    from model_e3e19d6da530c9e5ae6ef0cd58faeb9b__aggregate as parent_metric_cte
)

select
    date_week ,
    expenses  
    
from model_e3e19d6da530c9e5ae6ef0cd58faeb9b__final
    
order by 1 desc
    
) metric_subq