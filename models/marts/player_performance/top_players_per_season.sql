-- dbt
-- top 5 jugadores x PER x temporada 2009-2019

WITH player_per_season AS (
    SELECT 
        gd.player_id,
        p.player_name,
        t.team_name,
        gst.season,
        AVG(gd.player_efficiency_rating) AS avg_per,
        AVG(gd.pts) as avg_pts,
        AVG(ast) as avg_ast,
        AVG(reb) as avg_reb,
        AVG(min) as avg_min
    FROM 
        {{ ref('fct_games_details') }} gd
    JOIN 
        {{ ref('dim_players') }} p
        ON gd.player_id = p.player_id
    JOIN 
        {{ ref('dim_teams') }} t
        ON gd.team_id = t.team_id
    JOIN 
        {{ ref('player_season_team') }} gst
        ON gd.player_id = gst.player_id AND gd.team_id = gst.team_id
    WHERE 
        gd.min > 15
    -- esto es porque mi macro solo calcula PER para minimo 15 min jugados (evitar nulos)
    GROUP BY 
        gd.player_id, p.player_name, t.team_name, gst.season
),
ranked_players AS (
    SELECT
        player_id,
        player_name,
        team_name,
        season,
        round(avg_per,2) as avg_per,
        round(avg_pts,2) as avg_pts,
        round(avg_ast,2) as avg_ast,
        round(avg_reb,2) as avg_reb,
        round(avg_min,2) as avg_min,
        ROW_NUMBER() OVER (PARTITION BY season ORDER BY avg_per DESC) AS rank
    FROM 
        player_per_season
)
SELECT 
    player_id,
    player_name,
    team_name,
    season,
    avg_per,
    avg_pts,
    avg_ast,
    avg_reb,
    avg_min
FROM 
    ranked_players
WHERE 
    rank <= 5
ORDER BY 
    season, rank
