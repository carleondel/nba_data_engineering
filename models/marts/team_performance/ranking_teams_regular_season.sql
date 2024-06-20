
--- RANKING % VICTORIAS REGULAR SEASON. SEASONS 2009-2019



WITH home_results AS (
    SELECT 
        TEAM_ID_HOME AS team_id,
        COUNT(*) AS home_games,
        SUM(HOME_TEAM_WINS) AS home_wins,
        SUM(CASE WHEN HOME_TEAM_WINS = 0 THEN 1 ELSE 0 END) AS home_losses
    FROM 
        {{ ref('fct_games') }}
    WHERE 
        SEASON BETWEEN 2009 AND 2019
        AND GAME_TYPE = 'Regular Season'
    GROUP BY 
        TEAM_ID_HOME
),
away_results AS (
    SELECT 
        TEAM_ID_AWAY AS team_id,
        COUNT(*) AS away_games,
        SUM(CASE WHEN HOME_TEAM_WINS = 0 THEN 1 ELSE 0 END) AS away_wins,
        SUM(HOME_TEAM_WINS) AS away_losses
    FROM 
        {{ ref('fct_games') }}
    WHERE 
        SEASON BETWEEN 2009 AND 2019
        AND GAME_TYPE = 'Regular Season'
    GROUP BY 
        TEAM_ID_AWAY
),
total_results AS (
    SELECT 
        home.team_id,
        home.home_wins + away.away_wins AS total_wins,
        home.home_losses + away.away_losses AS total_losses,
        home.home_games + away.away_games AS total_games
    FROM 
        home_results home
    JOIN 
        away_results away
    ON 
        home.team_id = away.team_id
),
ranked_teams AS (
    SELECT
        t.team_id,
        t.team_name,
        r.total_wins,
        r.total_losses,
        r.total_games,
        ROUND((r.total_wins / r.total_games) * 100, 2) AS win_percentage,
        ROW_NUMBER() OVER (ORDER BY win_percentage DESC) AS rank
    FROM 
        total_results r
    JOIN 
        {{ ref('dim_teams') }} t
        ON r.team_id = t.team_id
)
SELECT 
    rank,
    --team_id,
    team_name,
    total_wins,
    total_losses,
    win_percentage
FROM 
    ranked_teams
ORDER BY 
    rank
