--Deliverable 1: The Number of Retiring Employees

select
e.emp_no,
e.first_name,
e.last_name,
t.title,
t.from_date,
t.to_date
into retirement_titles
from employees as e
inner join titles as t 
on e.emp_no = t.emp_no
where e.birth_date between '1952-01-01' and '1955-12-31'
order by e.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no, from_date DESC;

select 
count(title) as count,
title
into retiring_titles
from
unique_titles
group by title
order by count desc;

--The Employees Eligible for the Mentorship Program
select
distinct on (e.emp_no) e.emp_no,
e.first_name,
e.last_name,
e.birth_date,
de.from_date,
de.to_date,
t.title
into mentor_eligibility
from
employees e
inner join dept_emp de
on e.emp_no = de.emp_no
inner join titles t
on e.emp_no = t.emp_no
where 
de.to_date = '9999-01-01'
and e.birth_date between '1965-01-01' and '1965-12-31'
order by e.emp_no;

select
count(emp_no) as count,
title
from mentor_eligibility
group by title
order by
count desc;

--Active Employees

select
count(emp_no) as number_of_active_employees
from
dept_emp
where
to_date = '9999-01-01'

--Mentors per retiring employee
WITH cte AS (
    SELECT rt.title AS Retiring_titles,
           count AS Retirement_Title_Counts,
           COUNT(me.emp_no) AS Mentor_Count
    FROM retiring_titles rt
    LEFT OUTER JOIN mentor_eligibility me
        ON rt.title = me.title
    GROUP BY rt.title,
	Retirement_Title_Counts
)
SELECT Retiring_titles,
       Retirement_Title_Counts,
       Mentor_Count,
       Retirement_Title_Counts/NULLIF(Mentor_Count, 0) AS Retiring_Employees_per_Mentor
FROM cte
order by Retiring_Employees_per_Mentor desc

select
count (de.emp_no) as number_of_active_employees, d.dept_name from dept_emp de
inner join departments d
on de.dept_no = d.dept_no
where
to_date = '9999-01-01'
group by d.dept_name

select
count (de.emp_no) as number_of_active_employees,
t.title
from dept_emp de
inner join titles t
on de.emp_no = t.emp_no
where
de.to_date = '9999-01-01'
 and t.to_date = '9999-01-01'
 
group by
t.title

--Percentage of employees retiring by title
WITH cte AS (
    SELECT title, count(emp_no) as number_of_retiring_employees
    FROM retirement_titles
    WHERE to_date = '9999-01-01'
    GROUP BY title
)

SELECT titles.title,
       COUNT(distinct dept_emp.emp_no) as number_of_active_employees,
       cte.number_of_retiring_employees,
	   TO_CHAR((cte.number_of_retiring_employees::decimal / COUNT(dept_emp.emp_no) * 100), '990D0%') as percentage_of_retiring_employees
FROM dept_emp
INNER JOIN titles ON dept_emp.emp_no = titles.emp_no
INNER JOIN cte ON titles.title = cte.title
WHERE dept_emp.to_date = '9999-01-01'
and titles.to_date = '9999-01-01'
GROUP BY titles.title, cte.number_of_retiring_employees;




	
	









