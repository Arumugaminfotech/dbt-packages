{{ config(materialized='table') }}

with devices as (
    select *  from {{source('ua','source_devices')}}
),
ua_devices as (select
  ga_date.member0 as date,
  view_id,
  brand,
  ga_operatingsystem as operatingsystem,
  ga_devicecategory as devicecategory,
  ga_browser as browser,
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
  ROW_NUMBER() over(partition by ga_date.member0,view_id,ga_operatingsystem,ga_devicecategory,ga_browser order by _airbyte_emitted_at desc) as row_number
from devices
)
select date,view_id,brand,operatingsystem,devicecategory,browser,users,pageviews,bouncerate,avgtimeonpage,newusers,avgsessionduration,pageviewspersession,exitrate,sessions,sessionsperuser from ua_devices where row_number = 1