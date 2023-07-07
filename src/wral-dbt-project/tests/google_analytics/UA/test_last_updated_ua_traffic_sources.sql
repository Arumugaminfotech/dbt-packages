with traffic_sources as (select brand,max(date) as updated_date from ua_traffic_sources group by brand),
final_ta as (select case when updated_date = current_date then NULL else brand ||' is not updated' END as e_logs from traffic_sources)
select * from final_ta where e_logs  is not null