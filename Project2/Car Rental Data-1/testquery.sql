/*
# Question 5: Return all Compact(1) & Luxury(1) vehicles that were available for rent from June 01, 2019 until June 20, 2019. 
List VechicleID as VIN, Description, year, and how many days have been rented so far. 
You need to change the weeks into days.
*/
SELECT V.VehicleID as VIN, V.Description, V.Year, SUM(R.Qty * R.RentalType) AS TotalDaysRented
FROM (SELECT * 
	 FROM VEHICLE
	 WHERE Type = 1 AND Category = 1) AS V 
LEFT JOIN RENTAL AS R
ON V.VehicleID = R.VehicleID 
#WHERE (R.StartDate < '2019-06-01'AND R.StartDate > '2019-06-20') OR (R.ReturnDate > '2019-06-20' AND R.Startdate < '2019-06-01')
GROUP BY  V.VehicleID;




 
 

 
 
 