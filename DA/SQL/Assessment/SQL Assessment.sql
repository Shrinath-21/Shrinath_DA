create database try;
use try;

create table employees (
Employee_id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR (100),
position VARCHAR (100), salary DECIMAL (10, 2), hire_date DATE
);

CREATE TABLE employee_audit (
audit_id INT AUTO_INCREMENT PRIMARY KEY,
Employee_id INT,
name VARCHAR
(100),
position VARCHAR (100), salary DECIMAL (10, 2), hire_date DATE,
action_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO employees (name, position, salary, hire_date) VALUES ('John Doe',
'Software Engineer', 80000.00, '2022-01-15'),
('Jane Smith', 'Project Manager', 90000.00, '2021-05-22'),
('Alice Johnson', 'UX Designer', 75000.00, '2023-03-01');

select * from employees;


DELIMITER $$
create trigger newemp_details
after insert on employees
for each row
begin
insert into employee_audit(Employee_id,name,position,salary,hire_date)
values (NEW.Employee_id,NEW.name,NEW.position,NEW.salary,NEW.hire_date);
end $$

DELIMITER ;

DELIMITER $$

DROP PROCEDURE IF EXISTS addnewemp;
SELECT * FROM employee_audit;

DELIMITER $$

CREATE PROCEDURE addnewemp(
    IN emp_name VARCHAR(100),
    IN emp_position VARCHAR(100), 
    IN emp_salary DECIMAL(10,2), 
    IN emp_hire_date DATE
)
BEGIN
INSERT INTO employees (name, position, salary, hire_date)
VALUES (emp_name, emp_position, emp_salary, emp_hire_date);
END $$

DELIMITER ;

CALL addnewemp('Shrinath', 'DA', 50000, '2025-04-01');

SELECT * FROM employee_audit;