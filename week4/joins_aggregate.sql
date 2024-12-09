use dbtest3;


-- join :
-- cross join :
-- inner join :
-- outer join :
	--left outer join.
	--right outer join. 
	--full outer join.
	-- self join.


-- cross join
	select name,departmentname from employee,Department;
	
-- inner join
	select name,departmentname from employee inner join department on employee.DepartmentId = department.Id;
	
	select e.name,d.departmentname from employee e ,department d where e.departmentid = d.id;
	
-- left outpur join
	select name,departmentname from employee left outer join department on employee.DepartmentId = department.Id;
	
	select e.name,d.departmentname from employee e,department d where e.departmentid = d.id 
	union 
	select e2.name,null from employee e2 where not exists(select 1 from department d2 where e2.departmentid = d2.id);
-- right outer join
	select name,departmentname from employee right outer join department on employee.DepartmentId = department.Id;
	
	select e.name,d.departmentname from employee e, department d where e.departmentid = d.id
	union
	select d.departmentname , null from department d where not exists(select 1 from employee e where e.departmentid = d.id);
-- self join 
	select e1.name as employee_name ,e2.name as manager_name from employee e1,employee e2 where e1.managerid = e2.id;

-- Query : get country with cities 
select 	countryname,cityname from country inner join city on city.CountryId = country.Id;


--		get employee names
select name from employee where name like '%e_';

-- get employee,department,project:

select e.Name,d.DepartmentName,p.ProjectName from employee e  inner join Department d  on e.DepartmentId = d.Id 
inner join Project p on e.ProjectId = p.Id;

select e.name,d.departmentname,p.projectname from employee e,department d,project p where e.departmentid = d.id and e.projectid = p.id;

---------------------------------------------------------------------------



-- aggregate functions
-- max min avg count sum


select max(salary) as max_salary ,
min(salary) as min_salary, 
avg(salary) as avg_salary,
sum(salary) as sum_salary
from employee;


select count(salary) from employee;


-- get avg of salary of employee;
select sum(salary)/count(salary) from employee;

-- sub queries :

-- get all employee where age > avg of ages;
select name,salary from employee e where e.Salary > (select avg(e2.Salary) from employee e2); 

-- employee name and its department using subquery;
select e.name ,(select d.departmentname from department d where e.departmentid = d.id) from employee e;


-------------------------------------------------------------------
-- group by

select d.departmentname,sum(salary) as total_salary 
from employee e inner join department d on e.departmentid = d.Id 
group by d.DepartmentName 
having sum(salary) > 20000
order by total_salary desc;


------------------------------------------------------------------
-- order of execution:
-- 1- from
-- 2- join
-- 3- on
-- 4- where
-- 5- group by
-- 6- having
-- 7- select
-- 8- order by
-- 9- top(number) (with ties)


------------------------------------------------------------------
-- task :

-- deptname and sum salaries of each dept
	select d.departmentname,sum(e.salary) from employee e inner join department d on e.departmentid = d.id group by d.departmentname;	


-- deptname max salary min salary of each dept
	select d.departmentname,min(e.salary) as min_salary,max(e.salary) as max_salary
	from employee e inner join department d 
	on e.departmentid = d.id 
	group by d.departmentname;

-- deptname and number of employee of each dept > 2
	select d.departmentname,count(e.id) 
	from employee e inner join department d 
	on e.departmentid = d.id 
	group by d.departmentname 
	having count(e.id) > 2
	
-------------------------------------------------------------------
	
	
	
	