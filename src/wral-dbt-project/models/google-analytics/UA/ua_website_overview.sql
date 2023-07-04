{{ config(materialized='table') }}

with website_overivew as (
    select *  from {{source('ua','ua_source_website_overview')}} 
),
ua_website_overivew as (select
  ga_date.member0 as date,
  view_id,
  brand,
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
  ROW_NUMBER() over(partition by ga_date.member0,view_id order by _airbyte_emitted_at desc ) as row_number
from website_overivew
)
select date,view_id,brand,users,pageviews,bouncerate,avgtimeonpage,newusers,avgsessionduration,pageviewspersession,exitrate,sessions,sessionsperuser from ua_website_overivew where row_number = 1