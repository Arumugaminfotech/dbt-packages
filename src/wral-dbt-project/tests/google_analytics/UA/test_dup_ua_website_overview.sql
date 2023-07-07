  SELECT date,view_id, COUNT(*) AS count
  FROM {{ref('ua_website_overview')}}
  GROUP BY date,view_id 
  HAVING COUNT(*) > 1
