create database exam_system;

use exam_system;

-- tables built in system
create table course( 
	id int primary key identity,
	name nvarchar(10),
	description nvarchar(max),
	min_degree int,
	max_degree int
);


create table account(
	email varchar(30) primary key,
	password varchar(max)
);


create table instructor(
	id int primary key identity,
	fname nvarchar(10),
	lname nvarchar(10),
	date_birth date,
	age as dbo.date_diff(date_birth),
	type_t bit,
	email varchar(30),
	
	foreign key(email) references account(email) 
);


create table instructor_phone(
	phone char(11) check(phone not like '%[^0-9]%'),
	instructor_id int,
	
	primary key(phone),
	foreign key(instructor_id) references instructor(id),
);


create table class(
	id int primary key identity,
	name nvarchar(10),
	capacity tinyint
);

create table teach(
	instructor_id int,
	class_id int,
	teaching_year int check(teaching_year >= 1900 and teaching_year <= year(getdate())),
	course_id int,
	
	primary key(instructor_id,class_id),
	
	foreign key(instructor_id) references instructor(id),
	foreign key(class_id) references class(id),
	foreign key(course_id) references course(id)
);


create table exam(
	id int primary key identity,
	type_t bit,
	exam_year int check(exam_year >= 1900 and exam_year <= year(getdate())),
	start_time time(0),
	end_time time(0),
	total_time as dbo.time_diff(start_time,end_time),
	allowance_option bit,
	no_question int,
	course_id int,
	total_degree int,
	foreign key(course_id) references course(id)
);


create table question(
	id int primary key identity,
	type_t bit,
	question nvarchar(max),
	answer_id int,
	choises nvarchar(max),
	foreign key(answer_id) references answer(id)
);


create table answer(
	id int primary key identity,
	choise nvarchar(max),
);


create table make_exam(
	instructor_id int,
	question_id int,
	exam_id int,
	degree int,

	primary key(instructor_id,question_id,exam_id),
	foreign key(instructor_id) references instructor(id),
	foreign key(question_id) references question(id),
	foreign key(exam_id) references exam(id)
);


create table intake(
	id int primary key identity,
	intake_year int check(intake_year >= 1900 and intake_year <= year(getdate()))
);

create table branch(
	id int primary key identity,
	name nvarchar(20)
);

create table track(
	id int primary key identity,
	name nvarchar(20)
);


create table course_in_track(
	course_id int,
	track_id int,

	primary key(course_id,track_id),
	foreign key(course_id) references course(id),
	foreign key(track_id) references track(id)
);


create table track_in_branch(
	branch_id int,
	track_id int,

	primary key(branch_id,track_id),
	foreign key(branch_id) references branch(id),
	foreign key(track_id) references track(id)
);



create table student(
	id int primary key identity,
	fname nvarchar(10),
	lname nvarchar(10),
	date_birth date,
	age as dbo.date_diff(date_birth),
	email varchar(30),
	intake_id int,
	branch_id int,
	track_id int,
	
	foreign key(email) references account(email),
	foreign key(intake_id) references intake(id),
	foreign key(branch_id) references branch(id),
	foreign key(track_id) references track(id)
	
);

create table student_phone(
	phone char(11) check(phone not like '%[^0-9]%'),
	student_id int,
	
	primary key(phone),
	foreign key(student_id) references student(id),
);


create table student_answer_question(
	student_id int,
	exam_id int,
	question_id int,
	choise nvarchar(max),
	
	primary key(student_id,exam_id,question_id),
	foreign key(student_id) references student(id),
	foreign key(question_id) references question(id),
	foreign key(exam_id) references exam(id)
	
);

-- functions built in system
create function date_diff(@date_birth date) returns int
as
begin
	declare @age int = Year(getdate()) - Year(@date_birth);
	if(
		month(getdate()) < month(@date_birth) 
		or 
		(month(getdate()) = month(@date_birth) and day(getdate()) < day(@date_birth))
	)
		set @age = @age -1;
	
	return	@age;
end


alter function time_diff(@start_time time,@end_time time) returns char(8)
as
begin
	declare @seconds int = 
		(DatePart(second , @end_time) + DatePart(minute , @end_time) * 60 + DatePart(hour , @end_time) * 3600)
		-
		(DatePart(second , @start_time) + DatePart(minute , @start_time) * 60 + DatePart(hour , @start_time) * 3600);
	
	declare @hours int = @seconds / 3600;
	set @seconds = @seconds - (@hours * 3600);
	
	declare @minutes int = @seconds / 60;
	set @seconds= @seconds - (@minutes * 60);	

	return 
		right('00' + cast(@hours as varchar(2)),2) + ':' +
		right('00' + cast(@minutes as varchar(2)),2) + ':' +
		right('00' + cast(@seconds as varchar(2)),2);
end



