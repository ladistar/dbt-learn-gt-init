{{config(
    materialized = 'incremental',
    cluster_by = ['start_time']
)
}}

WITH base AS (

	SELECT *
	FROM {{ source('snowflake','warehouse_metering_history') }}

)

SELECT
  warehouse_id,
  warehouse_name,
  start_time,
  end_time,
  credits_used
FROM base

{% if is_incremental() %}
    WHERE start_time > (SELECT MAX(start_time) FROM {{ this }})
{% endif %}
