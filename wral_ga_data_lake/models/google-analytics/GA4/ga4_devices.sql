{{ config(materialized='table') }}

with devices as (
    select *  from {{source('ga4','ga4_source_devices')}}
),
ga4_devices as (select
  date,
  newusers,
  sessions,
  sessionsperuser,
  totalusers,
  averagesessionduration,
  screenpageviewspersession,
  uuid,
  operatingsystem,
  bouncerate,
  property_id,
  devicecategory,
  browser,
  screenpageviews,
  brand,
  ROW_NUMBER() over(partition by uuid order by _airbyte_emitted_at desc) as row_number
from devices
)
select date, newusers, sessions, sessionsperuser, totalusers, averagesessionduration, screenpageviewspersession, uuid, operatingsystem, bouncerate, property_id, devicecategory, browser, screenpageviews, brand from ga4_devices where row_number = 1