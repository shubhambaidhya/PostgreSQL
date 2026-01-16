-- Table: Person 
-- +-------------+---------+ 
-- | Column Name | Type    | 
-- +-------------+---------+ 
-- | PersonId    | int     | 
-- | FirstName   | varchar | 
-- | LastName    | varchar | 
-- +-------------+---------+ 
-- PersonId is the primary key column for this table.

-- Table: Address 
-- +-------------+---------+ 
-- | Column Name | Type    | 
-- +-------------+---------+ 
-- | AddressId   | int     | 
-- | PersonId    | int     | 
-- | City        | varchar | 
-- | State       | varchar | 
-- +-------------+---------+ 
-- AddressId is the primary key column for this table.

-- Write a SQL query for a report that provides the following information for each person in the Person table,
-- regardless if there is an address for each of those people:
-- FirstName, LastName, City, State.

create table Person (
	PersonId serial not null primary key, 
	FirstName varchar(50),
	LastName varchar(50)
);

insert into Person (FirstName, LastName) 
values 
  ('Sita', 'Shrestha'), 
  ('Ram', 'Thapa'), 
  ('Aarav', 'Gurung'), 
  ('Pratiksha', 'Rai');
insert into Person (FirstName, LastName) 
values 
  ('Siddhant', 'Shrestha')


create table Address (
	AddressId serial not null primary key,
	PersonId int,
	City varchar(30),
	State varchar(30),
	foreign key (PersonId)
        references Person(PersonId)
        on delete cascade
)

insert into Address (AddressId, PersonId, City, State) 
values 
  (101, 1, 'Kathmandu', 'Bagmati'), 
  (102, 2, 'Pokhara', 'Gandaki'), 
  (103, 3, 'Butwal', 'Lumbini'), 
  (104, 4, 'Biratnagar', 'Koshi');


select 
  p.FirstName, 
  p.LastName, 
  a.City, 
  a.State 
from 
  Person p 
  left join address a on p.PersonId = a.PersonId;




-- Write a SQL query to get the second highest salary from the Employee table. 
-- 
-- +----+--------+ 
-- | Id | Salary | 
-- +----+--------+ 
-- | 1  | 100    | 
-- | 2  | 200    | 
-- | 3  | 300    | 
-- +----+--------+ 
-- 
-- For example, given the above Employee table, the query should return 200 as the second highest salary.
-- If there is no second highest salary, then the query should return null.
-- 
-- +---------------------+ 
-- | SecondHighestSalary | 
-- +---------------------+ 
-- | 200                 | 
-- +---------------------+
 
create table Employee (
  Id serial not null primary key,
  Salary int
);

insert into Employee (Salary) 
values 
  (100), 
  (200), 
  (300);

with cte as (
  select 
    distinct salary, 
    dense_rank() over (
      order by 
        Salary desc
    ) as rank 
  from 
    Employee
) 
select 
  Salary as SecondHighestSalary 
from 
  cte 
where 
  rank = 2;


-- Write a SQL query to get the nth highest salary from the Employee table. 
-- 
-- +----+--------+ 
-- | Id | Salary | 
-- +----+--------+ 
-- | 1  | 100    | 
-- | 2  | 200    | 
-- | 3  | 300    | 
-- +----+--------+ 
-- 
-- For example, given the above Employee table, the nth highest salary where n = 2 is 200. 
-- If there is no nth highest salary, then the query should return null.
-- 
-- +------------------------+ 
-- | getNthHighestSalary(2) | 
-- +------------------------+ 
-- | 200                    | 
-- +------------------------+


with cte as (
  select 
    distinct salary, 
    dense_rank() over (
      order by 
        Salary desc
    ) as rank
) 
from 
  Employee
) 
select 
  Salary as NthHighestSalary 
from 
  cte 
where 
  rank = n;
-- we can put n = 2 or n=3 to find the nth highest salary i.e 2nd or 3rd highest.


-- Write a SQL query to rank scores. If there is a tie between two scores, both should have the same ranking. 
-- Note that after a tie, the next ranking number should be the next consecutive integer value. 
-- In other words, there should be no "holes" between ranks.
-- 
-- +----+-------+ 
-- | Id | Score | 
-- +----+-------+ 
-- | 1  | 3.50  | 
-- | 2  | 3.65  | 
-- | 3  | 4.00  | 
-- | 4  | 3.85  | 
-- | 5  | 4.00  | 
-- | 6  | 3.65  | 
-- +----+-------+ 
-- 
-- For example, given the above Scores table, your query should generate the following report (ordered by highest score): 
-- 
-- +-------+------+ 
-- | Score | Rank | 
-- +-------+------+ 
-- | 4.00  | 1    | 
-- | 4.00  | 1    | 
-- | 3.85  | 2    | 
-- | 3.65  | 3    | 
-- | 3.65  | 3    | 
-- | 3.50  | 4    | 
-- +-------+------+


create table Scores(
	Id serial not null primary key,
	Score float 
)

insert into Scores (Score) 
values 
  (3.50), 
  (3.65), 
  (4.00), 
  (3.85),  
  (4.00), 
  (3.65);

 with 
 	cte as (
  select 
    Score, 
    dense_rank() over (
      order by Score desc
    ) as rnk
  from Scores
) 
SELECT * 
FROM cte;



-- Write a SQL query to find all numbers that appear at least three times consecutively.
-- 
-- +----+-----+ 
-- | Id | Num | 
-- +----+-----+ 
-- |  1 |  1  | 
-- |  2 |  1  | 
-- |  3 |  1  | 
-- |  4 |  2  | 
-- |  5 |  1  | 
-- |  6 |  2  | 
-- |  7 |  2  | 
-- +----+-----+
-- 
-- For example, given the above Logs table, 1 is the only number that appears consecutively for at least three times.
-- 
-- +-----------------+ 
-- | ConsecutiveNums | 
-- +-----------------+ 
-- |        1        | 
-- +-----------------+


create table Logs(
	Id int,
	Num int
)

insert into Logs(Id, Num) 
values 
  (1, 1), 
  (2, 1), 
  (3, 1), 
  (4, 2), 
  (5, 1), 
  (6, 2), 
  (7, 2);

with cte as (
	select 
		Num,	
		lead(Num,1) over (order by Id) as next_num,
		lead(Num,2) over (order by Id) as next2_num
	from Logs
) 
select distinct Num as Consecutive_Num
from cte 
where Num = next_num and Num = next2_num;


-- The Employee table holds all employees including their managers. 
-- Every employee has an Id, and there is also a column for the manager Id.
-- 
-- +----+--------+--------+-----------+ 
-- | Id | Name   | Salary | ManagerId | 
-- +----+--------+--------+-----------+ 
-- |  1 | Joe    | 70000  |     3     | 
-- |  2 | Henry  | 80000  |     4     | 
-- |  3 | Sam    | 60000  |   NULL    | 
-- |  4 | Max    | 90000  |   NULL    | 
-- +----+--------+--------+-----------+ 
-- 
-- Given the Employee table, write a SQL query that finds out employees who earn more than their managers. 
-- 
-- For the above table, Joe is the only employee who earns more than his manager.
-- 
-- +----------+ 
-- | Employee | 
-- +----------+ 
-- |   Joe    | 
-- +----------+


create table Employees (
    Id INTEGER PRIMARY KEY,
    Name VARCHAR(50),
    Salary INTEGER,
    ManagerId INTEGER
);

INSERT INTO Employees (Id, Name, Salary, ManagerId) VALUES
(1, 'Joe', 70000, 3),
(2, 'Henry', 80000, 4),
(3, 'Sam', 60000, NULL),
(4, 'Max', 90000, NULL);



with cte as(
  select 
    e.Name as Employee, 
    e.salary as Employee_Salary, 
    m.Name as Manager, 
    m.Salary as Manager_Salary 
  from 
    Employees e 
    join Employees m on e.ManagerId = m.Id
) 
select 
  Employee 
from 
  cte 
where 
  Employee_Salary > Manager_Salary;

 

