-- Creating tables for PH-EmployeeDB
CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);

create table employees ( emp_no INT NOT NULL,
     birth_date DATE NOT NULL,
     first_name VARCHAR NOT NULL,
     last_name VARCHAR NOT NULL,
     gender VARCHAR NOT NULL,
     hire_date DATE NOT NULL,
     PRIMARY KEY (emp_no)
);     
dept_manager table
create table dept_manager ( emp_no INT NOT NULL,
     dept_no VARCHAR(4) NOT NULL,
     from_date DATE NOT NULL,
     to_date DATE NOT NULL,
     PRIMARY KEY (emp_no, dept_no),
     FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
     FOREIGN KEY (dept_no) REFERENCES departments (dept_no)
);
dept_emp table
create table dept_emp ( emp_no INT NOT NULL,
     dept_no VARCHAR(4) NOT NULL,
     from_date DATE NOT NULL,
     to_date DATE NOT NULL,
     PRIMARY KEY (emp_no, dept_no),
     FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
     FOREIGN KEY (dept_no) REFERENCES departments (dept_no)
);
salaries table
create table salaries ( emp_no INT NOT NULL,
     salary INT NOT NULL,
     from_date DATE NOT NULL,
     to_date DATE NOT NULL,
     PRIMARY KEY (emp_no, from_date),
     FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);
titles table
create table titles ( emp_no INT NOT NULL,
     title VARCHAR NOT NULL,
     from_date DATE NOT NULL,
     to_date DATE NOT NULL,
     PRIMARY KEY (emp_no, from_date),
     FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);
