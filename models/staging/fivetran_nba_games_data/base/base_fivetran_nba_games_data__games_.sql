{{
  config(
    materialized='view'
  )
}}

WITH src_games AS (
    SELECT * 
    FROM {{ source('_fivetran_nba_games_data', 'games') }}
    ),

renamed_casted AS (
    SELECT
          team_id_home
        , team_id_away
        , TO_DECIMAL(ROUND(ft_pct_away, 3), 38, 3) AS ft_pct_away
        , TO_DECIMAL(ROUND(ft_pct_home, 3), 38, 3) AS ft_pct_home
        , reb_home
        , TO_DECIMAL(ROUND(fg_pct_home, 3), 38, 3) AS fg_pct_home
        , TO_DECIMAL(ROUND(fg3_pct_home, 3), 38, 3) AS fg3_pct_home
        , TO_DECIMAL(ROUND(fg_pct_away, 3), 38, 3) AS fg_pct_away
        , ast_home
        , game_id
        , TO_DECIMAL(ROUND(fg3_pct_away, 3), 38, 3) AS fg3_pct_away
        , ast_away
        , game_status_text
        , reb_away
        , season
        , pts_away
        , pts_home
        , game_date_est
        , home_team_id
        , home_team_wins
        , visitor_team_id
        , _fivetran_deleted
        , _fivetran_synced AS date_load
    FROM src_games
    )

SELECT * FROM renamed_casted