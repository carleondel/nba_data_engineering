WITH stg_games AS (
    SELECT
        *
    FROM {{ ref('stg_fivetran_nba_games_data__games') }} 
)


SELECT * FROM stg_games