with 

stg_games_details as (

    select * from {{ ref('stg_fivetran_nba_games_data__games_details') }}

),

filtered as (

    select
        id,
        player_id,        
        game_id,
        team_id,
        min,
        pts,
        reb,
        ast,
        stl,
        blk,
        fgm,
        fga,
        fg_pct,
        fg3m,
        fg3a,
        fg3_pct,
        ftm,
        fta,
        ft_pct,
        oreb,
        dreb,
        tos,
        pf,
        plus_minus,
        start_position,
        --nickname,
        comment,
        --player_name,
        --team_abbreviation,        
        --team_city,       
        --_fivetran_deleted,
        --_fivetran_synced
        player_efficiency_rating
        
    from stg_games_details

)

select * 
from filtered