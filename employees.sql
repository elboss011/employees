use employess;
show tables;
describe employees;
describe departments;
describe dept_emp;
describe dept_manager;
describe salaries;
describe titles;
describe students;

use employees;
select count(*)as total_employees from employees;
select count(*)as total_departments from departments;
select min(hire_date), max(hire_date) from employees;

select d.dept_name ,
round(avg(s.salary),2) as avg_salary 
from departments d
join dept_emp de on d.dept_no = de.dept_no
join salaries s on de.emp_no = s.emp_no
where de.to_date = '9999-01-01'
and s.to_date ='9999-01-01'
group by d.dept_name 
order by avg_salary desc; 

select year (hire_date) as year,
count(*)as hired 
from employees
group by year 
order by year;

select e.first_name , e.last_name , s.salary
from employees e 
join salaries s on e.emp_no = s.emp_no
where s.to_date = '9999-01-01'
order by s. salary desc 
limit 10;

select d.dept_name ,
round(avg(s.salary),2) as avg_salary
from departments d 
join dept_emp de on d.dept_no = de.dept_no
join salaries s on de.emp_no = s.emp_no
where de.to_date = '9999-01-01'
and s.to_date = '9999-01-01'
group by d.dept_name
order by avg_salary desc;

select e.first_name , e.last_name,d.dept_name,s.salary ,
rank() over (partition by d.dept_name 
order by s.salary desc) as salary_rank from employees e 
join salaries s on e.emp_no = s.emp_no
join dept_emp de on e.emp_no = de.emp_no 
join departments d on de.dept_no = d.dept_no 
where s.to_date = '9999-01-01'
and de.to_date ='999-01-01';

with dept_avg as (
select d.dept_name ,
avg(s.salary) as avg_salary 
from departments d 
join dept_emp de on d.dept_no = de.dept_no 
join salaries s on de.emp_no = s.emp_no 
where de.to_date ='9999-01-01'
and s.to_date ='9999-01-01'
group by d.dept_name ) 
select dept_name , 
round(avg_salary,2) as avg_salary 
from dept_avg
where avg_salary>(select avg(salary) from salaries 
where to_date = '9999-01-01')
order by avg_salary desc;

select first_name, last_name ,
timestampdiff(year ,hire_date,curdate()) as years_exp,
case
when timestampdiff(year , hire_date ,curdate())>15 then 'senior'
when timestampdiff(year ,hire_date,curdate())>8 then ' mid_level'
else 'junior'
end as level
from employees
order by years_exp desc;