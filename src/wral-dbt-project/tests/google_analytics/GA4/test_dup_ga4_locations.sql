  SELECT date,property_id,country,city,region, COUNT(*) AS count
  FROM ga4_locations
  GROUP BY date,property_id,country,city,region
  HAVING COUNT(*) > 1

