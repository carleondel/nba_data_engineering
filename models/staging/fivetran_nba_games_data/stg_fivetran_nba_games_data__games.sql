
WITH base_games AS (
    SELECT * 
    FROM {{ ref('base_fivetran_nba_games_data__games_') }}
    ),

possible_transformation AS (
    SELECT
          *
    FROM base_games
    )

SELECT * FROM possible_transformation