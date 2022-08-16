-- Export list as CSV file.
SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Retirement Eligibility
SELECT count(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT count(first_name)
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

SELECT first_name, last_name, birth_date
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';

SELECT first_name, last_name, birth_date
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';

SELECT first_name, last_name, birth_date
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';

SELECT * from current_emp LIMIT 10;
SELECT * FROM dept_emp LIMIT 10;
SELECT * FROM retirement_info LIMIT 10;

SELECT de.dept_name, COUNT(emp_no)
FROM current_emp AS ce
LEFT JOIN departments as de
ON ce.dept_no = de.dept_no
GROUP BY dept_name
ORDER BY dept_name;


DROP TABLE current_emp;
-- Left join retirement_info and dept_emp tables
-- Gets current employees nearing retirement.
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date,
	de.dept_no
INTO current_emp
FROM retirement_info AS ri
LEFT JOIN dept_emp AS de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

SELECT count(emp_no) FROM current_emp;

-- Join retirement_info & dept_emp tables
SELECT r.emp_no,
	r.first_name,
	r.last_name,
	d.to_date
FROM retirement_info as r
LEFT JOIN dept_emp AS d
ON r.emp_no = d.emp_no;


-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

SELECT * FROM employees LIMIT 10;

-- Add emp_no to retirement_info table.
DROP TABLE retirement_info;

SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Get count of employees nearing retirement for each
-- department.
SELECT de.dept_name, COUNT(emp_no)
FROM current_emp AS ce
LEFT JOIN departments as de
ON ce.dept_no = de.dept_no
GROUP BY dept_name
ORDER BY dept_name;

SELECT COUNT(ce.emp_no), de.dept_no
INTO dept_count
FROM current_emp AS ce
LEFT JOIN dept_emp AS de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

SELECT * FROM employees LIMIT 10;
SELECT * FROM salaries LIMIT 10;

-- Employee Information: A list of employees containing their 
-- unique employee number, their last name, first name, gender, 
-- and salary
SELECT e.emp_no, 
	e.first_name, 
	e.last_name, 
	e.gender, 
	s.salary, 
	de.to_date
INTO emp_info
FROM employees AS e
INNER JOIN salaries AS s
	ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
	ON (e.emp_no = de.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
	AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	AND (de.to_date = '9999-01-01');


-- Management: A list of managers for each department, including 
-- the department number, name, and the manager's employee number, 
-- last name, first name, and the starting and ending employment dates
SELECT * FROM current_emp;

SELECT dm.dept_no,
	d.dept_name,
	dm.emp_no, 
	ce.last_name, 
	ce.first_name,
	dm.from_date,
	dm.to_date
--INTO manager_info
FROM dept_manager AS dm
INNER JOIN departments AS d
	ON (dm.dept_no = d.dept_no)
INNER JOIN current_emp AS ce
	ON (dm.emp_no = ce.emp_no);


-- Department Retirees: An updated current_emp list that includes 
-- everything it currently has, but also the employee's departments
SELECT * FROM current_emp LIMIT 10;

SELECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
--INTO dept_info
FROM current_emp AS ce
INNER JOIN dept_emp AS de
	ON (ce.emp_no = de.emp_no)
INNER JOIN departments as d
	ON (de.dept_no = d.dept_no);

-- Build retirement list for only Sales department.
SELECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
--INTO dept_info
FROM current_emp AS ce
INNER JOIN dept_emp AS de
	ON (ce.emp_no = de.emp_no)
INNER JOIN departments as d
	ON (de.dept_no = d.dept_no)
WHERE d.dept_name = 'Sales';

-- Build combined retirement list for Sales & Development departments.
SELECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
--INTO dept_info
FROM current_emp AS ce
INNER JOIN dept_emp AS de
	ON (ce.emp_no = de.emp_no)
INNER JOIN departments as d
	ON (de.dept_no = d.dept_no)
WHERE dept_name IN ('Sales', 'Development');

