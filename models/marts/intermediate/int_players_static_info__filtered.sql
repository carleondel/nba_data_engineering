--- CON EL INNER JOIN ME ESTOY QUEDANDO SOLO CON LOS PLAYER_ID DE MI FUENTE ORIGINAL NBA_GAMES_DATA
--- PARA CONSTRUIR LA DIM_PLAYERS (INFO ESTATICA)

WITH stg_fivetran_nba_games_players AS (
    SELECT DISTINCT player_id
    FROM {{ ref('stg_fivetran_nba_games_data__players') }}
)

SELECT
    e.*
FROM
    {{ ref('stg_enriched_data__players_static_info') }} e
JOIN
    stg_fivetran_nba_games_players f
ON
    e.player_id = f.player_id
