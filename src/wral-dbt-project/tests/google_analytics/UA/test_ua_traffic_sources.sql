  SELECT date,view_id,socialnetwork,medium,source, COUNT(*) AS count
  FROM {{ref('ua_traffic_sources')}}
  GROUP BY date,view_id,socialnetwork,medium,source
  HAVING COUNT(*) > 1
