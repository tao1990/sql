产品数据表: Products

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| new_price     | int     |
| change_date   | date    |
+---------------+---------+
这张表的主键是 (product_id, change_date)。
这张表的每一行分别记录了 某产品 在某个日期 更改后 的新价格。
 

写一段 SQL来查找在 2019-08-16 时全部产品的价格，假设所有产品在修改前的价格都是 10。

查询结果格式如下例所示：

Products table:
+------------+-----------+-------------+
| product_id | new_price | change_date |
+------------+-----------+-------------+
| 1          | 20        | 2019-08-14  |
| 2          | 50        | 2019-08-14  |
| 1          | 30        | 2019-08-15  |
| 1          | 35        | 2019-08-16  |
| 2          | 65        | 2019-08-17  |
| 3          | 20        | 2019-08-18  |
+------------+-----------+-------------+

Result table:
+------------+-------+
| product_id | price |
+------------+-------+
| 2          | 50    |
| 1          | 35    |
| 3          | 10    |
+------------+-------+


===============================================================================================
Create table If Not Exists Products (product_id int, new_price int, change_date date)
Truncate table Products
insert into Products (product_id, new_price, change_date) values ('1', '20', '2019-08-14')
insert into Products (product_id, new_price, change_date) values ('2', '50', '2019-08-14')
insert into Products (product_id, new_price, change_date) values ('1', '30', '2019-08-15')
insert into Products (product_id, new_price, change_date) values ('1', '35', '2019-08-16')
insert into Products (product_id, new_price, change_date) values ('2', '65', '2019-08-17')
insert into Products (product_id, new_price, change_date) values ('3', '20', '2019-08-18')

===============================================================================================


SELECT DISTINCT a.product_id,IFNULL(b.new_price ,10) AS price FROM Products a 
LEFT JOIN (
	SELECT product_id, new_price 
	FROM products
	WHERE (product_id, change_date) IN (
	    SELECT product_id, MAX(change_date)
	    FROM products
	    WHERE change_date <= '2019-08-16'
	    GROUP BY product_id
	)
) b ON a.product_id = b.product_id