-- Write a SQL query to find all duplicate emails in a table named Person.
-- 
-- +----+----------+ 
-- | Id | Email    | 
-- +----+----------+ 
-- |  1 | a@b.com  | 
-- |  2 | c@d.com  | 
-- |  3 | a@b.com  | 
-- +----+----------+
-- 
-- For example, your query should return the following for the above table:
-- 
-- +----------+ 
-- | Email    | 
-- +----------+ 
-- | a@b.com  | 
-- +----------+
-- 
-- Note: All emails are in lowercase.


create table Person1 (
	Id int,
	Email varchar
);

insert into Person1 (Id, Email) 
values 
  (1, 'a@b.com'), 
  (2, 'c@d.com'), 
  (3, 'a@b.com');


with cte as (
  select 
    Email 
  from 
    Person1 
  group by 
    email 
  having 
    count(1)> 1
) 
select 
  distinct Email 
from 
  Person1 
where 
  Email in (
    select 
      Email 
    from 
      cte
  );



-- Suppose that a website contains two tables, the Customers table and the Orders table. 
-- Write a SQL query to find all customers who never order anything.
--
-- Table: Customers
-- +----+-------+ 
-- | Id | Name  | 
-- +----+-------+ 
-- | 1  | Joe   | 
-- | 2  | Henry | 
-- | 3  | Sam   | 
-- | 4  | Max   | 
-- +----+-------+ 
--
-- Table: Orders
-- +----+------------+ 
-- | Id | CustomerId | 
-- +----+------------+ 
-- | 1  | 3          | 
-- | 2  | 1          | 
-- +----+------------+ 
--
-- Using the above tables as example, return the following:
--
-- +-----------+ 
-- | Customers | 
-- +-----------+ 
-- | Henry     | 
-- | Max       | 
-- +-----------+

CREATE TABLE Customers (
    Id INTEGER PRIMARY KEY,
    Name VARCHAR(50)
);
INSERT INTO Customers (Id, Name) VALUES
(1, 'Joe'),
(2, 'Henry'),
(3, 'Sam'),
(4, 'Max');


CREATE TABLE Orders (
    Id SERIAL PRIMARY KEY,
    CustomerId INTEGER NOT NULL,
    FOREIGN KEY (CustomerId) REFERENCES Customers(Id)
);
INSERT INTO Orders (Id, CustomerId) VALUES
(1, 3),
(2, 1);

with cte as (
  select 
    CustomerId 
  from 
    Orders 
  group by 
    CustomerId
) 
select 
  Name 
from 
  Customers 
where 
  Id not in (
    select 
      CustomerId 
    from 
      cte
  )

  


-- Suppose that a website contains two tables, the Customers table and the Orders table. 
-- Write a SQL query to find all customers who never order anything. 
--
-- Table: Customers. 
-- +----+-------+ 
-- | Id | Name  | 
-- +----+-------+ 
-- | 1  | Joe   | 
-- | 2  | Henry | 
-- | 3  | Sam   | 
-- | 4  | Max   | 
-- +----+-------+ 
--
-- Table: Orders. 
-- +----+------------+ 
-- | Id | CustomerId | 
-- +----+------------+ 
-- | 1  | 3          | 
-- | 2  | 1          | 
-- +----+------------+ 
--
-- Using the above tables as example, return the following: 
--
-- +-----------+ 
-- | Customers | 
-- +-----------+ 
-- | Henry     | 
-- | Max       | 
-- +-----------+

CREATE TABLE Person (
    Id INT PRIMARY KEY,
    Email VARCHAR(255) NOT NULL
);

INSERT INTO Person (Id, Email) VALUES
(1, 'john@example.com'),
(2, 'bob@example.com'),
(3, 'john@example.com');

with cte as (
  select 
    Email, 
    Id, 
    row_number() over (
      partition by email 
      order by 
        Id
    ) as rn 
  from 
    Person
) 
delete from 
  Person 
where 
  Id in (
    select 
      Id 
    from 
      cte 
    where 
      rn > 1
  );



-- Write a SQL query to delete all duplicate email entries in a table named Person,
-- keeping only unique emails based on the smallest Id.
--
-- +----+------------------+ 
-- | Id | Email            | 
-- +----+------------------+ 
-- | 1  | john@example.com | 
-- | 2  | bob@example.com  | 
-- | 3  | john@example.com | 
-- +----+------------------+ 
--
-- Id is the primary key column for this table.
--
-- For example, after running your query, the above Person table should have the following rows:
--
-- +----+------------------+ 
-- | Id | Email            | 
-- +----+------------------+ 
-- | 1  | john@example.com | 
-- | 2  | bob@example.com  | 
-- +----+------------------+ 
--
-- Note: Your output is the whole Person table after executing your SQL. Use DELETE statement.


CREATE TABLE Weather (
    Id INT PRIMARY KEY,
    RecordDate DATE,
    Temperature INT
);

INSERT INTO Weather (Id, RecordDate, Temperature) VALUES
(1, '2015-01-01', 10),
(2, '2015-01-02', 25),
(3, '2015-01-03', 20),
(4, '2015-01-04', 30);

select * from Weather;

with cte as (
  select 
    Id, 
    RecordDate, 
    Temperature, 
    LAG(Temperature) over (
      order by 
        RecordDate
    ) as previous_temp 
  from 
    Weather
) 
select 
  Id 
from 
  cte 
where 
  Temperature > previous_temp

  

-- Given a Weather table, write a SQL query to find all dates' Ids with higher temperature compared to its previous (yesterday's) dates.
-- 
-- +---------+------------------+------------------+ 
-- | Id(INT) | RecordDate(DATE) | Temperature(INT) | 
-- +---------+------------------+------------------+ 
-- |    1    | 2015-01-01       |        10        | 
-- |    2    | 2015-01-02       |        25        | 
-- |    3    | 2015-01-03       |        20        | 
-- |    4    | 2015-01-04       |        30        | 
-- +---------+------------------+------------------+ 
-- 
-- For example, return the following Ids for the above Weather table: 
-- 
-- +----+ 
-- | Id | 
-- +----+ 
-- | 2  | 
-- | 4  | 
-- +----+


CREATE TABLE player_activity (
    player_id INT,
    device_id INT,
    event_date DATE,
    games_played INT
);

INSERT INTO player_activity (player_id, device_id, event_date, games_played) VALUES
(1, 2, '2016-03-01', 5),
(1, 2, '2016-05-02', 6),
(2, 3, '2017-06-25', 1),
(3, 1, '2016-03-02', 0),
(3, 4, '2018-07-03', 5);

select * from player_activity


with first_logins as (
    select 
        player_id, 
        event_date,
        row_number() over (partition by player_id order by event_date) as rn
    from player_activity
)
select 
    player_id, 
    event_date as first_login_date
from first_logins
where rn = 1;

--or Simple way

select 
  player_id, 
  min(event_date) as first_login 
from 
  player_activity 
group by 
  player_id 
order by 
  player_id;



-- Table: Activity
-- +-----------+-----------+------------+--------------+
-- | player_id | device_id | event_date | games_played |
-- +-----------+-----------+------------+--------------+
-- | 1         | 2         | 2016-03-01 | 5            |
-- | 1         | 2         | 2016-05-02 | 6            |
-- | 2         | 3         | 2017-06-25 | 1            |
-- | 3         | 1         | 2016-03-02 | 0            |
-- | 3         | 4         | 2018-07-03 | 5            |
-- +-----------+-----------+------------+--------------+
--
-- (player_id, event_date) is the primary key of this table.
-- This table shows the activity of players of some game.
-- Each row is a record of a player who logged in and played a number of games (possibly 0)
-- before logging out on some day using some device.
--
-- Write an SQL query that reports the first login date for each player.
--
-- Result table:
-- +-----------+-------------+
-- | player_id | first_login |
-- +-----------+-------------+
-- | 1         | 2016-03-01  |
-- | 2         | 2017-06-25  |
-- | 3         | 2016-03-02  |
-- +-----------+-------------+



