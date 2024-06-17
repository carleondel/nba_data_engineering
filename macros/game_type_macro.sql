-- CREAR COLUMNA SEGUN FECHA PARA DISTINGUIR PRESEASON, REGULAR SEASON Y PO
{% macro categorize_game_type(game_date_column) %}
    CASE
        {% for season in [
            {'preseason_start': '2009-09-27', 'regular_start': '2009-10-27', 'regular_end': '2010-04-14', 'playoff_end': '2010-06-17'},
            {'preseason_start': '2010-09-26', 'regular_start': '2010-10-26', 'regular_end': '2011-04-13', 'playoff_end': '2011-06-12'},
            {'preseason_start': '2011-11-25', 'regular_start': '2011-12-25', 'regular_end': '2012-04-26', 'playoff_end': '2012-06-21'},
            {'preseason_start': '2012-09-30', 'regular_start': '2012-10-30', 'regular_end': '2013-04-17', 'playoff_end': '2013-06-20'},
            {'preseason_start': '2013-09-29', 'regular_start': '2013-10-29', 'regular_end': '2014-04-16', 'playoff_end': '2014-06-15'},
            {'preseason_start': '2014-09-28', 'regular_start': '2014-10-28', 'regular_end': '2015-04-15', 'playoff_end': '2015-06-16'},
            {'preseason_start': '2015-09-27', 'regular_start': '2015-10-27', 'regular_end': '2016-04-13', 'playoff_end': '2016-06-19'},
            {'preseason_start': '2016-09-25', 'regular_start': '2016-10-25', 'regular_end': '2017-04-12', 'playoff_end': '2017-06-12'},
            {'preseason_start': '2017-09-17', 'regular_start': '2017-10-17', 'regular_end': '2018-04-11', 'playoff_end': '2018-06-08'},
            {'preseason_start': '2018-09-16', 'regular_start': '2018-10-16', 'regular_end': '2019-04-10', 'playoff_end': '2019-06-13'},
            {'preseason_start': '2019-09-22', 'regular_start': '2019-10-22', 'regular_end': '2020-03-11', 'playoff_end': '2020-10-11'}
        ] %}
            WHEN {{ game_date_column }} BETWEEN '{{ season.preseason_start }}' AND '{{ season.regular_start }}' THEN 'Preseason'
            WHEN {{ game_date_column }} BETWEEN '{{ season.regular_start }}' AND '{{ season.regular_end }}' THEN 'Regular Season'
            WHEN {{ game_date_column }} BETWEEN '{{ season.regular_end }}' AND '{{ season.playoff_end }}' THEN 'Playoff'
            WHEN {{ game_date_column }} = '2020-08-15' THEN 'Play-in'
        {% endfor %}
        ELSE 'Unknown'
    END
{% endmacro %}


-- se jugó el primer play-in el 15 agosto 2020 '2020-8-15'
-- formato distinto: 8 vs 9. 
-- Si gana el 8 pasa a PO. Si gana el 9 se jugaba segundo partido