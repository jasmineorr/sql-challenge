Departments
-
dept_no VARCHAR PK
dept_name VARCHAR

Titles
-
emp_no INTEGER FK >- employees.emp_no
title VARCHAR
from_date DATE
to_date DATE

Department_Employee
-
emp_no INTEGER FK >- employees.emp_no
dept_no VARCHAR FK >- departments.dept_no
from_date DATE
to_date DATE

Employees
-
emp_no INTEGER PK
birth_date DATE
first_name VARCHAR
last_name VARCHAR
gender VARCHAR
hire_date DATE

Department_Manager
-
dept_no VARCHAR FK >- departments.dept_no
emp_no INTEGER FK >- employees.emp_no
from_date DATE
to_date DATE

Salaries
-
emp_no INTEGER FK >- employees.emp_no
salary INTEGER
from_date DATE
to_date DATE
