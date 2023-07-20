select * 
from -- depends on: "postgres"."public"."dbt_metrics_default_calendar"

(

with calendar as (
    select 
        * 
    from "postgres"."public"."dbt_metrics_default_calendar"
     
)

, model_6a913ad407016e4c1d836bf64cdcb732__aggregate as (
    
    select
        date_week,
        bool_or(metric_date_day is not null) as has_data,
        avg(property_to_aggregate__average_order_amount) as average_order_amount
    from (
        select 
            cast(base_model.order_date as date) as metric_date_day,
            calendar.date_week as date_week,
            calendar.date_day as window_filter_date,
            (amount) as property_to_aggregate__average_order_amount
        from "postgres"."public"."orders" base_model 
        
        left join calendar
            on cast(base_model.order_date as date) = calendar.date_day
        
        where 1=1
        
    ) as base_query

    where 1=1
    group by 1

), model_6a913ad407016e4c1d836bf64cdcb732__final as (
    
    select
        parent_metric_cte.date_week,
        coalesce(average_order_amount, 0) as average_order_amount
    from model_6a913ad407016e4c1d836bf64cdcb732__aggregate as parent_metric_cte
)

select
    date_week ,
    average_order_amount  
    
from model_6a913ad407016e4c1d836bf64cdcb732__final
    
order by 1 desc
    
) metric_subq