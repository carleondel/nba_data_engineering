--- quitamos duplicados

WITH players AS (
    SELECT * 
    FROM {{ ref('base_fivetran_nba_games_data__players_') }}
    ),

ranked_players AS (
    SELECT
        player_team_season_id,
        TEAM_ID,
        SEASON,
        PLAYER_NAME,
        player_id,
        ROW_NUMBER() OVER (PARTITION BY player_team_season_id ORDER BY SEASON DESC) AS row_num    
    FROM players
    )

SELECT 
    player_team_season_id,
    TEAM_ID,
    SEASON,
    PLAYER_NAME,
    player_id
FROM ranked_players
WHERE row_num = 1