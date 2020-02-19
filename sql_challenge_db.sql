DROP TABLE Departments;
DROP TABLE Titles;
DROP TABLE Department_Employee;
DROP TABLE Employees;
DROP TABLE Department_Manager;
DROP TABLE Salaries;

CREATE TABLE Departments(
	 "dept_no" VARCHAR   NOT NULL PRIMARY KEY,
     "dept_name" VARCHAR   NOT NULL
);

CREATE TABLE Titles(
    "emp_no" INTEGER   NOT NULL,
    "title" VARCHAR   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

CREATE TABLE Department_Employee(
    "emp_no" INTEGER   NOT NULL,
    "dept_no" VARCHAR   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

CREATE TABLE Employees(
    "emp_no" INTEGER   NOT NULL PRIMARY KEY,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "gender" VARCHAR   NOT NULL,
    "hire_date" DATE   NOT NULL
);

CREATE TABLE Department_Manager(
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" INTEGER   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

CREATE TABLE Salaries(
    "emp_no" INTEGER   NOT NULL,
    "salary" INTEGER   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

ALTER TABLE "Titles" ADD CONSTRAINT "fk_Titles_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Department_Employee" ADD CONSTRAINT "fk_Department_Employee_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Department_Employee" ADD CONSTRAINT "fk_Department_Employee_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Department_Manager" ADD CONSTRAINT "fk_Department_Manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "Departments" ("dept_no");

ALTER TABLE "Department_Manager" ADD CONSTRAINT "fk_Department_Manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

ALTER TABLE "Salaries" ADD CONSTRAINT "fk_Salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "Employees" ("emp_no");

COPY Departments(dept_no, dept_name)
FROM '/tmp/departments.csv'
DELIMITER ',' CSV HEADER;

COPY Department_Employee
FROM '/tmp/dept_emp.csv'
DELIMITER ',' CSV HEADER;

COPY Department_Manager
FROM '/tmp/dept_manager.csv'
DELIMITER ',' CSV HEADER;

SELECT * FROM Department_Manager;

COPY Employees
FROM '/tmp/employees.csv'
DELIMITER ',' CSV HEADER;

SELECT * FROM Employees;

COPY Salaries
FROM '/tmp/salaries.csv'
DELIMITER ',' CSV HEADER;

SELECT * FROM Salaries;

COPY Titles
FROM '/tmp/titles.csv'
DELIMITER ',' CSV HEADER;

SELECT * FROM Titles;

--1. List the following details of each employee: employee number, last name, first name, 
--gender, and salary.

SELECT Employees.emp_no, Employees.last_name, Employees.first_name, Employees.gender, salaries.salary 
FROM Employees
INNER JOIN Salaries ON
Employees.emp_no=salaries.emp_no;

--2. List employees who were hired in 1986.

SELECT * FROM Employees WHERE hire_date between '01-01-1986' and '12-31-1986';

--3. List the manager of each department with the following information: department number, 
--department name, the manager's employee number, last name, first name, and start and end 
--employment dates.

SELECT Department_Manager.dept_no, Departments.dept_name, Department_Manager.emp_no, 
Employees.last_name, Employees.first_name, Employees.hire_date, Department_Manager.to_date
FROM Department_Manager
JOIN Departments ON Departments.dept_no = Department_Manager.dept_no
JOIN Employees ON Employees.emp_no = Department_Manager.emp_no;

--4. List the department of each employee with the following information: employee number, 
--last name, first name, and department name.

SELECT Employees.emp_no, Employees.last_name, Employees.first_name, Departments.dept_name
FROM Employees
JOIN Department_Employee ON Employees.emp_no = Department_Employee.emp_no
LEFT JOIN Departments ON Departments.dept_no = Department_Employee.dept_no
ORDER BY 1;

--5. List all employees whose first name is "Hercules" and last names begin with "B."

SELECT * FROM Employees WHERE first_name='Hercules' and last_name like 'B%';

--6. List all employees in the Sales department, including their employee number, last name, 
--first name, and department name.

SELECT Employees.emp_no, Employees.last_name, Employees.first_name, Departments.dept_name
FROM Employees 
INNER JOIN Department_Employee ON Employees.emp_no = Department_Employee.emp_no
INNER JOIN Departments ON Department_Employee.dept_no = Departments.dept_no
WHERE dept_name='Sales';

--7. List all employees in the Sales and Development departments, including their employee 
--number, last name, first name, and department name.

SELECT Employees.emp_no, Employees.last_name, Employees.first_name, Departments.dept_name
FROM Employees 
INNER JOIN Department_Employee ON Employees.emp_no = Department_Employee.emp_no
INNER JOIN Departments ON Department_Employee.dept_no = Departments.dept_no
WHERE dept_name='Sales' OR dept_name='Development';

--8. In descending order, list the frequency count of employee last names, i.e., 
--how many employees share each last name.

SELECT * FROM Employees;

SELECT last_name, COUNT(*)
FROM Employees
GROUP BY last_name;


