  SELECT date, property_id, COUNT(*) AS count
  FROM ga4_website_overview
  GROUP BY date,property_id 
  HAVING COUNT(*) > 1