with first_logins as (
    select 
        player_id, 
        device_id,
        event_date,
        row_number() over (partition by player_id order by event_date) as rn
    from player_activity
)
select 
    player_id, 
	device_id
from first_logins
where rn = 1;


-- Table: Activity
-- +-----------+-----------+------------+--------------+
-- | player_id | device_id | event_date | games_played |
-- +-----------+-----------+------------+--------------+
-- | 1         | 2         | 2016-03-01 | 5            |
-- | 1         | 2         | 2016-05-02 | 6            |
-- | 2         | 3         | 2017-06-25 | 1            |
-- | 3         | 1         | 2016-03-02 | 0            |
-- | 3         | 4         | 2018-07-03 | 5            |
-- +-----------+-----------+------------+--------------+
--
-- (player_id, event_date) is the primary key of this table.
-- This table shows the activity of players of some game.
-- Each row is a record of a player who logged in and played a number of games (possibly 0)
-- before logging out on some day using some device.
--
-- Write a SQL query that reports the device that is first logged in for each player.
--
-- Result table:
-- +-----------+-----------+
-- | player_id | device_id |
-- +-----------+-----------+
-- | 1         | 2         |
-- | 2         | 3         |
-- | 3         | 1         |
-- +-----------+-----------+


INSERT INTO player_activity (player_id, device_id, event_date, games_played) VALUES
(1, 2, '2016-03-01', 5),
(1, 2, '2016-05-02', 6),
(1, 3, '2017-06-25', 1),
(3, 1, '2016-03-02', 0),
(3, 4, '2018-07-03', 5);

with cte as (
  select 
    player_id, 
    event_date, 
    games_played, 
    sum(games_played) over(
      partition by player_id 
      order by 
        event_date
    ) as games_played_so_far 
  from 
    player_activity
) 
select 
  player_id, 
  event_date, 
  games_played_so_far 
from 
  cte;


-- Table: Activity
-- +-----------+-----------+------------+--------------+
-- | player_id | device_id | event_date | games_played |
-- +-----------+-----------+------------+--------------+
-- | 1         | 2         | 2016-03-01 | 5            |
-- | 1         | 2         | 2016-05-02 | 6            |
-- | 1         | 3         | 2017-06-25 | 1            |
-- | 3         | 1         | 2016-03-02 | 0            |
-- | 3         | 4         | 2018-07-03 | 5            |
-- +-----------+-----------+------------+--------------+
--
-- (player_id, event_date) is the primary key of this table.
-- This table shows the activity of players of some game.
-- Each row is a record of a player who logged in and played a number of games (possibly 0)
-- before logging out on some day using some device.
--
-- Write an SQL query that reports for each player and date, how many games played so far by the player.
-- That is, the total number of games played by the player until that date.
-- 
-- Result table:
-- +-----------+------------+---------------------+
-- | player_id | event_date | games_played_so_far |
-- +-----------+------------+---------------------+
-- | 1         | 2016-03-01 | 5                   |
-- | 1         | 2016-05-02 | 11                  |
-- | 1         | 2017-06-25 | 12                  |
-- | 3         | 2016-03-02 | 0                   |
-- | 3         | 2018-07-03 | 5                   |
-- +-----------+------------+---------------------+
--
-- Explanation:
-- For the player with id 1, 5 + 6 = 11 games played by 2016-05-02, and 5 + 6 + 1 = 12 games played by 2017-06-25.
-- For the player with id 3, 0 + 5 = 5 games played by 2018-07-03.
-- Note that for each player we only care about the days when the player logged in.


create table Employee(
Id int,
Name varchar(40),
Department char,
ManagerId int
)

insert into Employee(Id,Name,Department,ManagerId)
values (101,'John','A',null),
(102,'Dan','A',101),
(103,'James','A',101),
(104,'Amy','A',101),
(105,'Anne','A',101),
(106,'Ron','B',101)

WITH cte AS (
    SELECT 
        ManagerId, 
        COUNT(1) AS report_count
    FROM 
        Employee
    GROUP BY 
        ManagerId
    HAVING 
        COUNT(1) >= 5
)

select e.Name from Employee e join cte on e.Id = cte.ManagerId;

--14. Employee Bonus 
-- Select all employee's name and bonus whose bonus is < 1000.
-- Table: Employee
-- +--------+--------+-------------+--------+
-- | empId  | name   | supervisor  | salary |
-- +--------+--------+-------------+--------+
-- | 1      | John   | 3           | 1000   |
-- | 2      | Dan    | 3           | 2000   |
-- | 3      | Brad   | null        | 4000   |
-- | 4      | Thomas | 3           | 4000   |
-- +--------+--------+-------------+--------+
-- empId is the primary key column for this table.

-- Table: Bonus
-- +--------+--------+
-- | empId  | bonus  |
-- +--------+--------+
-- | 2      | 500    |
-- | 4      | 2000   |
-- +--------+--------+
-- empId is the primary key column for this table.

-- Example output:
-- +--------+--------+
-- | name   | bonus  |
-- +--------+--------+
-- | John   | null   |
-- | Dan    | 500    |
-- | Brad   | null   |
-- +--------+--------+
CREATE TABLE Employee (
    empId INT PRIMARY KEY,
    name VARCHAR(100),
    supervisor INT,
    salary INT
);

INSERT INTO Employee (empId, name, supervisor, salary) VALUES
(1, 'John', 3, 1000),
(2, 'Dan', 3, 2000),
(3, 'Brad', NULL, 4000),
(4, 'Thomas', 3, 4000);

CREATE TABLE Bonus (
    empId INT PRIMARY KEY,
    bonus INT
);

INSERT INTO Bonus (empId, bonus) 
VALUES 
  (2, 500), 
  (4, 2000);


select 
  e.name, 
  b.bonus 
from 
  Employee e 
  join Bonus b on e.empId = b.empId 
where 
  bonus < 1000;


-- 15. Given a table customer holding customers information and the referee.
--
-- +----+------+------------+
-- | id | name | referee_id |
-- +----+------+------------+
-- | 1  | Will | NULL       |
-- | 2  | Jane | NULL       |
-- | 3  | Alex | 2          |
-- | 4  | Bill | NULL       |
-- | 5  | Zack | 1          |
-- | 6  | Mark | 2          |
-- +----+------+------------+
--
-- Write a query to return the list of customers NOT referred by the person with id '2'.
--
-- For the sample data above, the result is:
--
-- +------+
-- | name |
-- +------+
-- | Will |
-- | Jane |
-- | Bill |
-- | Zack |
-- +------+

CREATE TABLE customer (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    referee_id INT NULL,
    CONSTRAINT fk_referee FOREIGN KEY (referee_id) REFERENCES customer(id)
);

INSERT INTO customer (id, name, referee_id) VALUES
(1, 'Will', NULL),
(2, 'Jane', NULL),
(3, 'Alex', 2),
(4, 'Bill', NULL),
(5, 'Zack', 1),
(6, 'Mark', 2);


select name from customer where referee_id is null or referee_id  <> 2;


-- 16. Query the customer_number from the orders table for the customer who has placed the largest number of orders. 
-- It is guaranteed that exactly one customer will have placed more orders than any other customer. 
-- The orders table is defined as follows: 
-- | Column | Type | 
-- |-------------------|-----------| 
-- | order_number (PK) | int | 
-- | customer_number | int | 
-- | order_date | date | 
-- | required_date | date | 
-- | shipped_date | date | 
-- | status | char(15) | 
-- | comment | char(200) | 
-- Sample Input 
-- | order_number | customer_number | order_date | required_date | shipped_date | status | comment | 
-- |--------------|-----------------|------------|---------------|--------------|--------|---------| 
-- | 1 | 1 | 2017-04-09 | 2017-04-13 | 2017-04-12 | Closed | | 
-- | 2 | 2 | 2017-04-15 | 2017-04-20 | 2017-04-18 | Closed | | 
-- | 3 | 3 | 2017-04-16 | 2017-04-25 | 2017-04-20 | Closed | | 
-- | 4 | 3 | 2017-04-18 | 2017-04-28 | 2017-04-25 | Closed | | 
-- Sample Output 
-- | customer_number | 
-- |-----------------| 
-- | 3 | 
-- Explanation
-- The customer with number '3' has two orders, which is greater than either customer '1' or '2' because each of them only has one order. So the result is customer_number '3'. 
-- Follow up: What if more than one customer have the largest number of orders, can you find all the customer_number in this case?  

