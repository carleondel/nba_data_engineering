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
          game_id
        , game_date_est AS game_date
        , season
        , team_id_home
        , team_id_away
        , TO_DECIMAL(ROUND(ft_pct_home, 3), 38, 3) AS ft_pct_home
        , TO_DECIMAL(ROUND(ft_pct_away, 3), 38, 3) AS ft_pct_away
        , TO_DECIMAL(ROUND(fg_pct_home, 3), 38, 3) AS fg_pct_home
        , TO_DECIMAL(ROUND(fg_pct_away, 3), 38, 3) AS fg_pct_away
        , TO_DECIMAL(ROUND(fg3_pct_home, 3), 38, 3) AS fg3_pct_home
        , TO_DECIMAL(ROUND(fg3_pct_away, 3), 38, 3) AS fg3_pct_away
        , ast_home
        , ast_away
        --, game_status_text
        , reb_home
        , reb_away
        , pts_home
        , pts_away
        , home_team_wins
        --, home_team_id
        --, visitor_team_id
        , _fivetran_deleted
        , _fivetran_synced AS date_load
    FROM src_games
    ),

deduplicated AS (
    SELECT
        *,
        ROW_NUMBER() OVER (PARTITION BY game_id ORDER BY date_load DESC) AS row_num
        -- WE DROP DUPLICATE GAMES (GAME_ID)
    FROM renamed_casted
)

SELECT
    game_id,
    game_date,
    season,
    team_id_home,
    team_id_away,
    ft_pct_home,
    ft_pct_away,
    fg_pct_home,
    fg_pct_away,
    fg3_pct_home,
    fg3_pct_away,
    ast_home,
    ast_away,
    reb_home,
    reb_away,
    pts_home,
    pts_away,
    home_team_wins,
    _fivetran_deleted,
    date_load
FROM deduplicated
WHERE row_num = 1
-- we will only work with seasons BETWEEN 2009 AND 2019 since we don't have data for teams nor players out of that period
AND SEASON BETWEEN 2009 AND 2019