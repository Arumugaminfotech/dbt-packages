  SELECT date,view_id, COUNT(*) AS count
  FROM {{ref('ua_weekly_active_users')}}
  GROUP BY date,view_id 
  HAVING COUNT(*) > 1
