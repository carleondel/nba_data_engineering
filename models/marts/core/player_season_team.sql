-- TABLA PUENTE -- RELACIONES SEASON-TEAM-PLAYER
WITH player_season_team AS (
    SELECT * 
    FROM {{ ref('stg_fivetran_nba_games_data__players') }}
    ),

transformations AS (
    SELECT
        player_team_season_id,
        team_id,
        season,
        --player_name,
        player_id,
        --_fivetran_deleted,
        --_fivetran_synced
    FROM player_season_team
    )

SELECT * FROM transformations