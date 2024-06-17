with 

src_games_details as (

    select * from {{ source('_fivetran_nba_games_data', 'games_details') }}

),

renamed as (

    select
         -- Generating surrogate key
        {{ dbt_utils.generate_surrogate_key(['TEAM_ID', 'PLAYER_ID', 'GAME_ID']) }} AS surrogate_key,
        team_id,
        ftm,
        fgm,
        -- Convert 'min' from MM:SS to decimal minutes
        ROUND(TRY_TO_NUMBER(SPLIT_PART(min, ':', 1)) + TRY_TO_NUMBER(SPLIT_PART(min, ':', 2)) / 60.0, 2) AS min,
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
        _fivetran_synced,

        ROW_NUMBER() OVER (PARTITION BY surrogate_key ORDER BY surrogate_key) AS row_num

    from src_games_details

)

select * 
from renamed
where row_num = 1   -- Nos quedamos solo con la primera fila de cada surrogate_key
-- (había 7 duplicados que eran errores de inserción en la BBDD)