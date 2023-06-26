{{ config(materialized='table') }}

with daily_active_users as (
    select *  from {{source('ua','source_daily_active_users')}}
),
ua_daily_active_users as (select
  ga_date.member0 as date,
  view_id,
  brand,
  ga_1dayusers as one_day_users,
  ROW_NUMBER() over(partition by ga_date.member0,view_id order by _airbyte_emitted_at desc ) as row_number
from daily_active_users
)
select date,view_id,brand,one_day_users from ua_daily_active_users where row_number = 1