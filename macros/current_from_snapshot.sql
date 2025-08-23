{% macro current_from_snapshot(snsh_ref) %}

    SELECT 
        *
        EXCLUDE (DBT_SCD_ID, DBT_UPDATED_AT, DBT_VALID_FROM, DBT_VALID_TO)
    FROM {{ snsh_ref }}
    WHERE DBT_VALID_TO is null

{% endmacro %}