{{ config(materialized='table') }}

with pages as (
    select *  from {{source('ua','source_pages')}}
),
ua_pages as (select
  ga_date.member0 as date,
  view_id,
  brand,
  ga_uniquepageviews as uniquepageviews,
  ga_hostname as hostname,
  ga_bouncerate as bouncerate,
  ga_avgtimeonpage as avgtimeonpage,
  ga_exits as exits,
  ga_pageviews as pageviews,
  ga_entrancerate as entrancerate,
  ga_pagepath as pagepath,
  ga_entrances as entrances,
  ga_exitrate as exitrate,
  ROW_NUMBER() over(partition by ga_date.member0,view_id,ga_hostname,ga_pagepath order by _airbyte_emitted_at desc ) as row_number
from pages
)

select date,view_id,brand,uniquepageviews,hostname,bouncerate,avgtimeonpage,exits,pageviews,entrancerate,pagepath,entrances,exitrate from ua_pages where row_number = 1