CREATE TABLE orders (
    order_number INT PRIMARY KEY,
    customer_number INT NOT NULL,
    order_date DATE NOT NULL,
    required_date DATE NOT NULL,
    shipped_date DATE,
    status CHAR(15) NOT NULL,
    comment CHAR(200)
);

INSERT INTO orders (order_number, customer_number, order_date, required_date, shipped_date, status, comment) VALUES
(1, 1, '2017-04-09', '2017-04-13', '2017-04-12', 'Closed', NULL),
(2, 2, '2017-04-15', '2017-04-20', '2017-04-18', 'Closed', NULL),
(3, 3, '2017-04-16', '2017-04-25', '2017-04-20', 'Closed', NULL),
(4, 3, '2017-04-18', '2017-04-28', '2017-04-25', 'Closed', NULL);


select 
 	customer_number 
from 
 	orders 
group by 
 	customer_number 
order by 
	count(*)
desc limit 1


--2nd Part
with order_count as(
	select 
		customer_number,COUNT(*)as total_orders
	from
		orders
	group by
		customer_number 	
),
max_count as(
	select max(total_orders) as max_orders
	from order_count
)
select 
	customer_number
from
	order_count
where 
	total_orders = (select max_orders from max_count)
	
	

-- 17. There is a table World 
-- +-----------------+------------+------------+--------------+-------------- -+ 
-- | name | continent | area | population | gdp | 
-- +-----------------+------------+------------+--------------+-------------- -+ 
-- | Afghanistan | Asia | 652230 | 25500100 | 20343000 | 
-- | Albania | Europe | 28748 | 2831741 | 12960000 | 
-- | Algeria | Africa | 2381741 | 37100000 | 188681000 | 
-- | Andorra | Europe | 468 | 78115 | 3712000 | 
-- | Angola | Africa | 1246700 | 20609294 | 100990000 | 
-- +-----------------+------------+------------+--------------+-------------- -+ 
-- A country is big if it has an area of bigger than 3 million square km or a population of more than 25 million. 
-- Write a SQL solution to output big countries' name, population and area. 
-- For example, according to the above table, we should output: 
-- +--------------+-------------+--------------+ 
-- | name | population | area | 
-- +--------------+-------------+--------------+ 
-- | Afghanistan | 25500100 | 652230 | 
-- | Algeria | 37100000 | 2381741 | 
-- +--------------+-------------+--------------+ 

CREATE TABLE World (
name VARCHAR(50) PRIMARY KEY,
continent VARCHAR(50),
area INT,
population INT,
gdp BIGINT
);

INSERT INTO World (name, continent, area, population, gdp) VALUES
('Afghanistan', 'Asia', 652230, 25500100, 20343000),
('Albania', 'Europe', 28748, 2831741, 12960000),
('Algeria', 'Africa', 2381741, 37100000, 188681000),
('Andorra', 'Europe', 468, 78115, 3712000),
('Angola', 'Africa', 1246700, 20609294, 100990000);

select 
  	name, 
  	population, 
  	area 
from 
  	World 
where 
  	area > 3000000 
or 
	population > 25000000

	
-- 18. There is a table courses with columns: student and class 
-- Please list out all classes which have more than or equal to 5 students. 
-- For example, the table: 
-- +---------+------------+ 
-- | student | class      | 
-- +---------+------------+ 
-- | A       | Math       | 
-- | B       | English    | 
-- | C       | Math       | 
-- | D       | Biology    | 
-- | E       | Math       | 
-- | F       | Computer   | 
-- | G       | Math       | 
-- | H       | Math       | 
-- | I       | Math       | 
-- +---------+------------+ 
-- Should output: 
-- +---------+ 
-- | class   | 
-- +---------+ 
-- | Math    | 
-- +---------+ 
-- Note: 
-- The students should not be counted duplicate in each course.

CREATE TABLE courses (
    student VARCHAR(50),
    class VARCHAR(50)
);

INSERT INTO courses (student, class) VALUES
('A', 'Math'),
('B', 'English'),
('C', 'Math'),
('D', 'Biology'),
('E', 'Math'),
('F', 'Computer'),
('G', 'Math'),
('H', 'Math'),
('I', 'Math');


select 
	class 
from 
	courses 
group by 
	class 
having 
	count(*)>1 
	

--19.In a social network like Facebook or Twitter, people can send friend requests
-- and accept others’ requests as well. 

-- You are given two tables:

-- Table: friend_request
-- Contains information about who sent a friend request to whom and when.
-- | sender_id | send_to_id | request_date |
-- |-----------|------------|--------------|
-- | 1         | 2          | 2016_06-01   |
-- | 1         | 3          | 2016_06-01   |
-- | 1         | 4          | 2016_06-01   |
-- | 2         | 3          | 2016_06-02   |
-- | 3         | 4          | 2016-06-09   |

-- Table: request_accepted
-- Contains records of friend requests that were accepted.
-- | requester_id | accepter_id | accept_date |
-- |--------------|-------------|-------------|
-- | 1            | 2           | 2016_06-03  |
-- | 1            | 3           | 2016-06-08  |
-- | 2            | 3           | 2016-06-08  |
-- | 3            | 4           | 2016-06-09  |
-- | 3            | 4           | 2016-06-10  |

-- Write a SQL query to find the overall acceptance rate of requests,
-- rounded to 2 decimal places.

-- Acceptance rate = (Number of accepted requests) / (Number of sent requests)

-- Expected Output:
-- | accept_rate |
-- |-------------|
-- | 0.80        |

	
-- Create the friend_request table
CREATE TABLE friend_request (
    sender_id INT,
    send_to_id INT,
    request_date DATE
);

-- Insert values into friend_request table
INSERT INTO friend_request (sender_id, send_to_id, request_date) VALUES
(1, 2, '2016-06-01'),
(1, 3, '2016-06-01'),
(1, 4, '2016-06-01'),
(2, 3, '2016-06-02'),
(3, 4, '2016-06-09');

-- Create the request_accepted table
CREATE TABLE request_accepted (
    requester_id INT,
    accepter_id INT,
    accept_date DATE
);

-- Insert values into request_accepted table
INSERT INTO request_accepted (requester_id, accepter_id, accept_date) VALUES
(1, 2, '2016-06-03'),
(1, 3, '2016-06-08'),
(2, 3, '2016-06-08'),
(3, 4, '2016-06-09'),
(3, 4, '2016-06-10');


with request_count as (
  select 
    count(*) as total_request 
  from 
    friend_request
), 
accept_count as (
  select 
  	count(distinct row(requester_id, accepter_id))as total_accepted
  from 
    request_accepted
) 
select 
  round(
    accept_count.total_accepted * 1.0 / request_count.total_request, 
    2
  ) as accept_rate 
from 
  accept_count, 
  request_count;


	
-- 20. -- Table structure:
-- cinema(seat_id INT, free BOOLEAN)
-- free = 1 means seat is available
-- free = 0 means seat is taken

-- Goal: Find all seats that are part of at least one sequence of consecutive available seats
-- i.e., only return seats where there is at least one free neighbor (previous or next)

-- Example input:
-- | seat_id | free |
-- |---------|------|
-- |    1    |  1   |
-- |    2    |  0   |
-- |    3    |  1   |
-- |    4    |  1   |
-- |    5    |  1   |


-- Step 1: Create the table
CREATE TABLE cinema (
    seat_id INT PRIMARY KEY,
    free BOOLEAN
);

