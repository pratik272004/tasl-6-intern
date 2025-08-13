-- 1. Create Departments table
CREATE TABLE Dept (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL,
    location VARCHAR(100)
);

-- 2. Create Employees table with foreign key to Departments
CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL,
    position VARCHAR(50),
    salary DECIMAL(10, 2),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Dept(dept_id)
);
 select * from Dept;
 
 select * from Employees;

 INSERT INTO Dept (dept_id, dept_name, location) VALUES
(1, 'HR', 'New York'),
(2, 'IT', 'San Francisco'),
(3, 'Finance', 'Chicago'),
(4, 'Marketing', 'Boston');

INSERT INTO Employees (emp_id, emp_name, position, salary, dept_id) VALUES
(101, 'Alice', 'HR Manager', 60000, 1),
(102, 'Bob', 'Recruiter', 45000, 1),
(103, 'Charlie', 'Software Engineer', 75000, 2),
(104, 'David', 'Accountant', 50000, 3),
(105, 'Eve', 'Sales Executive', 55000, NULL);  -- No department assigned

--average salary using subqueries
SELECT emp_id, emp_name, salary
FROM Employees
WHERE salary > (SELECT AVG(salary) FROM Employees);

--max salary using where ,from queries
SELECT emp_id, emp_name, dept_id, salary
FROM Employees e
WHERE salary = (
    SELECT MAX(salary)
    FROM Employees
    WHERE dept_id = e.dept_id
);

--min salary using where ,from queries
SELECT emp_id, emp_name, dept_id, salary
FROM Employees e
WHERE salary = (
    SELECT min(salary)
    FROM Employees
    WHERE dept_id = e.dept_id
);
--using in 
SELECT emp_id, emp_name, dept_id
FROM Employees
WHERE dept_id IN (
    SELECT dept_id
    FROM Dept
    WHERE location IN ('New York', 'Chicago')
);
--using exists
SELECT dept_id, dept_name
FROM  dept d
WHERE EXISTS (
    SELECT 1
    FROM Employees e
    WHERE e.dept_id = d.dept_id
);
--not in
SELECT emp_id, emp_name
FROM Employees
WHERE dept_id NOT IN (
    SELECT dept_id
    FROM Dept
);
--not exists
SELECT dept_id, dept_name
FROM Dept d
WHERE NOT EXISTS (
    SELECT 1
    FROM Employees e
    WHERE e.dept_id = d.dept_id
);

