with 

source as (

    select * from {{ source('_fivetran_nba_games_data', 'players') }}

),

deduplicated AS (
    SELECT DISTINCT
        {{ dbt_utils.generate_surrogate_key(['player_name']) }} AS player_id,
        TEAM_ID,
        SEASON,
        PLAYER_NAME,
        _FIVETRAN_DELETED,
        _FIVETRAN_SYNCED
    FROM source
),

transformed AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['player_id', 'TEAM_ID', 'SEASON']) }} AS player_team_season_id,
        TEAM_ID,
        SEASON,
        PLAYER_NAME,
        player_id,
        --_FIVETRAN_DELETED,
        --_FIVETRAN_SYNCED
    FROM deduplicated
)

SELECT * 
FROM transformed