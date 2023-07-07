with website_overview as (select brand,max(date) as updated_date from ga4_website_overview group by brand),
final_ta as (select case when updated_date = current_date then NULL else brand ||' is not updated' END as e_logs from website_overview)
select * from final_ta where e_logs  is not null