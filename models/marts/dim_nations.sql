{{config(materialized = 'incremental')}}

with nation as(
select
       nation_id,
       region_id,
       name,
       comment,
       updated_ts
from {{ ref('stg_nations')}}
{%if is_incremental()%}
where updated_ts > (select max(updated_ts) from {{this}})
{% endif %}
)
select * from nation
