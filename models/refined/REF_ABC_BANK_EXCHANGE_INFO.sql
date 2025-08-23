WITH current_from_snapshot as (
    {{
        current_from_snapshot(snsh_ref = ref('SNSH_ABC_BANK_EXCHANGE_INFO'))
    }}
)
SELECT *
FROM current_from_snapshot