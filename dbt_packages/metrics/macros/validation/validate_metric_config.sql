{%- macro validate_metric_config(metrics_dictionary) -%}

    {#- We loop through the metrics dictionary here to ensure that
    1) all configs are real configs we know about
    2) all of those have valid values passed
    returned or used, not just those listed -#}

    {%- set accepted_configs = {
        "enabled" : {"accepted_values" : [True, False]},
        "treat_null_values_as_zero" : {"accepted_values" : [True, False]},
        "restrict_no_time_grain" : {"accepted_values" : [True, False]}
        }
    -%}

    {%- for metric in metrics_dictionary -%}
        {%- set metric_config = metrics_dictionary[metric].get("config", none) -%}
        {%- if metric_config -%}
            {%- for config in metric_config -%}
                
            {%- endfor %}
        {%- endif -%}
    {%- endfor %}
            


{%- endmacro -%}