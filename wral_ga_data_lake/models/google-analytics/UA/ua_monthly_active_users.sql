{{ config(materialized='table') }}

with monthly_active_users as (
    select *  from {{source('ua','source_monthly_active_users')}}
),
ua_monthly_active_users as (select
  ga_date.member0 as date,
  view_id,
  brand,
  ga_30dayusers as thirty_day_users,
  ROW_NUMBER() over(partition by ga_date.member0,view_id order by _airbyte_emitted_at desc ) as row_number
from monthly_active_users
)
select date,view_id,brand,thirty_day_users from ua_monthly_active_users where row_number = 1