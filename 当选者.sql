表: Candidate

+-----+---------+
| id  | Name    |
+-----+---------+
| 1   | A       |
| 2   | B       |
| 3   | C       |
| 4   | D       |
| 5   | E       |
+-----+---------+  
表: Vote

+-----+--------------+
| id  | CandidateId  |
+-----+--------------+
| 1   |     2        |
| 2   |     4        |
| 3   |     3        |
| 4   |     2        |
| 5   |     5        |
+-----+--------------+
id 是自动递增的主键，
CandidateId 是 Candidate 表中的 id.
请编写 sql 语句来找到当选者的名字，上面的例子将返回当选者 B.

+------+
| Name |
+------+
| B    |
+------+


===============================================================================================

Create table If Not Exists Candidate (id int, Name varchar(255))
Create table If Not Exists Vote (id int, CandidateId int)
Truncate table Candidate
insert into Candidate (id, Name) values ('1', 'A')
insert into Candidate (id, Name) values ('2', 'B')
insert into Candidate (id, Name) values ('3', 'C')
insert into Candidate (id, Name) values ('4', 'D')
insert into Candidate (id, Name) values ('5', 'E')
Truncate table Vote
insert into Vote (id, CandidateId) values ('1', '2')
insert into Vote (id, CandidateId) values ('2', '4')
insert into Vote (id, CandidateId) values ('3', '3')
insert into Vote (id, CandidateId) values ('4', '2')
insert into Vote (id, CandidateId) values ('5', '5')

===============================================================================================

SELECT NAME FROM Candidate 
WHERE id = (SELECT CandidateId FROM Vote GROUP BY CandidateId HAVING COUNT(CandidateId)>1 ORDER BY COUNT(id) DESC LIMIT 1 )



