WITH base_players_static AS (
    SELECT * 
    FROM {{ ref('base_enriched_data__players_static_info_') }}
    ),

transformations AS (
    SELECT
          player_id,
          player_name,
          birthdate,
          school,
          country,
          last_affiliation,
          {{ convert_height_to_cm('height') }} AS height_cm,
          {{ convert_weight_to_kg('weight') }} AS weight_kg,
          season_exp,
          jersey,
          CAST(from_year AS INTEGER) AS from_year,
          CAST(to_year AS INTEGER) AS to_year,
          draft_year,
          draft_round,
          draft_number,
          greatest_75_flag
    FROM base_players_static
    )

SELECT * FROM transformations