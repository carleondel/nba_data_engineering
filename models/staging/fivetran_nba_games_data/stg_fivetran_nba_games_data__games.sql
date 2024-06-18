
WITH base_games AS (
    SELECT * 
    FROM {{ ref('base_fivetran_nba_games_data__games_') }}
    ),

transformation AS (
    SELECT
          *,
          {{ categorize_game_type('game_date') }} AS game_type
    FROM base_games
    )

SELECT * FROM transformation