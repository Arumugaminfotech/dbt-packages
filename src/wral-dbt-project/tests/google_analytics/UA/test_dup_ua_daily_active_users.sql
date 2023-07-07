  SELECT date,view_id, COUNT(*) AS count
  FROM {{ref('ua_daily_active_users')}}
  GROUP BY date,view_id 
  HAVING COUNT(*) > 1
