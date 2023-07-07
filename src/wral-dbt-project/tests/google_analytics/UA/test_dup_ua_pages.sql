  SELECT date,view_id,hostname,pagepath, COUNT(*) AS count
  FROM {{ref('ua_pages')}}
  GROUP BY date,view_id,hostname,pagepath 
  HAVING COUNT(*) > 1
