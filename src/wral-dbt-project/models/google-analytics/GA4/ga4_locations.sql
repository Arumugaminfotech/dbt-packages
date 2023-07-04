{{ config(materialized='table') }}

with locations as (
    select *  from {{source('ga4','ga4_source_locations')}}
),
ga4_locations as (select
  date,
  country,
  newusers,
  sessions,
  sessionsperuser,
  totalusers,
  city,
  averagesessionduration,
  screenpageviewspersession,
  uuid,
  bouncerate,
  property_id,
  screenpageviews,
  region,
  brand,
  ROW_NUMBER() over(partition by date,property_id,country,city,region order by _airbyte_emitted_at desc ) as row_number
from locations
)
select date(date_parse(date,'%Y%m%d')) as date, country, newusers, sessions, sessionsperuser, totalusers, city, averagesessionduration, screenpageviewspersession, uuid, bouncerate, property_id, screenpageviews, region, brand from ga4_locations where row_number = 1