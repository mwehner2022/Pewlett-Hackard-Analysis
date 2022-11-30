-- Challenge 1 create retirement titles
SELECT employees.emp_no, employees.first_name,
        employees.last_name,
		titles.titles,
		titles.from_date,
		titles.to_date

INTO retirement_titles
FROM employees
INNER JOIN titles
ON employees.emp_no = titles.emp_no
WHERE (employees.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no ASC;




-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (retirement_titles.emp_no) retirement_titles.emp_no,
                    retirement_titles.first_name,
					retirement_titles.last_name,
					retirement_titles.titles
INTO unique_titles.
FROM retirement_titles
WHERE (retirement_titles.to_date = '9999-01-01')
ORDER BY emp_no ASC, to_date DESC;



--# of employees by most recent job title who are about to retire
SELECT COUNT (unique_titles.emp_no), unique_titles.titles
INTO retiring_titles
FROM unique_titles
GROUP BY unique_titles.titles
ORDER BY unique_titles.count DESC

--Challenge 2 create a Mentorship Eligibility table that holds 
--the employees who are eligible to participate in a mentorship program
SELECT DISTINCT ON (employees.emp_no) employees.emp_no, employees.first_name,
        employees.last_name, employees.birth_date,
		dept_emp.from_date, dept_emp.to_date,
		titles.titles
INTO mentorship_eligibilty
FROM employees
INNER JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no
INNER JOIN titles
ON employees.emp_no = titles.emp_no
WHERE dept_emp.to_date = '9999-01-01'
AND (employees.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY employees.emp_no ASC
