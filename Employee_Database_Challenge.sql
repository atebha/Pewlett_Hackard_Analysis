--Deliverable 1

-- 1

-- create retirement titles table
SELECT e.emp_no,
    e.first_name,
    e.last_name,
    t.title,
    t.from_date,
    t.to_date
INTO retirement_titles
FROM employees as e
    INNER JOIN titles as t
        ON (e.emp_no = t.emp_no)
        WHERE (e.birth_date BETWEEN '1951-01-01' AND '1955-01-01')
ORDER BY e.emp_no;


-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
	first_name,
	last_name,
	title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

-- retirement eligibility by title
SELECT COUNT (title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(title) DESC;

-- Create Mentorship Table
SELECT DISTINCT ON (e.emp_no) e.emp_no,
    e.first_name,
    e.last_name,
    e.birth_date,
    de.from_date,
    de.to_date,
    t.title
INTO mentorship
FROM employees as e
    INNER JOIN dept_emp AS de
        ON (e.emp_no = de.emp_no)
    INNER JOIN titles AS t
        ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no, t.to_date DESC;
