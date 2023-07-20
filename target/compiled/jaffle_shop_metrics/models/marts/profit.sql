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
        date_week,
        customer_status,
        bool_or(metric_date_day is not null) as has_data,
        sum(property_to_aggregate__revenue) as revenue
    from (
        select 
            cast(base_model.order_date as date) as metric_date_day,
            calendar.date_week as date_week,
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
        parent_metric_cte.date_week,
        parent_metric_cte.customer_status,
        coalesce(revenue, 0) as revenue
    from model_ea058196f8910d3292d6d8ae211a2cc3__aggregate as parent_metric_cte
)



, model_e3e19d6da530c9e5ae6ef0cd58faeb9b__aggregate as (
    
    select
        date_week,
        customer_status,
        bool_or(metric_date_day is not null) as has_data,
        sum(property_to_aggregate__expenses) as expenses
    from (
        select 
            cast(base_model.order_date as date) as metric_date_day,
            calendar.date_week as date_week,
            calendar.date_day as window_filter_date,
            base_model.customer_status,
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
    group by 1, 2

), model_e3e19d6da530c9e5ae6ef0cd58faeb9b__final as (
    
    select
        parent_metric_cte.date_week,
        parent_metric_cte.customer_status,
        coalesce(expenses, 0) as expenses
    from model_e3e19d6da530c9e5ae6ef0cd58faeb9b__aggregate as parent_metric_cte
)


, first_join_metrics as (

    select
        date_week,
        coalesce(
            model_ea058196f8910d3292d6d8ae211a2cc3__final.customer_status,
            model_e3e19d6da530c9e5ae6ef0cd58faeb9b__final.customer_status
        ) as customer_status,  
        coalesce(revenue,0) as revenue,  
        coalesce(expenses,0) as expenses
    from model_ea058196f8910d3292d6d8ae211a2cc3__final
    full outer join model_e3e19d6da530c9e5ae6ef0cd58faeb9b__final
        using (
            date_week
            , customer_status
        ) 

)

, join_metrics__999 as (

    select
        first_join_metrics.*
        , (revenue - expenses) as profit
    from first_join_metrics
    
)

, joined_metrics as (

    select
        date_week,
        customer_status,
        revenue,
        expenses,
        profit
    from join_metrics__999

)

select
    date_week ,
    customer_status,
    revenue,
    expenses,
    profit  
from joined_metrics
    
order by 1 desc
    
) metric_subq