-- Step 2: Insert the sample data
INSERT INTO cinema (seat_id, free) VALUES
(1, TRUE),
(2, FALSE),
(3, TRUE),
(4, TRUE),
(5, TRUE);



select seat_id
from (
	select seat_id,
		free,
		lag(free) over (order by seat_id) as prev_free,
		lead(free) over (order by seat_id) as next_free
	from cinema
) as t
where (free= true and prev_free=true)
or (free= true and next_free=true)
order by seat_id;


--21. Given three tables: salesperson, company, orders. 
-- Output all the names in the table salesperson, who didn’t have sales to company 'RED'. 

-- Example 
-- Input 
-- Table: salesperson 
-- +----------+------+--------+-----------------+-----------+ 
-- | sales_id | name | salary | commission_rate | hire_date | 
-- +----------+------+--------+-----------------+-----------+ 
-- | 1        | John | 100000 | 6               | 4/1/2006  | 
-- | 2        | Amy  | 120000 | 5               | 5/1/2010  | 
-- | 3        | Mark | 65000  | 12              | 12/25/2008| 
-- | 4        | Pam  | 25000  | 25              | 1/1/2005  | 
-- | 5        | Alex | 50000  | 10              | 2/3/2007  | 
-- +----------+------+--------+-----------------+-----------+ 
-- The table salesperson holds the salesperson information. 
-- Every salesperson has a sales_id and a name. 

-- Table: company 
-- +---------+--------+------------+ 
-- | com_id  | name   | city       | 
-- +---------+--------+------------+ 
-- | 1       | RED    | Boston     | 
-- | 2       | ORANGE | New York   | 
-- | 3       | YELLOW | Boston     | 
-- | 4       | GREEN  | Austin     | 
-- +---------+--------+------------+ 
-- The table company holds the company information. 
-- Every company has a com_id and a name. 

-- Table: orders 
-- +----------+------------+---------+----------+--------+ 
-- | order_id | order_date | com_id  | sales_id | amount | 
-- +----------+------------+---------+----------+--------+ 
-- | 1        | 1/1/2014   | 3       | 4        | 100000 | 
-- | 2        | 2/1/2014   | 4       | 5        | 5000   | 
-- | 3        | 3/1/2014   | 1       | 1        | 50000  | 
-- | 4        | 4/1/2014   | 1       | 4        | 25000  | 
-- +----------+------------+---------+----------+--------+ 
-- The table orders holds the sales record information, 
-- salesperson and customer company are represented by sales_id and com_id.

-- Output 
-- +------+ 
-- | name | 
-- +------+ 
-- | Amy  | 
-- | Mark | 
-- | Alex | 
-- +------+ 
-- Explanation: According to order '3' and '4' in table orders, 
-- it is easy to tell only salesperson 'John' and 'Pam' have sales to company 'RED', 
-- so we need to output all the other names in table salesperson.


-- Create tables
create table SalesPerson (
    sales_id int,
    name varchar(255),
    salary int,
    commission_rate int,
    hire_date date
);

create table Company (
    com_id int,
    name varchar(255),
    city varchar(255)
);

create table Orders (
    order_id int,
    order_date date,
    com_id int,
    sales_id int,
    amount int
);

-- Insert data into SalesPerson
insert into SalesPerson (sales_id, name, salary, commission_rate, hire_date) values
(1, 'John', 100000, 6, '2006-04-01'),
(2, 'Amy', 12000, 5, '2010-05-01'),
(3, 'Mark', 65000, 12, '2008-12-25'),
(4, 'Pam', 25000, 25, '2005-01-01'),
(5, 'Alex', 5000, 10, '2007-02-03');

-- Insert data into Company
insert into Company (com_id, name, city) values
(1, 'RED', 'Boston'),
(2, 'ORANGE', 'New York'),
(3, 'YELLOW', 'Boston'),
(4, 'GREEN', 'Austin');

-- Insert data into Orders
insert into Orders (order_id, order_date, com_id, sales_id, amount) values
(1, '2014-01-01', 3, 4, 10000),
(2, '2014-02-01', 4, 5, 5000),
(3, '2014-03-01', 1, 1, 50000),
(4, '2014-04-01', 1, 4, 25000);

select 
  name, 
  s.sales_id 
from 
  SalesPerson s 
where 
  s.sales_id not in (
    select 
      r.sales_id 
    from 
      orders r 
      join company c on r.com_id = c.com_id 
    where 
      c.name like 'RED'
  );


--22. Given a table tree, id is the identifier of the tree node and p_id is its parent node's id. 

-- +----+------+
-- | id | p_id |
-- +----+------+
-- | 1  | null |
-- | 2  | 1    |
-- | 3  | 1    |
-- | 4  | 2    |
-- | 5  | 2    |
-- +----+------+

-- Each node in the tree can be one of three types: 
-- Leaf: if the node is a leaf node. 
-- Root: if the node is the root of the tree. 
-- Inner: If the node is neither a leaf node nor a root node. 

-- Write a query to print the node id and the type of the node. Sort your output by the node id.

-- The result for the above sample is: 
-- +----+--------+
-- | id | Type   |
-- +----+--------+
-- | 1  | Root   |
-- | 2  | Inner  |
-- | 3  | Leaf   |
-- | 4  | Leaf   |
-- | 5  | Leaf   |
-- +----+--------+

-- Explanation:
-- Node '1' is root node, because its parent node is NULL and it has child nodes '2' and '3'.
-- Node '2' is inner node, because it has parent node '1' and child nodes '4' and '5'.
-- Node '3', '4', and '5' are leaf nodes, because they have a parent node and no child nodes.

-- And here is the image of the sample tree as below:
--       1
--      / \
--     2   3
--    / \
--   4   5

-- Note: 
-- If there is only one node in the tree, you only need to output its root attribute.

--+----+----+----+----------+


create table tree (
    id INT,
    p_id INT
);

insert
	into
	tree
values
(1,null),
(2,1),
(3,1),
(4,2),
(5,2);

select
	id,
	case
		when p_id is null then 'Root'
		when id in (
		select
			distinct p_id
		from
			tree
		where
			p_id is not null) then 'Inner'
		else 'Leaf'
	end as type
from
	tree
order by
	id;


-- 24. Triangle Judgement

drop table if exists triangle;

create table triangle (
    x INT,
    y INT,
    z INT
);

insert
	into
	triangle
values
(3,4,5),
(1,1,3);

select
	x,
	y,
	z,
	case
		when x + y > z
		and x + z > y
		and y + z > x then 'Yes'
		else 'No'
	end as triangle
from
	triangle;


-- 25. Shortest Distance in a Plane

drop table if exists point_2d;

create table point_2d (
    x INT,
    y INT
);

insert
	into
	point_2d
values
(1,1),
(2,2),
(3,3);

select
	ROUND(
    MIN(
        SQRT(POWER(p1.x - p2.x, 2) + POWER(p1.y - p2.y, 2))
    ), 2
) as shortest
from
	point_2d p1
join point_2d p2 on
	p1.x != p2.x
	or p1.y != p2.y;


-- 26. Shortest Distance in a Line

drop table if exists point;

create table point (
    x INT
);

insert
	into
	point
values
(1),
(3),
(6);

select
	MIN(ABS(p1.x - p2.x)) as shortest
from
	point p1
join point p2 on
	p1.x != p2.x;


-- 27. Biggest Single Number

drop table if exists my_numbers;

create table my_numbers (
    num INT
);

insert
	into
	my_numbers
values
(5),
(3),
(3),
(9),
(5),
(7);

select
	MAX(num) as num
from
	my_numbers
group by
	num
having
	COUNT(*) = 1
order by
	num desc
limit 1;


-- 28. Not Boring Movies

drop table if exists cinema;

create table cinema (
    id INT,
    movie VARCHAR,
    description VARCHAR,
    rating FLOAT
);

insert
	into
	cinema
values
(1,'Movie A','fun',8.5),
(2,'Movie B','boring',5.0),
(3,'Movie C','thrilling',9.0);

select
	*
from
	cinema
where
	mod(id, 2) = 1
	and description != 'boring'
