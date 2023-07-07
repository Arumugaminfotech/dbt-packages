with weekly_active_users as (select brand,max(date) as updated_date from ga4_weekly_active_users group by brand),
final_ta as (select case when updated_date = current_date then NULL else brand ||' is not updated' END as e_logs from weekly_active_users)
select * from final_ta where e_logs  is not null