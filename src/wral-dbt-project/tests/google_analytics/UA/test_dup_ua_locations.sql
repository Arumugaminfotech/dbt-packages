  SELECT date,view_id,city,metro,country,subcontinent,continent,region, COUNT(*) AS count
  FROM ua_locations
  GROUP BY date,view_id,city,metro,country,subcontinent,continent,region
  HAVING COUNT(*) > 1
