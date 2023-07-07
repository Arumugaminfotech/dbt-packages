  SELECT date,view_id,operatingsystem,devicecategory,browser, COUNT(*) AS count
  FROM ua_devices
  GROUP BY date,view_id,operatingsystem,devicecategory,browser 
  HAVING COUNT(*) > 1
