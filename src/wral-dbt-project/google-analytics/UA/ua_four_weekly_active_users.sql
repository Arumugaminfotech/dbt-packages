{{ config(materialized='table') }}

with four_weekly_active_users as (
    select *  from {{source('ua','source_four_weekly_active_users')}}
),
ua_four_weekly_active_users as (select
  ga_date.member0 as date,
  view_id,
  brand,
  ga_28dayusers as twenty_eight_day_users,
  ROW_NUMBER() over(partition by ga_date.member0,view_id order by _airbyte_emitted_at desc ) as row_number
from four_weekly_active_users
)
select date,view_id,brand,twenty_eight_day_users from ua_four_weekly_active_users where row_number = 1