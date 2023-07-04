{{ config(materialized='table') }}

with daily_active_users as (
    select *  from {{source('ga4','ga4_source_daily_active_users')}}
),
ga4_daily_active_users as (select
  date,
  active1dayusers,
  uuid,
  property_id,
  brand,
  ROW_NUMBER() over(partition by date,property_id order by _airbyte_emitted_at desc ) as row_number
from daily_active_users
)
select date(date_parse(date,'%Y%m%d')) as date, active1dayusers, uuid, property_id, brand from ga4_daily_active_users where row_number = 1