order by
	rating desc;


-- 29. Exchange Seats

drop table if exists seat;

create table seat (
    id INT,
    student VARCHAR
);

insert
	into
	seat
values
(1,'Alice'),
(2,'Bob'),
(3,'Charlie'),
(4,'David');

select
	case
		when mod(id, 2) = 1
		and id != (
		select
			MAX(id)
		from
			seat) then id + 1
		when mod(id, 2) = 0 then id - 1
		else id
	end as id,
	student
from
	seat
order by
	id;


-- 30. Swap Salary

drop table if exists salary;

create table salary (
    id INT,
    name VARCHAR,
    sex CHAR(1),
    salary INT
);

insert
	into
	salary
values
(1,'Alice','f',6000),
(2,'Bob','m',7000);

update
	salary
set
	sex = case
		when sex = 'm' then 'f'
		when sex = 'f' then 'm'
		else sex
	end;


-- 31. Customers Who Bought All Products

drop table if exists Customer;

create table Customer (
    customer_id INT,
    product_key INT
);

drop table if exists Product;

create table Product (
    product_key INT primary key
);

insert
	into
	Customer
values
(1,1),
(1,2),
(2,1);

insert
	into
	Product
values
(1),
(2);

select
	customer_id
from
	Customer
group by
	customer_id
having
	COUNT(distinct product_key) = (
	select
		COUNT(*)
	from
		Product);


-- 32. Actors and Directors Who Cooperated At Least Three Times

drop table if exists ActorDirector;

create table ActorDirector (
    actor_id INT,
    director_id INT,
    timestamp INT
);

insert
	into
	ActorDirector
values
(1,1,100),
(1,1,101),
(1,1,102),
(2,2,100);

select
	actor_id,
	director_id
from
	ActorDirector
group by
	actor_id,
	director_id
having
	COUNT(*) >= 3;


-- 33. Product Sales Analysis I

drop table if exists Sales;

create table Sales (
    sale_id INT,
    product_id INT,
    year INT,
    quantity INT,
    price INT
);

drop table if exists Product;

create table Product (
    product_id INT,
    product_name VARCHAR
);

insert
	into
	Sales
values
(1,100,2008,10,500),
(2,100,2009,12,600);

insert
	into
	Product
values
(100,'Nokia');

select
	p.product_name,
	s.year,
	s.price
from
	Sales s
join Product p on
	s.product_id = p.product_id;


-- 34. Product Sales Analysis II

drop table if exists Sales;

create table Sales (
    sale_id INT,
    product_id INT,
    year INT,
    quantity INT,
    price INT
);

insert
	into
	Sales
values
(1,100,2008,10,500),
(2,100,2009,12,600);

select
	product_id,
	SUM(quantity) as total_quantity
from
	Sales
group by
	product_id;


-- 35. Product Sales Analysis III

drop table if exists Sales;

create table Sales (
    sale_id INT,
    product_id INT,
    year INT,
    quantity INT,
    price INT
);

insert
	into
	Sales
values
(1,100,2008,10,500),
(2,100,2009,12,600),
(3,200,2010,5,1000);

select
	product_id,
	year as first_year,
	quantity,
	price
from
	Sales s1
where
	year = (
	select
		MIN(year)
	from
		Sales s2
	where
		s1.product_id = s2.product_id
);


-- 36. Project Employees I

drop table if exists Project;

create table Project (
    project_id INT,
    employee_id INT
);

insert
	into
	Project
values
(1,1),
(1,2),
(1,3),
(2,1),
(2,4);

select
	project_id,
	COUNT(employee_id) as employee_count
from
	Project
group by
	project_id;


-- 37. Project Employees II

drop table if exists Project;

create table Project (
    project_id INT,
    employee_id INT
);

drop table if exists Employee;

create table Employee (
    employee_id INT,
    name VARCHAR,
    experience_years INT
);

insert
	into
	Project
values
(1,1),
(1,2),
(1,3),
(2,4);

insert
	into
	Employee
values
(1,'Alice',3),
(2,'Bob',4),
(3,'Charlie',5),
(4,'David',2);

select
	p.project_id,
	ROUND(AVG(e.experience_years), 2) as average_years
from
	Project p
join Employee e on
	p.employee_id = e.employee_id
group by
	p.project_id;


-- 38. Project Employees III

drop table if exists Project;

create table Project (
    project_id INT,
    employee_id INT
);

drop table if exists Employee;

create table Employee (
    employee_id INT,
    name VARCHAR,
    experience_years INT
);

insert
	into
	Project
values
(1,1),
(1,2),
(1,3),
(2,4);

insert
	into
	Employee
values
(1,'Alice',3),
(2,'Bob',4),
(3,'Charlie',5),
(4,'David',2);

select
	project_id,
	employee_id
from
	(
	select
		p.project_id,
		p.employee_id,
		rank() over (partition by p.project_id
	order by
		e.experience_years desc) as rnk
	from
		Project p
	join Employee e on
		p.employee_id = e.employee_id
) ranked
where
	rnk = 1;


-- 39. Sales Analysis I

drop table if exists Sales;

create table Sales (
    seller_id INT,
    product_id INT,
    buyer_id INT,
    sale_date DATE,
    quantity INT,
    price INT
);

insert
	into
	Sales
values
(1,1,2,'2020-01-01',1,100),
(2,2,1,'2020-02-01',1,200);

select
	*
from
	Sales
where
	sale_date between '2019-01-01' and '2019-12-31';


-- 40. Sales Analysis II

drop table if exists Sales;

create table Sales (
    seller_id INT,
    product_id INT,
    buyer_id INT,
    sale_date DATE,
    quantity INT,
    price INT
);

drop table if exists Product;

create table Product (
    product_id INT,
    product_name VARCHAR,
    product_category VARCHAR
);

insert
	into
	Sales
values
(1,1,2,'2020-01-01',1,100),
(2,2,1,'2020-02-01',1,200);

insert
	into
	Product
values
(1,'Phone','Electronics'),
(2,'Shoes','Clothing');

select
	s.*
from
	Sales s
join Product p on
	s.product_id = p.product_id
where
	p.product_category = 'Electronics';


-- 41. Sales Analysis III

drop table if exists Sales;

create table Sales (
    seller_id INT,
    product_id INT,
    buyer_id INT,
    sale_date DATE,
    quantity INT,
    price INT
);

drop table if exists Product;

create table Product (
    product_id INT,
    product_name VARCHAR,
    product_category VARCHAR
);

insert
	into
	Sales
values
(1,1,2,'2020-03-01',1,100),
(2,1,3,'2019-04-01',2,100);

insert
	into
	Product
values
(1,'Phone','Electronics');

select
	distinct s.product_id,
	p.product_name
from
	Sales s
join Product p on
	s.product_id = p.product_id
where
	s.product_id not in (
	select
		product_id
	from
		Sales
	where
		sale_date not between '2019-01-01' and '2019-03-31'
);


-- 42. Highest Grade For Each Student

drop table if exists Enrollments;

create table Enrollments (
    student_id INT,
    course_id INT,
    grade INT,
    primary key (student_id,
course_id)
);

insert
	into
	Enrollments
values
(1,1,90),
(1,2,95),
(2,1,91),
(2,2,93);

select
	student_id,
	course_id,
	grade
from
	(
	select
		*,
		rank() over (partition by student_id
	order by
		grade desc,
		course_id asc) as rk
	from
		Enrollments
) ranked
where
	rk = 1;


-- 43. Reported Posts

drop table if exists Actions;

create table Actions (
    user_id INT,
    post_id INT,
    action_date DATE,
    action VARCHAR,
    extra VARCHAR
);

insert
	into
	Actions
values
(1,101,'2019-07-04','report','spam'),
(2,102,'2019-07-04','report','offensive'),
(3,101,'2019-07-04','report','spam');

select
	extra as report_reason,
	COUNT(distinct post_id) as report_count
from
	Actions
where
	action = 'report'
	and action_date = '2019-07-04'
group by
	extra;


