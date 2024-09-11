-- specify database to use
USE school;
SELECT * FROM Students;
#Dropping existing table
DROP TABLE Students;
#creating new table
CREATE TABLE Students(
StudentID int primary key,
FirstName varchar(100) not null,
LastName varchar(100),
Age int check (Age >= 18),
Email varchar(255) unique not null);

#inserting data into table
INSERT INTO Students (StudentID, FirstName, LastName, Age, Email)
VALUES
	(1,'John','Doe',20,'john.doe@example.com'),
    (2,'Jane','Smith',22,'jane.smith@example.com'),
    (3,'Michael','Brown',19,'michael.brown@example.com');

#altering the table
-- add enrollment date columnn
alter table Students
add EnrollmentDate date;

-- modify email attribute
alter table Students
modify Email varchar(300);

-- Drop last name column
alter table Students
drop column LastName;

select * from Students;