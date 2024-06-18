with 

source as (

    select * from {{ source('_fivetran_nba_games_data', 'players') }}

),

transformed as (

    select
         -- Generating surrogate key
        {{ dbt_utils.generate_surrogate_key(['player_id', 'team_ID', 'season']) }} AS player_team_season_id,
        --_fivetran_id,
        team_id,
        season,
        player_name,
        player_id,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from transformed
