# Selecting the CTdb database;
USE CTdb;

# Inserting data into the database's tables
# Below we insert random users as members
INSERT INTO Users (First_Name, Last_Name, Gender, Birthdate, Email, Member)
VALUES
('Mark', 'Carlsberg', 'M', '1986-02-15', 'markc@gmail.com', '1'),
('Luiza', 'Budweiser', 'F', '1990-09-09', 'luizat@hotmail.com', '1'),
('Martin', 'Tuborg', 'M', '1995-03-22', 'masa@gmail.com', '1'),
('Jesper', 'Elephant', 'M', '2000-01-20', 'jela@yahoo.com', 1),
('Robert', 'Marabou', 'M', NULL, 'robert@company.com', '1'),
('Anne Mette', 'Håndsprit', 'F', NULL, 'anne@company.com', '1'),
('Jasmin', 'Antonberg', 'F', '1990-07-26', 'jasss@company.com', '1');

# Below we insert visitors who completed the test but are not members
INSERT INTO Users (Member)
VALUES
(0),
(0),
(0);

# Below we insert address information to some members
INSERT INTO Addresses (User_id, Country, State, City, Zip_Code, Street)
VALUES
(1, 'Denmark', '','Copenhagen', '2000', 'Kristens Walters vej 43'),
(2, 'USA', 'Los Angeles', 'California', '567390', 'Wellington road 22'),
(3, 'Denmark', '', 'Copenhagen', '2400', 'Ringsted gade 20');

# Below we insert payment information for some users.
INSERT INTO PaymentInfo (User_id, CreditCard_N, CC_Exp_date, CC_Brand, Active)
VALUES
(1, '9999888877775555', '2024-08-31', 'Master Card', '1'),
(2, '9876475600237731', '2025-10-31', 'American Express', '1'),
(3, '0101020203030404', '2021-01-31', 'Dankort', '0'),
(6, '3333777755551111', '2023-01-31', 'Visa', '1');

# The code below inserts the areas data with name and description.
INSERT INTO Areas
VALUES
(1, 'Graphical Design', 'Creative, (Graphic Design, Video Editing, etc.)'),
(2, 'Programming', 'Development, (Web, App, Mobile)'),
(3, 'Social Media', 'Digital Marketing, (Social Media, SEO, Analytics, etc.)'),
(4, 'Soft Skills', ''),
(5, 'Business Skills', '');


INSERT INTO Levels (Level_Name)
VALUES
('Beginner'),
('Intermediate'),
('Advanced');


