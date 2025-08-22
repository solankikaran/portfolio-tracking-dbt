{{ config(materialized='ephemeral') }}

WITH src_data AS (
    SELECT
        Name       AS NAME,
        ID         AS ID,
        Country    AS COUNTRY,
        City       AS CITY,
        Zone       AS ZONE,
        Delta      AS DELTA,
        DST_period AS DST_PERIOD,
        Open       AS OPEN,
        Close      AS CLOSE,
        Lunch      AS LUNCH,
        Open_UTC   AS OPEN_UTC,
        Close_UTC  AS CLOSE_UTC,
        Lunch_UTC  AS LUNCH_UTC,
        LOAD_TS    AS LOAD_TS,
        'SEED.ABC_BANK_EXCHANGE_INFO' AS RECORD_SOURCE
    FROM {{ source('seeds', 'ABC_Bank_EXCHANGE_INFO') }}
),
default_record as (
    SELECT
        'Missing'    AS NAME,
        '-1'         AS ID,
        'Missing'    AS COUNTRY,
        'Missing'    AS CITY,
        'Missing'    AS ZONE,
        '-1'    AS DELTA,
        'Missing'    AS DST_PERIOD,
        'Missing'    AS OPEN,
        'Missing'    AS CLOSE,
        'Missing'    AS LUNCH,
        'Missing'    AS OPEN_UTC,
        'Missing'    AS CLOSE_UTC,
        'Missing'    AS LUNCH_UTC,
        '2020-01-01' AS LOAD_TS_UTC,
        'Missing'    AS RECORD_SOURCE
),
with_default_record AS (
    SELECT * FROM src_data
    UNION ALL
    SELECT * FROM default_record
),
hashed AS (
    SELECT
        concat_ws('|', NAME) AS EXCHANGE_HKEY,
        concat_ws('|', NAME, ID, COUNTRY, CITY, ZONE) AS EXCHANGE_HDIFF
        , * EXCLUDE LOAD_TS
        , LOAD_TS as LOAD_TS_UTC
    FROM with_default_record
)
SELECT * FROM hashed