select *,'statusss' as customer_status, '2018-01-01' as order_date
from {{ 
    metrics.calculate(
        metric('rolling_new_customers'),
        
        dimensions=['first_name']
    )
}}