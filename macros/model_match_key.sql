{% macro model_match_key(column_name) %}
    regexp_replace(lower({{ column_name }}), '[^a-z0-9]', '')
{% endmacro %}