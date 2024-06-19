with 

source as (

    select * from {{ source('_fivetran_nba_games_data', 'teams') }}

),

renamed as (

    select
        --_fivetran_id,
        --max_year,
        generalmanager,
        owner,
        city,
        arenacapacity,
        yearfounded,
        arena,
        team_id,
        --league_id,
        --min_year,
        headcoach,
        nickname,
        dleagueaffiliation,
        abbreviation,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed
