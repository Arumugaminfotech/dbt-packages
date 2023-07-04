{{ config(materialized='table') }}

with weekly_active_users as (
    select *  from {{source('ua','ua_source_weekly_active_users')}}
),
ua_weekly_active_users as (select
  ga_date.member0 as date,
  view_id,
  brand,
  ga_7dayusers as seven_day_users,
  ROW_NUMBER() over(partition by ga_date.member0,view_id order by _airbyte_emitted_at desc ) as row_number
from weekly_active_users
)
select date,view_id,brand,seven_day_users from ua_weekly_active_users where row_number = 1