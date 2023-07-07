  SELECT date, property_id, COUNT(*) AS count
  FROM ga4_daily_active_users
  GROUP BY date,property_id 
  HAVING COUNT(*) > 1

