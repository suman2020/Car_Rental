CREATE SCHEMA CAR_RENTAL;
CREATE TABLE CAR_RENTAL.CUSTOMER
(
  CustID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  Name VARCHAR(50),
  Phone CHAR(15)
);

CREATE TABLE CAR_RENTAL.RATE
(
  Type INT NOT NULL ,
  Category INT NOT NULL,
  Weekly INT NOT NULL,
  Daily INT NOT NULL,
  CONSTRAINT VehicleType PRIMARY KEY(Type, Category)
);

CREATE TABLE CAR_RENTAL.VEHICLE
(
  VehicleID VARCHAR(20) NOT NULL PRIMARY KEY,
  Description VARCHAR(35) NOT NULL,
  Year INT NOT NULL,
  Type INT NOT NULL,
  Category INT NOT NULL,
  FOREIGN KEY(Type, Category) REFERENCES RATE (Type, Category)
    ON DELETE NO ACTION
    ON UPDATE CASCADE
);

CREATE TABLE CAR_RENTAL.RENTAL
(
  CustID INT NOT NULL,
  VehicleID VARCHAR(20) NOT NULL,
  StartDate VARCHAR(20),
  OrderDate VARCHAR(20),
  RentalType INT,
  Qty INT,
  ReturnDate VARCHAR(20),
  TotalAmount INT,
  PaymentDate VARCHAR(20),
  FOREIGN KEY(CustID) REFERENCES CUSTOMER(CustID)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  FOREIGN KEY(VehicleID) REFERENCES VEHICLE(VehicleID)
    ON DELETE NO ACTION
    ON UPDATE CASCADE
  PRIMARY KEY(CustID, VehicleID)
);
/*
SELECT COUNT(*) AS TOTAL_CUSTOMERTABLE_RECORDS
FROM CUSTOMER;

SELECT COUNT(*) AS TOTAL_RATETABLE_RECORDS
FROM RATE;

SELECT COUNT(*) AS TOTAL_VEHICLETABLE_RECORDS
FROM VEHICLE;

SELECT COUNT(*) AS TOTAL_RENTALTABLE_RECORDS
FROM RENTAL;
 */
 SET FOREIGN_KEY_CHECKS = 0;
 ALTER TABLE CUSTOMER MODIFY CustID INT NOT NULL AUTO_INCREMENT;
 SET FOREIGN_KEY_CHECKS = 1;

 #TASK 3:
# Question 1: Insert yourself as a New Customer.Do not provide the customerID in your query.

INSERT INTO CUSTOMER(Name, Phone)
VALUES ('Suman Thapa Magar', '(682)123-4567');
INSERT INTO CUSTOMER (Name,Phone)
VALUES('Yunika Upadhayaya', '(123)213-2323');
INSERT INTO CUSTOMER (Name,Phone)
VALUES('Pratik Mahato', '(144)213-2020');

# Question 2: Update your phone number to (837)721-8965
UPDATE CUSTOMER
SET
	Phone = '(837)721-8965'
WHERE
	CustID = 232;

#Question 3: Increase only daily rates for luxury vehicles by 5%
SET SQL_SAFE_UPDATES = 0;
UPDATE RATE
SET Daily = Daily * 1.05
WHERE Category = '1';
SET SQL_SAFE_UPDATES = 1;


#Question 4 a: Insert a new luxury van with the following info: Honda Odyssey 2019, vehicle id:5FNRL6H58KB133711
INSERT INTO VEHICLE(VehicleID, Description, Year, Type ,Category)
VALUES ('5FNRL6H58KB133711', 'Honda Odyssey','2019', '6','1');

#Question 4 b: Insert the following rates
UPDATE RATE
SET Weekly = 900 , Daily = 150
WHERE Type = '5' AND Category = '1';

UPDATE RATE
SET Weekly = 800 , Daily = 135
WHERE Type = '6' AND Category = '1';

# Question 6: Return a list with the remaining balance for the customer with the id ‘221’. List customer name, and the balance.

