WITH int_players_static_info AS (
    SELECT * 
    FROM {{ ref('int_players_static_info__filtered') }}
    ),

transformations AS (
    SELECT
        *
    FROM int_players_static_info
    )

SELECT * FROM transformations