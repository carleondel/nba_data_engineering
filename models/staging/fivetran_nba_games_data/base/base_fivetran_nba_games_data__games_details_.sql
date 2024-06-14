with 

src_games_details as (

    select * from {{ source('_fivetran_nba_games_data', 'games_details') }}

),

renamed as (

    select
        _fivetran_id,
        team_id,
        ftm,
        fgm,
        min,
        fg_pct,
        blk,
        player_id,
        start_position,
        dreb,
        ast,
        pts,
        reb,
        nickname,
        oreb,
        pf,
        stl,
        fg3a,
        fta,
        comment,
        player_name,
        tos,
        team_abbreviation,
        fga,
        team_city,
        fg3m,
        game_id,
        plus_minus,
        fg3_pct,
        ft_pct,
        _fivetran_deleted,
        _fivetran_synced

    from src_games_details

)

select * from renamed