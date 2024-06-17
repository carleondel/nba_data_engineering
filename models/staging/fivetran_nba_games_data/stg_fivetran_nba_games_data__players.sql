with 

source as (

    select * from {{ source('_fivetran_nba_games_data', 'players') }}

),

renamed as (

    select
        _fivetran_id,
        team_id,
        season,
        player_name,
        player_id,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed
