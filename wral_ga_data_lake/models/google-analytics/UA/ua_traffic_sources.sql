{{ config(materialized='table') }}

with traffic_sources as (
    select *  from {{source('ua','source_traffic_sources')}}
),
ua_traffic_sources as (select
  ga_date.member0 as date,
  view_id,
  brand,
  ga_socialnetwork as socialnetwork,
  ga_medium as medium,
  ga_source as source,
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
  ROW_NUMBER() over(partition by ga_date.member0,view_id,ga_socialnetwork,ga_medium,ga_source order by _airbyte_emitted_at desc ) as row_number
from traffic_sources
)
select date,view_id,brand,socialnetwork,medium,source,users,pageviews,bouncerate,avgtimeonpage,newusers,avgsessionduration,pageviewspersession,exitrate,sessions,sessionsperuser from ua_traffic_sources where row_number = 1