CREATE SCHEMA CAR_RENTAL;
CREATE TABLE CAR_RENTAL.CUSTOMER
(
  CustID INT NOT NULL PRIMARY KEY,
  Name VARCHAR(50),
  Phone CHAR(15)
);

CREATE TABLE CAR_RENTAL.RATE
(
  Type INT NOT NULL AUTO_INCREMENT,
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
