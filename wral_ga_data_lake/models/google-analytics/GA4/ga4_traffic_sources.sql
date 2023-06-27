{{ config(materialized='table') }}

with traffic_sources as (
    select *  from {{source('ga4','ga4_source_traffic_sources')}}
),
ga4_traffic_sources as (select
  date,
  newusers,
  sessions,
  sessionsperuser,
  totalusers,
  averagesessionduration,
  screenpageviewspersession,
  uuid,
  bouncerate,
  property_id,
  sessionsource,
  screenpageviews,
  sessionmedium,
  brand,
  ROW_NUMBER() over(partition by uuid order by _airbyte_emitted_at desc ) as row_number
from traffic_sources
)
select date, newusers, sessions, sessionsperuser, totalusers, averagesessionduration, screenpageviewspersession, uuid, bouncerate, property_id, sessionsource, screenpageviews, sessionmedium, brand from ga4_traffic_sources where row_number = 1