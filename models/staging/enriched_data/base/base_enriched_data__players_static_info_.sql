{{
  config(
    materialized='view'
  )
}}

WITH src_players_info AS (
    SELECT * 
    FROM {{ source('other_sources', 'players_static_info') }}
    ),

renamed_casted AS (
    SELECT
          person_id,
          --first_name,
          --last_name,
          display_first_last AS player_name,
          --display_fi_last,
          birthdate,
          school,
          country,
          last_affiliation,
          height,
          weight,
          season_exp,
          jersey,
          --position,
          --rosterstatus,
          --games_played_current_season_flag,
          --team_id,
          --team_name,
          --team_abbreviation,
          --team_code,
          --team_city,
          --playercode,
          from_year,
          to_year,
          --games_played_flag,
          draft_year,
          draft_round,
          draft_number,
          greatest_75_flag,
          ROW_NUMBER() OVER (PARTITION BY player_name ORDER BY season_exp desc) AS row_num
 
        
    FROM src_players_info
    )

SELECT * FROM renamed_casted
-- we will only work with seasons BETWEEN 2009 AND 2019 since we don't have data for teams nor players out of that period
where to_year >= 2009
-- me estoy quedando en caso de nombres repetidos con el que mas temporadas haya jugado
and row_num = 1