-- Aquí estamos usando los dos modelos de base para filtrar games_details
-- y solo quedarnos con datos de season <= 2019
WITH base_games AS (
    SELECT
        game_id
    FROM {{ ref('base_fivetran_nba_games_data__games_') }}
    -- Ya los he filtrado en base__games
    --WHERE season <= 2019 
),

filtered_games_details AS (
    SELECT
        gd.*
    FROM {{ ref('base_fivetran_nba_games_data__games_details_') }} gd
    INNER JOIN base_games bg
    ON gd.game_id = bg.game_id
)

SELECT * FROM filtered_games_details