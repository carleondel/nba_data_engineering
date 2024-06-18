WITH players AS (
    SELECT * 
    FROM {{ ref('base_fivetran_nba_games_data__players_') }}
    ),

transformation AS (
    SELECT
          *
    FROM players
    )

SELECT * FROM transformation