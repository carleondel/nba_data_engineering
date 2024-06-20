--  Incremental
{{ config(
    materialized='incremental',
    unique_key = 'team_id'
    ) 
}}

--  Extracción de la fuente origen (tabla origen). 
WITH src_conference AS (
    SELECT * 
    FROM {{ source('other_sources', 'conference_teams') }}

{% if is_incremental() %}
WHERE _fivetran_synced > (select max(date_load) from {{ this }}) 
{% endif %}
),

--  Transformaciones y conversiones.
renamed_casted AS (
    SELECT
        team_id
        , abbreviation
        , conference
        , _fivetran_synced::timestamp AS date_load

FROM src_conference
)
SELECT * FROM renamed_casted