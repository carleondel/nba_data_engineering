{% macro calculate_per(fgm, steals, three_ptm, ftm, blocks, offensive_reb, assists, defensive_reb, fouls, fga, fta, turnovers, minutes_played) %}
   
   CASE
        WHEN {{ minutes_played }} > 10 THEN (

            (
                ({{ fgm }} * 85.910) +
                ({{ steals }} * 53.897) +
                ({{ three_ptm }} * 51.757) +
                ({{ ftm }} * 46.845) +
                ({{ blocks }} * 39.190) +
                ({{ offensive_reb }} * 39.190) +
                ({{ assists }} * 34.677) +
                ({{ defensive_reb }} * 14.707) -
                ({{ fouls }} * 17.174) -
                (({{ fta }} - {{ ftm }}) * 20.091) -
                (({{ fga }} - {{ fgm }}) * 39.190) -
                ({{ turnovers }} * 53.897)
            ) * (1 / ({{ minutes_played }}))

        )
        ELSE NULL
    END

    
{% endmacro %}



-- Esto es una version simplificada del PER

/*https://bleacherreport.com/articles/113144-cracking-the-code-how-to-calculate-hollingers-per-without-all-the-mess*/