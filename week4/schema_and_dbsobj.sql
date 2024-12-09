-- schema

-- task :

-- elec and  fash schema with product table

create schema electronics;

create table electronics.prod(
	id int primary key
);

create schema fashions;

create table fashions.prod(
	id int primary key
);

-- create employee table in electronics schema and transfere it to hrmodule

create table electronics.employee(
	id int primary key,
	name nvarchar(max)
);


create schema hrmodule;

alter schema hrmodule 
transfer electronics.employee; -- cut the table from electronics to hrmodule

select * into hrmodule.employee from electronics.employee; -- copy the entire table with data

-----------------------------------------------------

-- string functions
select substring(e.name,1,5) from employee e ;

select len(name) from employee e ;

select upper(e.name) from employee e;

select lower(e.name) from employee e;

select ltrim(name,'') from employee;

select concat('welcome ',name) from employee;

--task :
	-- each employee name the first charc upper and others small with no spaces

select concat(upper(substring((ltrim(name)),1,1)),lower(substring((ltrim(name)),1,len(name)))) from employee;

----------------------------------------------------------

-- dbsobj

-- 1-views : 
-- 		a) security from like sqlinjection
--		b) complex query container : by storing table come out from this complex script 
-- 		c) network wise : instead of transfere the hole query just transfere the name of view that have the query
--		d) hide business rule : like just giving you virtual table with name ,id but no salary

create view view_employee_data as -- after as choose what data you want to store
select * from employee;

select * from view_employee_data; -- it's a virtual table so you can access it like normal table.



-- task :


-- view showing : 
-- employees,
-- departments,
-- projects,
-- emp,dept,proj,
-- city,
-- country,
-- district,
-- city,country,district,
-- name,dept_name,project_name,country_name,city_name,district_name,

create view view_employee as
select * from employee;

create view view_department as
select * from department;

create view view_project as
select * from project;

create view view_emp_dept_proj_name as
select e.name as emp_name,d.departmentname as dept_name,p.projectname as proj_name,e.countryid
from view_employee e inner join view_department d 
on e.departmentid = d.id
inner join view_project p
on e.projectid = p.id;

create view view_city as
select * from city;

create view view_country as
select * from country;

create view view_district as
select * from district;

create view view_allnames as
select edp.emp_name,edp.dept_name ,edp.proj_name,ctry.countryname as country_name,cty.cityname as city_name,dist.districtname as dist_name
from view_city cty inner join view_country ctry on cty.countryid = ctry.id 
inner join view_district dist on dist.cityid = cty.id 
inner join view_emp_dept_proj_name as edp  on edp.countryid = ctry.id



