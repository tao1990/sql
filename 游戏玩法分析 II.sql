+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| player_id    | int     |
| device_id    | int     |
| event_date   | date    |
| games_played | int     |
+--------------+---------+
表的主键是 (player_id, event_date)。
这张表展示了一些游戏玩家在游戏平台上的行为活动。
每行数据记录了一名玩家在退出平台之前，当天使用同一台设备登录平台后打开的游戏的数目（可能是 0 个）。


写一条 SQL 查询语句获取每位玩家 第一次登陆平台的日期。

查询结果的格式如下所示：

Activity 表：
+-----------+-----------+------------+--------------+
| player_id | device_id | event_date | games_played |
+-----------+-----------+------------+--------------+
| 1         | 2         | 2016-03-01 | 5            |
| 1         | 2         | 2016-05-02 | 6            |
| 2         | 3         | 2017-06-25 | 1            |
| 3         | 1         | 2016-03-02 | 0            |
| 3         | 4         | 2018-07-03 | 5            |
+-----------+-----------+------------+--------------+

Result 表：
+-----------+-------------+
| player_id | first_login |
+-----------+-------------+
| 1         | 2016-03-01  |
| 2         | 2017-06-25  |
| 3         | 2016-03-02  |
+-----------+-------------+

===============================================================================================

CREATE TABLE IF NOT EXISTS Activity (player_id INT, device_id INT, event_date DATE, games_played INT)
TRUNCATE TABLE Activity
INSERT INTO Activity (player_id, device_id, event_date, games_played) VALUES ('1', '2', '2016-03-01', '5')
INSERT INTO Activity (player_id, device_id, event_date, games_played) VALUES ('1', '2', '2016-05-02', '6')
INSERT INTO Activity (player_id, device_id, event_date, games_played) VALUES ('2', '3', '2017-06-25', '1')
INSERT INTO Activity (player_id, device_id, event_date, games_played) VALUES ('3', '1', '2016-03-02', '0')
INSERT INTO Activity (player_id, device_id, event_date, games_played) VALUES ('3', '4', '2018-07-03', '5')
INSERT INTO Activity (player_id, device_id, event_date, games_played) VALUES ('4', '5', '2018-07-04', '4')
INSERT INTO Activity (player_id, device_id, event_date, games_played) VALUES ('4', '6', '2018-07-03', '3')

===============================================================================================

首先使用min函数和group by找到所有玩家初次在平台使用设备玩游戏的时间（类似上一题）
select player_id,min(event_date) as first_login from Activity group by player_id
将步骤1的结果作为子查询，外层再套用一层，查找player_id和device_id即可
select a.player_id ,a.device_id from Activity a where (a.player_id ,a.event_date) in 
(select player_id,min(event_date) as first_login from Activity group by player_id)


===============================================================================================
备注：
select player_id ,device_id from ( select player_id,device_id,min(event_date) from Activity group by player_id ) s
不能用以上子查询（因为以player_id分组后，由于没有对device_id进行操作，sql会默认取同组Id的第一条数据）
