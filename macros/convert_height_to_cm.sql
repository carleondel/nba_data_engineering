{% macro convert_height_to_cm(height) %}
    (
        CAST(SPLIT_PART({{ height }}, '-', 1) AS INTEGER) * 30.48 +  -- Convertir pies a cm (1 pie = 30.48 cm)
        CAST(SPLIT_PART({{ height }}, '-', 2) AS INTEGER) * 2.54     -- Convertir pulgadas a cm (1 pulgada = 2.54 cm)
    )
{% endmacro %}
