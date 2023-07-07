  SELECT date,property_id,sessionsource,sessionmedium, COUNT(*) AS count
  FROM {{ref('ga4_traffic_sources')}}
  GROUP BY date,property_id,sessionsource,sessionmedium 
  HAVING COUNT(*) > 1

