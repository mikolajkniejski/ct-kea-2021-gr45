# Creating the Database:
DROP DATABASE if exists CTdb;
CREATE DATABASE CTdb;

# Queries below creates tables inside the CTdb database with 
# the specifications of the relational data model.
USE CTdb;
CREATE TABLE Users(
User_id int NOT NULL AUTO_INCREMENT,
First_Name VARCHAR(25),
Last_Name VARCHAR(25),
Gender ENUM('F','M'),
Birthdate date,
Email VARCHAR(25),
Member tinyint,
PRIMARY KEY (User_id)
);

CREATE TABLE PaymentInfo(
Payment_id int NOT NULL auto_increment,
User_id int NOT NULL,
CreditCard_N VARCHAR(16),
CC_Exp_date date,
CC_Brand VARCHAR(25),
Active tinyint,
PRIMARY KEY (Payment_id),
FOREIGN KEY (User_id) REFERENCES Users(User_id) ON DELETE CASCADE
);

CREATE TABLE Addresses(
User_id int NOT NULL,
Country VARCHAR(25),
State VARCHAR(25),
City VARCHAR(25),
Street VARCHAR(25),
Zip_Code int,
PRIMARY KEY (User_id),
FOREIGN KEY (User_id) REFERENCES Users(User_id) ON DELETE CASCADE
);

CREATE TABLE Areas(
Area_id int NOT NULL,
Area_Name VARCHAR(25) NOT NULL,
Description VARCHAR(180),
PRIMARY KEY (Area_id)
);

CREATE TABLE Levels (
Level_id int NOT NULL AUTO_INCREMENT,
Level_Name VARCHAR(150) NOT NULL,
PRIMARY KEY (Level_id)
);

CREATE TABLE Courses (
Course_id int NOT NULL auto_increment,
DateofCreation datetime NOT NULL,
Course_Name VARCHAR(180) NOT NULL,
Description VARCHAR(250),
Area_id int NOT NULL,
Level_id int NOT NULL,
PRIMARY KEY (Course_id),
FOREIGN KEY (Area_id) REFERENCES Areas(Area_id),
FOREIGN KEY (Level_id) REFERENCES Levels(Level_id)
);

CREATE TABLE Quizzes(
Quiz_id int NOT NULL AUTO_INCREMENT,
Q_Name VARCHAR(25) NOT NULL,
Description VARCHAR(180),
Course_id int DEFAULT NULL,
PRIMARY KEY (Quiz_id)
);

CREATE TABLE Questions(
Question_id int NOT NULL AUTO_INCREMENT,
Question VARCHAR(150) NOT NULL,
Subquestion VARCHAR(150),
Area_id int NOT NULL,
PRIMARY KEY (Question_id),
FOREIGN KEY (Area_id) REFERENCES Areas(Area_id)
);

CREATE TABLE Question_Options (
Question_id int NOT NULL,
Option_id int NOT NULL,
Option_desc VARCHAR(250),
Grants_Points tinyint NOT NULL,
PRIMARY KEY (Question_id, Option_id),
FOREIGN KEY (Question_id) REFERENCES Questions(Question_id)
);

CREATE TABLE Quiz_Questions(
Quiz_id int NOT NULL,
Question_id int NOT NULL,
Points int NOT NULL,
PRIMARY KEY (Quiz_id, Question_id),
FOREIGN KEY (Quiz_id) REFERENCES Quizzes(Quiz_id),
FOREIGN KEY (Question_id) REFERENCES Questions(Question_id)
);

CREATE TABLE Q_Answers(
Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
User_id int NOT NULL,
Quiz_id int NOT NULL,
Question_id int NOT NULL,
Option_id TINYINT NOT NULL,
PRIMARY KEY (User_id, Quiz_id, Question_id, Date),
FOREIGN KEY (User_id) REFERENCES Users(User_id) ON DELETE CASCADE,
FOREIGN KEY (Quiz_id) REFERENCES Quizzes(Quiz_id) ON DELETE CASCADE,
FOREIGN KEY (Question_id) REFERENCES Questions(Question_id) ON DELETE CASCADE
);

CREATE TABLE Enrollments (
Enr_id int NOT NULL AUTO_INCREMENT,
Enr_Date DATETIME NOT NULL,
User_id int NOT NULL,
Course_id int NOT NULL,
PRIMARY KEY (Enr_id),
FOREIGN KEY (User_id) REFERENCES Users(User_id) ON DELETE CASCADE,
FOREIGN KEY (Course_id) REFERENCES Courses(Course_id) ON DELETE CASCADE
);