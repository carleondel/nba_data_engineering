-- SON DATOS A 2019

WITH stg_teams AS (
    SELECT * 
    FROM {{ ref('stg_fivetran_nba_games_data__teams') }}
    ),

transformations AS (
    SELECT
        team_id,
        team_name,
        abbreviation,
        headcoach,
        generalmanager,
        owner,
        city,
        arenacapacity,
        yearfounded,
        arena,
        dleagueaffiliation
        --_fivetran_deleted,
        --_fivetran_synced
    FROM stg_teams
    )

SELECT * FROM transformations

