# 1.Query the existence of 1 course
select * 
from course 
where id = 1
# 2.Query the presence of both 1 and 2 courses
select * 
from course 
where id = 1 or id = 2
# 3.Query the student number and student name and average score of students whose average score is 60 or higher.
SELECT * FROM(
	SELECT student.id, student.NAME, AVG( student_course.score ) average 
	FROM student, student_course 
	WHERE student.id = student_course.studentId 
	GROUP BY student.id 
) ssc
WHERE average >= 60
# 4.Query the SQL statement of student information that does not have grades in the student_course table
select * 
from student
where id not in (
	select distinct studentId 
	from student_course
)
# 5.Query all SQL with grades
select s.id, s.name, c.name, sc.score 
from student s, course c, student_course sc
where s.id = sc.studentId
and c.id = sc.courseId
# 6.Inquire about the information of classmates who have numbered 1 and also studied the course numbered 2
select *
from student
where id = 1
and id in (
	select id
	from student s, student_course sc
	where s.id = sc.studentId
	and sc.courseId = 2
)
# 7.Retrieve 1 student score with less than 60 scores in descending order
select *
from student_course sc
where score < 60
order by score desc
# 8.Query the average grade of each course. The results are ranked in descending order of average grade. When the average grades are the same, they are sorted in ascending order by course number.
select c.name, cas.average
from course c, (
	select courseId, AVG(score) average
	from student_course
	GROUP BY courseId
	order by average desc, courseId
) cas
where c.id = cas.courseId
# 9.Query the name and score of a student whose course name is "Math" and whose score is less than 60
select s.id, s.name, scMath.score
from student s, (
	select studentId id, score
	from student_course sc, course c
	where sc.courseId = c.id
	and sc.score < 60
	and c.name = 'Math'
) scMath
where s.id = scMath.id