-- 44. Active Businesses

drop table if exists Events;

create table Events (
    business_id INT,
    event_type VARCHAR,
    occurences INT,
    primary key (business_id,
event_type)
);

insert
	into
	Events
values
(1,'sale',10),
(1,'review',5),
(2,'sale',10),
(2,'review',3),
(3,'sale',10);

select
	business_id
from
	Events e1
where
	(event_type,
	occurences) in (
	select
		event_type,
		MAX(occurences)
	from
		Events e2
	group by
		event_type
)
group by
	business_id
having
	COUNT(*) > 1;


-- 45. User Activity for the Past 30 Days I

drop table if exists Activity;

create table Activity (
    user_id INT,
    session_id INT,
    activity_date DATE,
    activity_type VARCHAR
);

insert
	into
	Activity
values
(1,10,'2019-07-01','open'),
(1,11,'2019-07-02','click'),
(2,12,'2019-07-01','open'),
(2,13,'2019-07-03','click');

select
	activity_date as day,
	COUNT(distinct user_id) as active_users
from
	Activity
where
	activity_date between DATE '2019-06-28' and DATE '2019-07-27'
group by
	activity_date;


-- 46. User Activity for the Past 30 Days II

drop table if exists Activity;

create table Activity (
    user_id INT,
    session_id INT,
    activity_date DATE,
    activity_type VARCHAR
);

insert
	into
	Activity
values
(1,10,'2019-07-01','open'),
(1,11,'2019-07-02','click'),
(2,12,'2019-07-01','open'),
(2,13,'2019-07-03','click');

select
	ROUND(COUNT(distinct session_id)::DECIMAL / COUNT(distinct user_id), 2) as average_sessions_per_user
from
	Activity
where
	activity_date between '2019-06-28' and '2019-07-27';


-- 47. Article Views I

drop table if exists views;

create table views (
    article_id INT,
    author_id INT,
    viewer_id INT,
    view_date DATE
);

insert
	into
	views
values
(1,1,3,'2019-08-01'),
(2,2,2,'2019-08-02');

select
	distinct author_id as id
from
	views
where
	author_id = viewer_id
order by
	author_id;


-- 48. Product Price at a Given Date

drop table if exists Products;

create table Products (
    product_id INT,
    new_price INT,
    change_date DATE,
    primary key (product_id,
change_date)
);

insert
	into
	Products
values
(1,20,'2019-08-14'),
(1,30,'2019-08-15'),
(2,50,'2019-08-16');

select
	p.product_id,
	coalesce((
           select new_price from Products p2
           where p2.product_id = p.product_id and p2.change_date <= '2019-08-16'
           order by change_date desc limit 1
       ), 10) as price
from
	(
	select
		distinct product_id
	from
		Products) p;


-- 49. Immediate Food Delivery I

drop table if exists Delivery;

create table Delivery (
    delivery_id INT,
    customer_id INT,
    order_date DATE,
    customer_pref_delivery_date DATE
);

insert
	into
	Delivery
values
(1,1,'2019-08-01','2019-08-01'),
(2,2,'2019-08-02','2019-08-03');

select
	ROUND(
    100.0 * COUNT(*) filter (where order_date = customer_pref_delivery_date) / COUNT(*), 2
) as immediate_percentage
from
	Delivery;


-- 50. Immediate Food Delivery II

drop table if exists Delivery;

create table Delivery (
    delivery_id INT,
    customer_id INT,
    order_date DATE,
    customer_pref_delivery_date DATE
);

insert
	into
	Delivery
values
(1,101,'2022-01-01','2022-01-01'),
(2,101,'2022-01-02','2022-01-03'),
(3,102,'2022-01-01','2022-01-01'),
(4,103,'2022-01-04','2022-01-04');

select
	customer_id,
	ROUND(100.0 * COUNT(*) filter (where order_date = customer_pref_delivery_date) / COUNT(*), 2) as immediate_percentage
from
	Delivery
group by
	customer_id;


-- 51. Customer Who Visited but Did Not Make Any Transactions

drop table if exists Visits;

create table Visits (
    visit_id INT,
    customer_id INT
);

drop table if exists Transactions;

create table Transactions (
    transaction_id INT,
    visit_id INT,
    amount INT
);

insert
	into
	Visits
values 
(1,23),
(2,9),
(3,30),
(4,54),
(5,96);

insert
	into
	Transactions
values 
(2,2,310),
(3,3,300),
(9,5,200);

select
	customer_id
from
	Visits
where
	visit_id not in (
	select
		visit_id
	from
		Transactions);


-- 52. Bank Account Summary II

drop table if exists Users;

create table Users (
    account INT,
    name VARCHAR
);

drop table if exists Transactions;

create table Transactions (
    trans_id INT,
    account INT,
    amount INT,
    transacted_on DATE
);

insert
	into
	Users
values (900001,
'Alice'),
(900002,
'Bob');

insert
	into
	Transactions
values (1,
900001,
7000,
'2022-01-01'),
(2,
900001,
-3000,
'2022-01-02');

select
	u.name,
	SUM(t.amount) as balance
from
	Users u
join Transactions t on
	u.account = t.account
group by
	u.name
having
	SUM(t.amount) > 10000;


-- 53. Bank Account Summary III

drop table if exists Users;

create table Users (
    account INT,
    name VARCHAR
);

drop table if exists Transactions;

create table Transactions (
    trans_id INT,
    account INT,
    amount INT,
    transacted_on DATE
);

insert
	into
	Users
values 
(900001,'Alice'),
(900002,'Bob');

insert
	into
	Transactions
values 
(1,900001,1000,'2022-06-01'),
(2,900001,-200,'2022-06-02'),
(3,900002,5000,'2022-06-01');

select
	u.name,
	SUM(t.amount) as balance
from
	Users u
join Transactions t on
	u.account = t.account
where
	t.transacted_on between '2022-06-01' and '2022-06-30'
group by
	u.name;


-- 54. Monthly Transactions I

drop table if exists Transactions;

create table Transactions (
    id INT,
    country VARCHAR,
    state VARCHAR,
    amount INT,
    trans_date DATE
);

insert
	into
	Transactions
values
(1,'US','approved',1000,'2019-01-01'),
(2,'US','declined',2000,'2019-01-25'),
(3,'US','approved',1000,'2019-02-10');

select
	TO_CHAR(trans_date, 'YYYY-MM') as month,
	country,
	COUNT(*) as trans_count,
	SUM(case when state = 'approved' then 1 else 0 end) as approved_count,
	SUM(amount) as total_amount,
	SUM(case when state = 'approved' then amount else 0 end) as approved_amount
from
	Transactions
group by
	TO_CHAR(trans_date, 'YYYY-MM'),
	country;


-- 55. Monthly Transactions II

drop table if exists Transactions;

create table Transactions (
    id INT,
    country VARCHAR,
    state VARCHAR,
    amount INT,
    trans_date DATE
);

insert
	into
	Transactions
values
(1,'US','approved',1000,'2019-01-01'),
(2,'US','declined',2000,'2019-01-25'),
(3,'US','approved',1000,'2019-02-10');

select
	country,
	COUNT(*) filter (
where
	state = 'approved') as approved_transactions,
	COUNT(*) filter (
where
	state = 'declined') as declined_transactions
from
	Transactions
group by
	country;


-- 56. Expenses Analysis

drop table if exists Expenses;

create table Expenses (
    id INT,
    amount INT,
    category VARCHAR,
    date DATE
);

insert
	into
	Expenses
values
(1,100,'food','2022-01-01'),
(2,200,'transport','2022-01-02'),
(3,300,'food','2022-01-03');

select
	category,
	SUM(amount) as total_amount
from
	Expenses
group by
	category;


-- 57. Primary Department for Each Employee

drop table if exists Employee;

create table Employee (
    employee_id INT,
    department_id INT,
    primary_flag VARCHAR
);

insert
	into
	Employee
values
(1,1,'Y'),
(1,2,'N'),
(2,1,'N'),
(2,2,'Y');

