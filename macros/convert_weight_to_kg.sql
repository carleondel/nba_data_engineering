{% macro convert_weight_to_kg(weight) %}
    (
        CAST({{ weight }} * 0.453592 AS NUMBER(38,2))  -- Convertir libras a kilogramos (1 libra = 0.453592 kg)
    )
{% endmacro %}
