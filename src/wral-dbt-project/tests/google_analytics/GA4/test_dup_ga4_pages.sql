  SELECT date,property_id,hostname,pagepathplusquerystring, COUNT(*) AS count
  FROM ga4_pages
  GROUP BY date,property_id,hostname,pagepathplusquerystring 
  HAVING COUNT(*) > 1