select
	*
from
	Employee
where
	primary_flag = 'Y';


-- 58. Market Analysis I

drop table if exists Users;

create table Users (
    user_id INT,
    join_date DATE,
    favorite_brand VARCHAR
);

drop table if exists Orders;

create table Orders (
    order_id INT,
    order_date DATE,
    item_id INT,
    buyer_id INT
);

drop table if exists Items;

create table Items (
    item_id INT,
    item_brand VARCHAR
);

insert
	into
	Users
values 
(1,'2022-01-01','Nike');

insert
	into
	Items
values 
(1,'Nike'),
(2,'Adidas');

insert
	into
	Orders
values 
(1,'2022-01-10',1,1),
(2,'2022-01-15',2,1);

select
	u.user_id
from
	Users u
join Orders o on
	u.user_id = o.buyer_id
join Items i on
	o.item_id = i.item_id
where
	u.join_date between '2022-01-01' and '2022-01-31'
	and i.item_brand = u.favorite_brand
group by
	u.user_id;


-- 59. Market Analysis II

drop table if exists Users;

create table Users (
    user_id INT,
    join_date DATE,
    favorite_brand VARCHAR
);

drop table if exists Orders;

create table Orders (
    order_id INT,
    order_date DATE,
    item_id INT,
    buyer_id INT
);

drop table if exists Items;

create table Items (
    item_id INT,
    item_brand VARCHAR
);

insert
	into
	Users
values 
(1,'2022-01-01','Nike');

insert
	into
	Items
values 
(1,'Nike'),
(2,'Adidas');

insert
	into
	Orders
values 
(1,'2022-01-10',1,1),
(2,'2022-01-15',2,1);

select
	user_id,
	COUNT(distinct order_id) as total_orders
from
	Orders
where
	buyer_id in (
	select
		user_id
	from
		Users)
group by
	user_id;


-- 60. Market Analysis III

drop table if exists Users;

create table Users (
    user_id INT,
    join_date DATE,
    favorite_brand VARCHAR
);

drop table if exists Orders;

create table Orders (
    order_id INT,
    order_date DATE,
    item_id INT,
    buyer_id INT
);

drop table if exists Items;

create table Items (
    item_id INT,
    item_brand VARCHAR
);

insert
	into
	Users
values 
(1,'2022-01-01','Nike');

insert
	into
	Items
values 
(1,'Nike'),
(2,'Adidas');

insert
	into
	Orders
values 
(1,'2022-01-10',1,1),
(2,'2022-01-15',2,1);

select
	u.user_id,
	COUNT(distinct o.item_id) as unique_items
from
	Users u
left join Orders o on
	u.user_id = o.buyer_id
group by
	u.user_id;


-- 61. Product Sales Performance

drop table if exists Sales;

create table Sales (
    product_id INT,
    year INT,
    quantity INT,
    price INT
);

insert
	into
	Sales
values
(100,2019,10,500),
(100,2020,20,550),
(200,2019,5,800);

select
	product_id,
	year,
	quantity,
	price,
	rank() over (partition by product_id
order by
	year) as rank_by_year
from
	Sales;


-- 62. User Purchases by Month

drop table if exists Purchases;

create table Purchases (
    purchase_id INT,
    user_id INT,
    amount INT,
    purchase_date DATE
);

insert
	into
	Purchases
values
(1,101,100,'2022-01-05'),
(2,101,200,'2022-01-15'),
(3,102,150,'2022-02-10');

select
	user_id,
	TO_CHAR(purchase_date, 'YYYY-MM') as month,
	SUM(amount) as total_amount
from
	Purchases
group by
	user_id,
	TO_CHAR(purchase_date, 'YYYY-MM');


-- 63. Total Sales by Month and Product

drop table if exists Sales;

create table Sales (
    sale_id INT,
    product_id INT,
    sale_date DATE,
    quantity INT
);

insert
	into
	Sales
values
(1,100,'2022-01-01',10),
(2,100,'2022-01-15',15),
(3,101,'2022-01-20',20);

select
	product_id,
	TO_CHAR(sale_date, 'YYYY-MM') as month,
	SUM(quantity) as total_quantity
from
	Sales
group by
	product_id,
	TO_CHAR(sale_date, 'YYYY-MM');


-- 64. Percentage of Active Users

drop table if exists Users;

create table Users (
    user_id INT,
    name VARCHAR,
    activity_date DATE
);

insert
	into
	Users
values
(1,'Alice','2022-01-01'),
(2,'Bob','2022-01-15'),
(3,'Charlie','2022-01-20'),
(4,'David','2022-01-31');

select
	ROUND(100.0 * COUNT(*) / (select COUNT(*) from Users), 2) as active_percentage
from
	Users
where
	activity_date between '2022-01-01' and '2022-01-31';


-- 65. Rank Teams by Points

drop table if exists Teams;

create table Teams (
    team_id INT,
    team_name VARCHAR
);

drop table if exists Matches;

create table Matches (
    match_id INT,
    team1_id INT,
    team2_id INT,
    team1_score INT,
    team2_score INT
);

insert
	into
	Teams
values 
(1,'A'),
(2,'B');

insert
	into
	Matches
values 
(1,1,2,3,2);

select
	team_id,
	team_name,
	SUM(case
           when team_id = team1_id and team1_score > team2_score then 3
           when team_id = team2_id and team2_score > team1_score then 3
           when team_id in (team1_id, team2_id) and team1_score = team2_score then 1
           else 0
       end) as points
from
	(
	select
		team_id,
		team_name,
		match_id,
		team1_id,
		team2_id,
		team1_score,
		team2_score
	from
		Teams
	join Matches on
		Teams.team_id in (team1_id, team2_id)
) sub
group by
	team_id,
	team_name
order by
	points desc;


-- 66. Employee Department Salary Rank

drop table if exists Employee;

create table Employee (
    id INT,
    name VARCHAR,
    salary INT,
    departmentId INT
);

drop table if exists Department;

create table Department (
    id INT,
    name VARCHAR
);

insert
	into
	Employee
values
(1,'Alice',9000,1),
(2,'Bob',8500,1),
(3,'Charlie',10000,2);

insert
	into
	Department
values
(1,'Engineering'),
(2,'HR');

select
	d.name as department,
	e.name as employee,
	e.salary,
	dense_rank() over (partition by e.departmentId
order by
	e.salary desc) as rank
from
	Employee e
join Department d on
	e.departmentId = d.id;


-- 67. Customers With Strictly Increasing Purchases

drop table if exists Purchases;

create table Purchases (
    customer_id INT,
    purchase_date DATE,
    amount INT
);

insert
	into
	Purchases
values
(1,'2022-01-01',100),
(1,'2022-01-02',200),
(1,'2022-01-03',300),
(2,'2022-01-01',300),
(2,'2022-01-02',200);

select
	customer_id
from
	(
	select
		customer_id,
		amount,
		lag(amount) over (partition by customer_id
	order by
		purchase_date) as prev_amount
	from
		Purchases
) sub
group by
	customer_id
having
	BOOL_AND(prev_amount is null or amount > prev_amount);


-- 68. Frequent Users
Ans:
drop table if exists Users;

create table Users (
    user_id INT,
    user_name VARCHAR,
    created_at DATE
);

insert
	into
	Users
values
(1,'Alice','2022-01-01'),
(2,'Bob','2022-01-02');

select
	COUNT(*) as active_users
from
	Users
where
	created_at between '2022-01-01' and '2022-12-31';


-- 69. Average Daily Transactions

drop table if exists Transactions;

create table Transactions (
    transaction_id INT,
    user_id INT,
    amount INT,
    transaction_date DATE
);

insert
	into
	Transactions
values
(1,101,50,'2024-01-01'),
(2,101,30,'2024-01-01'),
(3,102,20,'2024-01-02'),
(4,103,70,'2024-01-03');

select
	ROUND(SUM(amount) * 1.0 / COUNT(distinct transaction_date), 2) as avg_daily_amount
from
	Transactions;



 


	


	