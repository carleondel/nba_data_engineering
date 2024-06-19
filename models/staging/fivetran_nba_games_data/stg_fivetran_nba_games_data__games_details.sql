-- Aquí estamos usando los dos modelos de base para filtrar games_details
-- y solo quedarnos con datos de season ENTRE 2009 Y 2019
-- TAMBIEN AÑADIMOS LA FECHA DESDE GAMES
WITH base_games AS (
    SELECT
        game_id,
        GAME_DATE
    FROM {{ ref('base_fivetran_nba_games_data__games_') }}
    -- Ya los he filtrado en base__games, 
    --ASI QUE AL HACER EL INNER JOIN ES COMO SI FILTRAMOS POR SEASONS 2009-2019
    --WHERE season BETWEEN 2009 AND 2019 
),

filtered_games_details AS (
    SELECT
        gd.*,
        bg.GAME_DATE,
        {{ categorize_game_type('GAME_DATE') }} AS game_type
    FROM {{ ref('base_fivetran_nba_games_data__games_details_') }} gd
    INNER JOIN base_games bg
    ON gd.game_id = bg.game_id
)

SELECT * FROM filtered_games_details