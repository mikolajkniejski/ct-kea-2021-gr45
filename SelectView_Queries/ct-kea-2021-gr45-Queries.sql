# (01) Below we generate a list of the questions from a specific Quiz 
# in a specific order chosen by the group members.
# Useful when showing the quiz to the user/visitor.
# To change the Quiz, change the Quiz_id after "WHERE".
SELECT q.Question_id, q.Question, q.Subquestion, a.Area_Name, qq.Points
FROM CTdb.Quiz_Questions qq
JOIN CTdb.Questions q ON q.Question_id = qq.Question_id
JOIN CTdb.Areas a ON q.Area_id = a.Area_id
WHERE qq.Quiz_id = 1
ORDER BY FIND_IN_SET(q.Question_id, '9,1,5,6,10,2,3,7,11,12,8,4');


# (02) Query below extracts the answers to each question of each Quiz
# ordered in sequence by User_id, Quiz_id and Question_id.
# (points can be different for the same question when on a different quiz)
SELECT a.Date, a.User_id, qn.Q_Name, a.Question_id, ar.Area_Name, 
qq.Points, q.Question, qo.Option_desc AS 'Chosen Answer', qq.Points, qo.Grants_Points 
FROM CTdb.Q_Answers a 
JOIN CTdb.Questions q ON a.Question_id = q.Question_id
JOIN CTdb.Areas ar ON q.Area_id = ar.Area_id
JOIN CTdb.Quizzes qz ON a.Quiz_id = qz.Quiz_id
JOIN CTdb.Question_Options qo ON (a.Question_id = qo.Question_id AND a.Option_id = qo.Option_id)
JOIN CTdb.Quiz_Questions qq ON (a.Quiz_id = qq.Quiz_id) AND (a.Question_id = qq.Question_id)
JOIN CTdb.Quizzes qn ON qq.Quiz_id = qn.Quiz_id
ORDER BY a.User_id, a.Date, qz.Quiz_id, a.Question_id;


# (03) Query below shows users enrolled in available courses.
SELECT e.Enr_id, e.Enr_Date, u.User_id, u.First_Name, u.Last_Name, c.Course_Name,
a.Area_Name AS Area, l.Level_Name AS Level
FROM Enrollments e
JOIN Users u ON e.User_id = u.User_id
JOIN Courses c ON e.Course_id = c.Course_id
JOIN Levels l ON c.Level_id = l.Level_id
JOIN Areas a ON c.Area_id = a.Area_id;


# (04) The query below displays a list of courses with beginner level.
SELECT c.Course_id, c.DateofCreation, c.Course_Name, a.Area_Name, l.Level_Name 
FROM Courses c
JOIN Areas a on c.Area_id = a.Area_id
JOIN Levels l on c.Level_id = l.Level_id
WHERE c.Level_id = 1;


# (05-A) Query below creates or replaces a view of a table showing Points of the users for each area
# for Quiz_id = 1. Altering data in this query will affect queries below that
# uses the generated table for simplicity purposes. (Alter after WHERE)
CREATE OR REPLACE VIEW Points_User_Date_Area AS
SELECT u.User_id AS User_id, a.Date, qz.Q_Name AS Quiz, CONCAT(u.First_Name, ' ', u.Last_Name) AS Name, c.Course_Name, ar.Area_Name AS Area, SUM(qo.Grants_Points*qq.Points) AS Points
	FROM CTdb.Q_Answers a 
	JOIN CTdb.Questions q ON q.Question_id = a.Question_id 
    JOIN CTdb.Areas ar ON q.Area_id = ar.Area_id
	JOIN CTdb.Users u ON u.User_id = a.User_id 
    JOIN CTdb.Quizzes qz ON qz.Quiz_id = a.Quiz_id
    JOIN CTdb.Question_Options qo ON (a.Question_id = qo.Question_id AND a.Option_id = qo.Option_id)
    LEFT JOIN CTdb.Courses c ON c.Course_id = qz.Course_id
    JOIN CTdb.Quiz_Questions qq ON (a.Quiz_id = qq.Quiz_id) AND (a.Question_id = qq.Question_id)
    WHERE (qz.Quiz_id = 1)
	GROUP BY qz.Quiz_id, ar.Area_Name, u.User_id, a.Date
	ORDER BY a.Date, u.User_id;
# (05-B) Query below shows the view above.
SELECT * FROM CTdb.Points_User_Date_Area;


# (06-A) Query below creates or replaces a view of a table showing Total points made by each user
# and date for the Quiz_id=1 (this spec needs to be the same as Query 05-B.
CREATE OR REPLACE VIEW TotalPoints_User_Date AS
SELECT u.User_id AS User_id, a.Date, qz.Q_Name AS Quiz, SUM(qo.Grants_Points*qq.Points) AS Total_Points
	FROM CTdb.Q_Answers a 
	JOIN CTdb.Questions q ON q.Question_id = a.Question_id 
	JOIN CTdb.Users u ON u.User_id = a.User_id
    JOIN CTdb.Quizzes qz ON qz.Quiz_id = a.Quiz_id
    JOIN CTdb.Question_Options qo ON (a.Question_id = qo.Question_id AND a.Option_id = qo.Option_id)
    JOIN CTdb.Quiz_Questions qq ON (a.Quiz_id = qq.Quiz_id) AND (a.Question_id = qq.Question_id)
    WHERE (qz.Quiz_id = 1)
	GROUP BY qz.Quiz_id, u.User_id, a.Date
	ORDER BY u.User_id, a.Date;
