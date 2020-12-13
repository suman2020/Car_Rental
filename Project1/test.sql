CREATE SCHEMA SUMAN;

CREATE TABLE SUMAN.EMPLOYEE (
first_name VARCHAR(50) NOT NULL,
mid_init longtext,
last_name VARCHAR(50) NOT NULL,
employee_id CHAR(15) NOT NULL,
birth_date VARCHAR(50),
address VARCHAR(100),
gender CHAR,
salary DECIMAL(10,2),
manager_id CHAR(15),
d_num INT NOT NULL,
PRIMARY KEY (employee_id)
);

CREATE TABLE SUMAN.DEPARTMENT (
depart_name VARCHAR(50) NOT NULL,
depart_num INT NOT NULL,
manager_id CHAR(15) NOT NULL,
manager_start_date VARCHAR(15),
PRIMARY KEY(depart_num),
UNIQUE(depart_name),
FOREIGN KEY (manager_id) REFERENCES EMPLOYEE(employee_id)
	ON DELETE NO ACTION
	ON UPDATE CASCADE
);

CREATE TABLE SUMAN.DEPT_LOCATIONS (
depart_number INT NOT NULL,
depart_location VARCHAR(50) NOT NULL,
PRIMARY KEY (depart_number, depart_location),
FOREIGN KEY (depart_number) REFERENCES DEPARTMENT(depart_num)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);

CREATE TABLE SUMAN.PROJECT (
project_name VARCHAR(50) NOT NULL,
project_num DECIMAL(5,2) NOT NULL,
project_location VARCHAR(50),
depart_N INT NOT NULL,
PRIMARY KEY(project_num),
UNIQUE(project_name),
FOREIGN KEY(depart_N) REFERENCES DEPARTMENT(depart_num)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);

CREATE TABLE SUMAN.WORKS_ON (
employee_id CHAR(9) NOT NULL,
proj_number DECIMAL(5,2) NOT NULL,
work_hours DECIMAL(3,1) NOT NULL,
PRIMARY KEY (employee_id, proj_number),
FOREIGN KEY (employee_id) REFERENCES EMPLOYEE (employee_id)
	ON DELETE NO ACTION
	ON UPDATE CASCADE,
FOREIGN KEY (proj_number) REFERENCES PROJECT(project_num)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);
