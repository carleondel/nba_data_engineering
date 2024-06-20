-- we add the game_category & remove some columns

WITH base_games AS (
    SELECT * 
    FROM {{ ref('base_fivetran_nba_games_data__games_') }}
    ),

transformation AS (
    SELECT
          game_id
        , game_date
        , season
        , team_id_home
        , team_id_away
        , ft_pct_home
        , ft_pct_away
        , fg_pct_home
        , fg_pct_away
        , fg3_pct_home
        , fg3_pct_away
        , ast_home
        , ast_away
        , reb_home
        , reb_away
        , pts_home
        , pts_away
        , home_team_wins
        --, _fivetran_deleted
        --, date_load,
          ,{{ categorize_game_type('game_date') }} AS game_type
    FROM base_games
    )

SELECT * FROM transformation