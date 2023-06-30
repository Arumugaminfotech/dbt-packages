{{ config(materialized='table') }}

with weekly_active_users as (
    select *  from {{source('ga4','ga4_source_weekly_active_users')}}
),
ga4_weekly_active_users as (select
  date,
  active7dayusers,
  uuid,
  property_id,
  brand,
  ROW_NUMBER() over(partition by uuid order by _airbyte_emitted_at desc ) as row_number
from weekly_active_users
)
select date(date_parse(date,'%Y%m%d')) as date, active7dayusers, uuid, property_id, brand from ga4_weekly_active_users where row_number = 1