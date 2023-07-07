  SELECT date,view_id, COUNT(*) AS count
  FROM ua_daily_active_users
  GROUP BY date,view_id 
  HAVING COUNT(*) > 1
