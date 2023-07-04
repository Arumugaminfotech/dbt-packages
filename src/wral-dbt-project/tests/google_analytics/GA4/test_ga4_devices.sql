  SELECT date,property_id,operatingsystem,devicecategory,browser, COUNT(*) AS count
  FROM {{ref('ga4_devices')}}
  GROUP BY date,property_id,operatingsystem,devicecategory,browser 
  HAVING COUNT(*) > 1