SELECT Name, SUM(TotalAmount)as RemainingBalance
FROM CUSTOMER as C, RENTAL as R
WHERE C.CustID =R.CustID AND C.CustID = '221' AND  R.PaymentDate IS NULL;

# Question 8: What is the total of money that customers paid to us until today?

SELECT SUM(TotalAmount) as TotalAmountReceived
FROM RENTAL
WHERE RENTAL.PAYMENTDATE IS NOT NULL;

/*
# Question 10: Retrieve all weekly rentals for the vechicleID ‘19VDE1F3XEE414842’ that are not paid yet.
 List the Customer Name, the start and return date, and the amount.                                         */
 
 SELECT C.Name, R.StartDate, R.ReturnDate, R.TotalAmount
 FROM RENTAL AS R, CUSTOMER AS C
 WHERE R.CustID = C.CustID AND R.VehicleID = '19VDE1F3XEE414842' AND R.PaymentDate IS NULL ;
 
# Question 11: Return all customers that they never rent a vehicle.

SELECT *
FROM CUSTOMER
WHERE CustID NOT IN (SELECT CustID FROM RENTAL);

/*
# Question 12: Return all rentals that the customer paid on the StartDate. List Customer Name, Vehicle  Descriptions,
StartDate, ReturnDate, and TotalAmount. Order by Customer Name.                                                            */

SELECT C.Name, V.Description, R.StartDate, R.ReturnDate, R.TotalAmount
FROM CUSTOMER AS C, RENTAL AS R, VEHICLE AS V
WHERE R.StartDate = R.PaymentDate AND R.CustID = C.CustID AND R.VehicleID = V.VehicleID
ORDER BY C.Name;

/*
# Question 7: Create a report that will return all vehicles. List the VehicleID as VIN, Description, Year, Type,
 Category, and Weekly and Daily rates. For the vehicle Type and Category, you need to use the SQL Case statement 
 to substitute the numbers with text. Order your results based on Category (first Luxury and then Basic) 
 and Type based on the Type number, not the text.  */
 
 SELECT V.VehicleID as VIN , V.Description, V.Year, 
 CASE V.Type
	WHEN 1 THEN 'Compact'
    WHEN 2 THEN 'Medium'
    WHEN 3 THEN 'Large'
    WHEN 4 THEN 'SUV'
    WHEN 5 THEN 'Truck'
    WHEN 6 THEN 'VAN'
END Type ,
CASE V.Category
	WHEN 0 THEN 'Basic'
    WHEN 1 THEN 'Luxury'
END Category, R.Weekly, R.Daily
 FROM RATE AS R 
 INNER JOIN VEHICLE AS V
 ON R.Type = V.Type AND R.CATEGORY = V.Category
 ORDER BY V.Category DESC, V.Type ; 
 
 /*# Question 9a: Create a report for the J. Brown customer with all vehicles he rented. List the description, year, type, and category. 
Also, calculate the unit price for every rental, the total duration mention if it is on weeks or days, the total amount, 
and if there is any payment. Similarly, as in Question 7, you need to change the numeric values to the corresponding text. 
Order the results by the StartDate. */
SELECT V.Description, V.Year, 
CASE V.Type
	WHEN 1 THEN 'Compact'
    WHEN 2 THEN 'Medium'
    WHEN 3 THEN 'Large'
    WHEN 4 THEN 'SUV'
    WHEN 5 THEN 'Truck'
    WHEN 6 THEN 'VAN'
END Type ,
CASE V.Category
	WHEN 0 THEN 'Basic'
    WHEN 1 THEN 'Luxury'
END Category, R.TotalAmount DIV R.Qty AS UnitPrice, R.Qty * R.RentalType AS TotalDaysRented, R.TotalAmount,
CASE 
	WHEN R.PaymentDate IS NULL THEN 'NO'
    ELSE 'YES'
END AS PaymentMade

FROM RENTAL as R, CUSTOMER as C, VEHICLE AS V
WHERE C.Name = 'J. Brown' AND C.CustID = R.CustID AND R.VehicleID = V.VehicleID 
ORDER BY R.StartDate;
