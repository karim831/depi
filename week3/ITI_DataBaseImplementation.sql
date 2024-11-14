create database ITI_database;
use ITI_database;

/*				Tables				*/

create table student_t(
	id int primary key identity,
	f_name nvarchar(10) not NULL,
	l_name nvarchar(10) not NULL,
	age int not NULL,
	addresse nvarchar(20) not NULL
);


create table course_t(
	id int primary key identity,
	name nvarchar(15) not NULL,
	duration time not NULL,
	description nvarchar(MAX),
	topic_id int not NULL
);


create table topic_t(
	id int primary key identity,
	name nvarchar(10)
);


create table take_t(
	st_id int not NULL,
	course_id int not NULL,
	gread float,
);


create table instructor_t(
	id int primary key identity,
	name nvarchar(20),
	salary money not NULL,
	hoursrate int not NULL,
	addresse nvarchar(20) not NULL,
	dept_id int not NULL
);

create table teach_t(
	ins_id int not NULL,
	crs_id int not NULL,
	evolution int not NULL
);

create table department_t(
	id int primary key identity,
	name nvarchar(20) not NULL,
	mag_id int not NULL
);


/*				Constraints				*/

alter table course_t 
add constraint 	FK_course_topic 
foreign key(topic_id) references topic_t(id);

alter table instructor_t
add constraint FK_department foreign key(dept_id) references department_t(id);

alter table department_t
add constraint FK_manager foreign key(mag_id) references instructor_t(id);



alter table take_t
add constraint PK_student_course primary key(st_id,course_id);

alter table take_t 
add constraint FK_student foreign key(st_id) references student_t(id);

alter table take_t
add constraint FK_course foreign key(course_id) references course_t(id);


alter table teach_t
add constraint PK_instructor_course primary key(ins_id,crs_id);

alter table teach_t
add constraint FK_instructor foreign key(ins_id) references instructor_t(id);

alter table teach_t
add constraint FK_teachcourse foreign key(crs_id) references course_t(id);



