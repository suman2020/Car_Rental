CONTENS OF THIS FILE:
- Introduction
- Tools Used
- Using the tools
	- create a database
   	- create a table
	- load data into tables
	- run a query
- Contributors
----------------------------------------------------------------------------------------------------
INTRODUCTION: 
	The objective of this project was to create and use a relational DBMS effectively.
	MYSQL workbench was used to creat a database, populate the tables with data and 
	run feasible queries.

TOOLS used: 
	- MYSQL Workbench 8.0 was used throughout the project.This tool has an inbuilt SQL editor
	  which facilitated to create schemas, load data, run queries and export results in all in a
	  single platform. The inbuilt OBJECT BROWSER helped to easily navigate between database schemas
	  and objects.
		INSTALLAION GUIDE:
			Download link: https://dev.mysql.com/downloads/mysql/
			GuideLines: https://www.youtube.com/watch?v=u96rVINbAUI&feature=emb_logo

	- WINDOWS Snipping Tool was used to crop the output generated from the queries into a .jpg file.

USING THE TOOLS:
	- create a database:
		Inside the file editor of MYSQL workbench, enter the following command.
			CREATE SCHEMA <name of database>;

	- create tables/entity type inside  database:
		Run the SQL query similar to the following command as per your need: 
			  
			CREATE TABLE <table name> 
			(
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
		NOTE: This is just a sample on how an entity type can be created inside a database. 

	- load data into tables:
		* Select the particular table/ entity type where you want to load the data
		* Right click and choose "Table Data Import Wizard"
		* Browse and select the .csv file that contains the data
		* Data should be loaded in the respective columns as defined in the entity type

	- run a query:
		On the SQL editor run the script to query the output as desired.
		Here's a sample to run the query.
					*****
			SELECT first_name,mid_init,last_name,salary
			FROM company_project.employee,company_project.department
			WHERE depart_name='Research'AND depart_num = d_num;
					*****
			- This query was executed to retrieve the name and salaries of all the employees 
			  who work in a particular department, i.e. 'Research' in this case.

		Note: This way we can run query as per the necessity or requirement of the project/ client.

CONTRIBUTORS AND SUPPORTERS:
	* Yunika Upadhyaya
	* Pratik Mahato
	* Suman Thapa Magar
	* Nadra Guizani	