# (06-B) Query below shows the view above in the result grid.
SELECT * FROM CTdb.TotalPoints_User_Date;


# (07-A) Query below generates or replaces a table with points per area for the users together 
# with percentage for a specific Quiz (chosen in queries 06 and 08).
CREATE OR REPLACE VIEW Percentage_User_Area_Date AS
SELECT t1.*, t2.Total_Points, CAST((t1.Points/t2.Total_Points)*100 AS DECIMAL(5,2)) AS Percentage 
FROM 
    CTdb.Points_User_Date_Area t1
LEFT JOIN
    CTdb.TotalPoints_User_Date t2  
ON (t1.User_id = t2.User_id AND t1.Date = t2.Date);
# (07-B) Query below shows the view above in the result grid.
SELECT * FROM CTdb.Percentage_User_Area_Date;


# (08) Query below generates a transposed table with the percentage values 
# for each area as new columns for each user for a specific Quiz
# (chosen in queries 05 and 06).
SELECT User_id, Date, Name,
sum(IF(Area='Graphical Design', Percentage, NULL)) AS 'Graphical Design',
sum(IF(Area='Programming', Percentage, NULL)) AS Programmin,
sum(IF(Area='Social Media', Percentage, NULL)) AS 'Social Media'
FROM (SELECT t1.*, t2.Total_Points, CAST((t1.Points/t2.Total_Points)*100 AS DECIMAL(5,2)) AS Percentage 
FROM 
    CTdb.Points_User_Date_Area t1
LEFT JOIN
    CTdb.TotalPoints_User_Date t2  
ON (t1.User_id = t2.User_id AND t1.Date = t2.Date)) t3 GROUP BY User_id, Date;
    

# (09-A) Below is the query to extract wich area each user is more attracted to
# for a specific Quiz (chosen in queries 06 and 08) including duplicate 
# values (like the one for user of Name Anne Mette).
CREATE OR REPLACE VIEW ListofTests_by_AreaofInterest AS 
SELECT * FROM 
CTdb.Percentage_User_Area_Date t1 
WHERE (User_id, Date, Percentage) IN 
 (Select User_id, Date, MAX(Percentage) FROM 
	CTdb.Percentage_User_Area_Date t2
	GROUP BY User_id, Date);
# (09-B) Show the view above.
SELECT * FROM CTdb.ListofTests_by_AreaofInterest;


# (10) Query below extracts a table with the list of users that participated
# in a specific Quiz.
SELECT DISTINCT u.User_id, a.Date,
CONCAT(u.First_Name, ' ', u.Last_Name) AS Name
FROM CTdb.Users u
JOIN CTdb.Q_Answers a ON u.User_id = a.User_id
WHERE a.Quiz_id = 1;


# (11) Query below extract statistics on how many user took which Quiz.
SELECT DISTINCT t1.Quiz_id, qz.Q_Name AS Quiz_Name, c.Course_Name, 
COUNT(t1.Quiz_id) AS 'N of Participants'
FROM
(SELECT a.Quiz_id FROM Q_Answers a GROUP BY Quiz_id, User_id) t1
JOIN Quizzes qz ON t1.Quiz_id = qz.Quiz_id
LEFT JOIN Courses c ON qz.Course_id = c.Course_id
GROUP BY Quiz_id;


# (12) Query below extracts a table with a list of users who are active
# i.e., are paying customers.
SELECT u.*, p.Active FROM CTdb.PaymentInfo p
JOIN CTdb.Users u ON p.User_id = u.User_id
WHERE p.Active = 1;


# (13) Query below extracts a table with a list of users with address who are member.
SELECT u.*, p.Active, 
CONCAT(ad.Street, ' ', ad.City, ' ', ad.State, '-', ad.Zip_code, ' ', ad.Country) AS Address
FROM CTdb.PaymentInfo p
RIGHT JOIN CTdb.Users u ON p.User_id = u.User_id
LEFT JOIN CTdb.Addresses ad ON u.User_id = ad.User_id
WHERE u.Member = 1;


# (14) Query below extracts a table with a list of users who are not member.
# i.e., anonymous visitors/users.
SELECT u.*, p.Active FROM CTdb.PaymentInfo p
RIGHT JOIN CTdb.Users u ON p.User_id = u.User_id
WHERE u.Member = 0;


# (15) Query below shows a list of users(excluding anonymous) from quiz id 1 who have 
# interest in the Programming Area !!
SELECT DISTINCT User_id, Name FROM CTdb.ListofTests_by_AreaofInterest
    WHERE (Area = 'Programming' AND Name IS NOT NULL);
    

# (16) Query below shows a list of users(including anonymous) from quiz id 1 who have 
# interest in the Social Media Area !!
SELECT DISTINCT User_id, Name FROM CTdb.ListofTests_by_AreaofInterest
    WHERE (Area = 'Social Media');


# (17-A) Query below deletes a User from the database. Note that 
# because the entities Payment, Address, Enrollments and Q_Answers have a specification
# on the foreign key User_id DELETE ON CASCADE, it will also delete the 
# rows belonging to the specific user id on those tables.
DELETE FROM CTdb.Users 
WHERE User_id = 2;
# (17-B) Check in the query below that its info on address was also dropped.
SELECT * FROM CTdb.Addresses;
# (17-C) As well from the Q_Answers table.
SELECT * FROM Q_Answers;
# (17-D) Also from the Payment. (No more user_id = 2)
SELECT * FROM PaymentInfo;
# (17-E) Again, also from enrollments;
SELECT * FROM Enrollments;