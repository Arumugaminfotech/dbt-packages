{{ config(materialized='table') }}

with locations as (
    select *  from {{source('ua','ua_source_locations')}}
),
ua_locations as (select
  ga_date.member0 as date,
  view_id,
  brand,
  ga_city as city,
  ga_metro as metro,
  ga_country as country,
  ga_subcontinent as subcontinent,
  ga_continent as continent,
  ga_region as region,
  ga_users as users,
  ga_pageviews as pageviews,
  ga_bouncerate as bouncerate,
  ga_avgtimeonpage as avgtimeonpage,
  ga_newusers as newusers,
  ga_avgsessionduration as avgsessionduration,
  ga_pageviewspersession as pageviewspersession,
  ga_exitrate as exitrate,
  ga_sessions as sessions,
  ga_sessionsperuser as sessionsperuser,
  ROW_NUMBER() over(partition by ga_date.member0,view_id,ga_city,ga_metro,ga_country,ga_subcontinent,ga_continent,ga_region order by _airbyte_emitted_at desc ) as row_number
from locations
)
select date,view_id,brand,city,metro,country,subcontinent,continent,region,users,pageviews,bouncerate,avgtimeonpage,newusers,avgsessionduration,pageviewspersession,exitrate,sessions,sessionsperuser from ua_locations where row_number = 1