INSERT INTO Courses (DateofCreation, Course_Name, Area_id, Level_id)
VALUES
('2015-01-01', 'Complete Wordpress Course for Beginners - Create 
websites without any coding', 2, 1),
('2015-01-01', 'Essential Python Course for Beginners - Learn 
Python with Easy Projects', 2, 1),
('2015-01-01', 'Essential Java Course for Beginners - Learn Java 
with Easy Tasks', 2, 1),
('2015-01-01', 'Build a Web App with Django', 2, 2),
('2015-01-01', 'Complete Guide to Facebook Ads Manager', 3, 1),
('2015-01-01', 'Complete SEO for Beginners - Learn how to rank 
websites on search engines', 3, 1),
('2015-01-01', 'Intro to Copywriting', 3, 1),
('2015-01-01', 'Photoshop Essentials - Learn how to create 
professional designs', 1, 1),
('2015-01-01', 'Build Your Resume with Photoshop', 1, 2),
('2015-01-01', 'Learn how to Animate a Logo', 1, 2),
('2019-01-01', 'Complete Freelancing Course - Learn how to work 
from home', 4, 2),
('2020-01-01', 'Crash Course: Effective Business Communication',
 4, 1),
('2021-03-13', 'Master the techniques of Negotiation', 5, 1)
;

# Below we insert the name of the Quiz names, leaving out the id because its
# auto_increment.
INSERT INTO Quizzes (Q_Name, Description, Course_id)
VALUES
('Area of Interest Quiz', 'This questionnarie will brighten up which path to follow. With questions relevant for 
each area, it is possible to know which courses to offer the user.', NULL),
('Negotiation Skills test', 'Master the techniques of Negotiation', 13),
('Quiz Test #3', '', NULL);

# Inserting questions into the questions database.
INSERT INTO Questions (Question, Subquestion, Area_id)
VALUES
('Do you appreciate design in relation to products?', 'E.g. Does a shoe have to be functional or good looking?', 1),
('Do you have a favourite artist when it comes to visual art?', 'Could be a painter, performance artist etc.', 1),
('Do you enjoy making visual presentations for school or business?', 'Do you feel at home with Powerpoint or Keynote?', 1),
('Have you tried editing video on your mobile device or PC?', 'Maybe editing an insta story or a video editing', 1),
('Do you like to take online intelligence tests?', 'E.g. Are you interested in developing your analytical skills?', 2),
('Do you find numbers and logic is preferred over philosophical questions?', 'E.g. Did you like Math in school?', 2),
('Are you interested in coding and learning to either understand or code yourself?', 'Have you tried learning code at some point?', 2),
('Have you tried building a website with a CMS like wordpress or Wix?', 'Do you feel the options are limited and would more flexibility', 2),
('Are you very active on Social Media?', 'Do you have more than 2 SoMe platforms that you actively use?', 3),
('Do you care about who likes and comments on your posts?', 'Do you create stories on Instagram and track their performance?', 3),
('Do you find that Social Media influences your buying decisions?', 'Have you bought something via Instagram or Facebook pages?', 3),
('Do you believe that Social Media is more effective than traditional marketing?', 'Are there SoMe influencers you would trust in recommending products to you?', 3),
('Before entering into a serious negotiation, what should you do?', '', 5),
("Which of these will NOT help you to establish rapport with your opponent?", '', 5);


INSERT INTO Question_Options 
VALUES
(1, 0, "NO", 0), (1, 1, "YES", 1),
(2, 0, "NO", 0), (2, 1, "YES", 1),
(3, 0, "NO", 0), (3, 1, "YES", 1),
(4, 0, "NO", 0), (4, 1, "YES", 1),
(5, 0, "NO", 0), (5, 1, "YES", 1),
(6, 0, "NO", 0), (6, 1, "YES", 1),
(7, 0, "NO", 0), (7, 1, "YES", 1),
(8, 0, "NO", 0), (8, 1, "YES", 1),
(9, 0, "NO", 0), (9, 1, "YES", 1),
(10, 0, "NO", 0), (10, 1, "YES", 1),
(11, 0, "NO", 0), (11, 1, "YES", 1),
(12, 0, "NO", 0), (12, 1, "YES", 1),
(13, 1, "Go to the library and read up about negotiating", 0),
(13, 2, "Research the other person to find out their needs, strengths and weaknesses", 1),
(13, 3, "Nothing - everything can be done on the day", 0),
(13, 4, "Have a big meal and get a good night's sleep", 0),
(14, 1, "Only talk about your own interests", 1),
(14, 2, "Be friendly and empathetic", 0),
(14, 3, "Listen well", 0),
(14, 4, "Smile and use positive body language", 0);


# Inserting answers for each user, question and quiz. Date is omited because it
# is a timestamp type. It enters the date and time at the insertion.
INSERT INTO Q_Answers (User_id, Quiz_id, Question_id, Option_id)
VALUES
(1, 1, 1, 0), (1, 1, 2, 1), (1, 1, 3, 0), (1, 1, 4, 0),
(1, 1, 5, 1), (1, 1, 6, 1), (1, 1, 7, 0), (1, 1, 8, 1),
(1, 1, 9, 0), (1, 1, 10, 0), (1, 1, 11, 1), (1, 1, 12, 0),
(2, 1, 1, 0), (2, 1, 2, 1), (2, 1, 3, 0), (2, 1, 4, 0),
(2, 1, 5, 0), (2, 1, 6, 1), (2, 1, 7, 1), (2, 1, 8, 0),
(2, 1, 9, 1), (2, 1, 10, 1), (2, 1, 11, 1), (2, 1, 12, 1),
(6, 1, 1, 1), (6, 1, 2, 1), (6, 1, 3, 1), (6, 1, 4, 1),
(6, 1, 5, 1), (6, 1, 6, 1), (6, 1, 7, 1), (6, 1, 8, 1),
(6, 1, 9, 1), (6, 1, 10, 1), (6, 1, 11, 1), (6, 1, 12, 1),
(8, 1, 1, 0), (8, 1, 2, 0), (8, 1, 3, 1), (8, 1, 4, 1),
(8, 1, 5, 1), (8, 1, 6, 1), (8, 1, 7, 1), (8, 1, 8, 1),
(8, 1, 9, 1), (8, 1, 10, 1), (8, 1, 11, 0), (8, 1, 12, 0),
(9, 1, 1, 0), (9, 1, 2, 0), (9, 1, 3, 1), (9, 1, 4, 1),
(9, 1, 5, 0), (9, 1, 6, 0), (9, 1, 7, 0), (9, 1, 8, 1),
(9, 1, 9, 1), (9, 1, 10, 1), (9, 1, 11, 1), (9, 1, 12, 0),
(10, 1, 1, 1), (10, 1, 2, 1), (10, 1, 3, 1), (10, 1, 4, 1),
(10, 1, 5, 0), (10, 1, 6, 1), (10, 1, 7, 1), (10, 1, 8, 1),
(10, 1, 9, 1), (10, 1, 10, 1), (10, 1, 11, 1), (10, 1, 12, 0),
(2, 3, 1, 1), (2, 3, 5, 0), (2, 3, 9, 1);

# Below we insert a new quiz taken by the user 1. It differs from the first
# because it has a different Date.
INSERT INTO Q_Answers (Date, User_id, Quiz_id, Question_id, Option_id)
VALUES
('2021-02-28', 1, 1, 1, 1), ('2021-02-28', 1, 1, 2, 1), ('2021-02-28', 1, 1, 3, 1), ('2021-02-28', 1, 1, 4, 0),
('2021-02-28', 1, 1, 5, 1), ('2021-02-28', 1, 1, 6, 1), ('2021-02-28', 1, 1, 7, 0), ('2021-02-28', 1, 1, 8, 1),
('2021-02-28', 1, 1, 9, 0), ('2021-02-28', 1, 1, 10, 0), ('2021-02-28', 1, 1, 11, 1), ('2021-02-28', 1, 1, 12, 0),
('2021-03-13', 6, 2, 13, 2), ('2021-03-13', 6, 2, 14, 4),
('2021-02-10', 8, 3, 1, 0), ('2021-02-10', 8, 3, 5, 1), ('2021-02-10', 8, 3, 9, 0);

# Below we insert which questions belongs to which quiz and for different
# quizzes, the points can be changed. therefore this relationship includes the
# points.
INSERT INTO Quiz_Questions
VALUES
(1, 1, 5),
(1, 2, 5),
(1, 3, 5),
(1, 4, 5),
(1, 5, 5),
(1, 6, 5),
(1, 7, 5),
(1, 8, 5),
(1, 9, 5),
(1, 10, 5),
(1, 11, 5),
(1, 12, 5),
(2, 13, 15),
(2, 14, 15),
(3, 1, 10),
(3, 5, 10),
(3, 9, 10);


INSERT INTO Enrollments (Enr_Date, User_id, Course_id)
VALUES
('2021-01-10', 1, 2),
('2021-01-15', 1, 4),
('2020-12-20', 6, 8),
('2021-02-27', 6, 13);