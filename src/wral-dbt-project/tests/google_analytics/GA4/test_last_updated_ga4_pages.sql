with pages as (select brand,max(date) as updated_date from ga4_pages group by brand),
final_ta as (select case when  updated_date >= CURRENT_DATE - INTERVAL '24' HOUR then NULL else brand ||' is not updated' END as e_logs from pages where brand != 'wral_dotcom')
select * from final_ta where e_logs  is not null