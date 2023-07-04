{{ config(materialized='table') }}

with website_overivew as (
    select *  from {{source('ga4','ga4_source_website_overview')}} 
),
ga4_website_overivew as (select
  date,
  newusers,
  sessions,
  sessionsperuser,
  totalusers,
  averagesessionduration,
  screenpageviews,
  screenpageviewspersession,
  uuid,
  bouncerate,
  property_id,
  brand,
  ROW_NUMBER() over(partition by date,property_id order by _airbyte_emitted_at desc ) as row_number
from website_overivew
)
select date(date_parse(date,'%Y%m%d')) as date, newusers, sessions, sessionsperuser, totalusers, averagesessionduration, screenpageviews, screenpageviewspersession, uuid, bouncerate, property_id, brand from ga4_website_overivew where row_number = 1

