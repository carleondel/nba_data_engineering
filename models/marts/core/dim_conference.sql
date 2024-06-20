WITH stg_conference_teams AS (
    SELECT * 
    FROM {{ ref('stg_enriched_data__conference_teams') }}
    ),

filtering AS (
    SELECT
        team_id
        --, abbreviation
        , conference
        --, date_load -- Conversión a UTC.

    FROM stg_conference_teams
    )

SELECT * FROM filtering