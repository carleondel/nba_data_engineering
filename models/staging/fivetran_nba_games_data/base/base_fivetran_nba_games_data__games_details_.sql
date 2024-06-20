with 

src_games_details as (

    select * from {{ source('_fivetran_nba_games_data', 'games_details') }}

),

renamed as (

    select
         -- Generating surrogate key
        {{ dbt_utils.generate_surrogate_key(['PLAYER_ID', 'GAME_ID']) }} AS id,
        team_id,
        ftm,
        fgm,
        -- Convert 'min' from MM:SS to decimal minutes
        ROUND(TRY_TO_NUMBER(SPLIT_PART(min, ':', 1)) + TRY_TO_NUMBER(SPLIT_PART(min, ':', 2)) / 60.0, 2) AS min,
        fg_pct,
        blk,
        -- Generating surrogate key. Al crearla a partir del player_name, luego podremos hacer
        -- joins con los datos de otras fuentes. Si no, tendríamos player_id distintos
        {{ dbt_utils.generate_surrogate_key(['player_name']) }} AS player_id,
        --player_id,
        start_position,
        dreb,
        ast,
        pts,
        reb,
        --nickname,
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
        --team_city,
        fg3m,
        game_id,
        plus_minus,
        fg3_pct,
        ft_pct,
        _fivetran_deleted,
        _fivetran_synced,

        ROW_NUMBER() OVER (PARTITION BY id ORDER BY id) AS row_num

    from src_games_details

)

select * 
from renamed
where row_num = 1   -- Nos quedamos solo con la primera fila de cada surrogate_key
-- (había 7 duplicados de player_id que eran errores de inserción en la BBDD)
-- tambien nos quitamos con esto los duplicados de game_id