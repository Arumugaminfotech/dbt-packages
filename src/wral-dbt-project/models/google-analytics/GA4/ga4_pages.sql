{{ config(materialized='table') }}

with pages as (
    select *  from {{source('ga4','ga4_source_pages')}}
),
ga4_pages as (select
  date,
  hostname,
  screenpageviews,
  pagepathplusquerystring,
  uuid,
  bouncerate,
  property_id,
  brand,
  ROW_NUMBER() over(partition by date,property_id,hostname,pagepathplusquerystring order by _airbyte_emitted_at desc ) as row_number
from pages
)

select date(date_parse(date,'%Y%m%d')) as date, hostname, screenpageviews, pagepathplusquerystring, uuid, bouncerate, property_id, brand from ga4_pages where row_number = 1
