-- Deliverable #1
-- Create a Retirement Titles table that holds all the titles 
-- of employees who were born between January 1, 1952 and 
-- December 31, 1955
SELECT e.emp_no, e.first_name, e.last_name,
	t.title, t.from_date, t.to_date
INTO retirement_titles
FROM employees AS e
INNER JOIN titles AS t
	ON (e.emp_no = t.emp_no)
WHERE (e.birth_date >= '1952-01-01')
	AND (e.birth_date <= '1955-12-31')
ORDER BY e.emp_no;


-- The table has duplicate titles. Query to remove duplicates and
-- keep only the most recent title for each employee.
SELECT DISTINCT ON (emp_no) emp_no,
	first_name,
	Last_name,
	title
INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;	
	
	
-- Retrieve the number of employees by their most recent job title who 
-- are about to retire.
SELECT COUNT (title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title 
ORDER BY count DESC;


-- Deliverable #2
-- write a query to create a Mentorship Eligibility table that holds the
-- employees who are eligible to participate in a mentorship program
SELECT DISTINCT ON (e.emp_no) t.emp_no, 
	e.first_name, 
	e.last_name, 
	e.birth_date,
	de.from_date, 
	de.to_date,
	t.title
INTO mentorship_eligibility
FROM employees AS e
INNER JOIN dept_emp AS de
	ON (e.emp_no = de.emp_no)
INNER JOIN titles AS t
	ON (e.emp_no = t.emp_no)
WHERE (de.to_date = '9999-01-01') 
	AND (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;
