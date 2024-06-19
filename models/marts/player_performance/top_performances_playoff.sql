-- TOP PLAYOFF PERFORMANCES (BY PER & >23 MIN PLAYED)

WITH player_per_game AS (
    SELECT 
        gd.player_id,
        p.player_name,
        t.team_name,
        g.game_date,
        g.season,
        gd.player_efficiency_rating AS per,
        gd.pts,
        gd.ast,
        gd.reb,
        gd.min,
        gd.plus_minus
    FROM 
        {{ ref('fct_games_details') }} gd
    JOIN 
        {{ ref('dim_players') }} p
        ON gd.player_id = p.player_id
    JOIN 
        {{ ref('dim_teams') }} t
        ON gd.team_id = t.team_id
    JOIN
        {{ ref('fct_games') }} g
        ON gd.game_id = g.game_id
    WHERE 
        g.season BETWEEN 2009 AND 2019
        AND g.game_type = 'Playoff'
        AND per is not null
        AND min > 23
)
,
ranked_games AS (
    SELECT
        player_id,
        player_name,
        team_name,
        game_date,
        season,
        round(per,2) as per,
        pts,
        ast,
        reb,
        min,
        plus_minus,
        ROW_NUMBER() OVER (ORDER BY per DESC) AS rank
    FROM 
        player_per_game
)
SELECT 
    --player_id,
    player_name,
    team_name,
    game_date,
    season,
    per,
    pts,
    ast,
    reb,
    min,
    plus_minus
FROM 
    ranked_games
WHERE 
    rank <= 10
ORDER BY 
    per desc,season, rank