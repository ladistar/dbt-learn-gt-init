{% macro grant_select(schema=target.schema, role=target.role, database=target.database) %}
    {% set sql %}
        USE DATABASE {{ database }};
        GRANT USAGE ON SCHEMA {{ schema }} TO ROLE {{ role }};
        GRANT SELECT ON ALL TABLES IN SCHEMA {{ schema }} TO ROLE {{ role }};
        GRANT SELECT ON ALL VIEWS IN SCHEMA {{ schema }} TO ROLE {{ role }};
    {% endset %}

    {{ log('Granting select on schema ' ~ schema ~ ' to role ' ~ role, info=true) }}
    {% do run_query(sql) %}
    {{ log('Finished granting select on schema ' ~ schema ~ ' to role ' ~ role, info=true) }}
{% endmacro %}