{% macro as_sql_list(hashed_fields_list) %}

    {{ hashed_fields|join(', ') }}

{% endmacro %}