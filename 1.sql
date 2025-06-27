-- Create Worker table
CREATE TABLE Worker (
    WORKER_ID serial not null PRIMARY KEY,
    FIRST_NAME CHAR(25),
    LAST_NAME CHAR(25),
    SALARY INT  ,
    JOINING_DATE TIMESTAMP,
    DEPARTMENT CHAR(25)
);



-- Insert data into Worker
INSERT INTO Worker 
    (WORKER_ID, FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT) VALUES
    (1, 'Monika', 'Arora', 100000, '2014-02-20 09:00:00', 'HR'),
    (2, 'Niharika', 'Verma', 80000, '2014-06-11 09:00:00', 'Admin'),
    (3, 'Vishal', 'Singhal', 300000, '2014-02-20 09:00:00', 'HR'),
    (4, 'Amitabh', 'Singh', 500000, '2014-02-20 09:00:00', 'Admin'),
    (5, 'Vivek', 'Bhati', 500000, '2014-06-11 09:00:00', 'Admin'),
    (6, 'Vipul', 'Diwan', 200000, '2014-06-11 09:00:00', 'Account'),
    (7, 'Satish', 'Kumar', 75000, '2014-01-20 09:00:00', 'Account'),
    (8, 'Geetika', 'Chauhan', 90000, '2014-04-11 09:00:00', 'Admin');




-- Create Bonus table
CREATE TABLE Bonus (
    WORKER_REF_ID INT,
    BONUS_AMOUNT INT,
    BONUS_DATE TIMESTAMP,
    FOREIGN KEY (WORKER_REF_ID)
        REFERENCES Worker(WORKER_ID)
        ON DELETE CASCADE
);

-- Insert data into Bonus
INSERT INTO Bonus 
    (WORKER_REF_ID, BONUS_AMOUNT, BONUS_DATE) VALUES
    (1, 5000, '2016-02-20 00:00:00'),
    (2, 3000, '2016-06-11 00:00:00'),
    (3, 4000, '2016-02-20 00:00:00'),
    (1, 4500, '2016-02-20 00:00:00'),
    (2, 3500, '2016-06-11 00:00:00');

-- Create Title table
CREATE TABLE Title (
    WORKER_REF_ID INT,
    WORKER_TITLE CHAR(25),
    AFFECTED_FROM TIMESTAMP,
    FOREIGN KEY (WORKER_REF_ID)
        REFERENCES Worker(WORKER_ID)
        ON DELETE CASCADE
);

-- Insert data into Title
INSERT INTO Title 
    (WORKER_REF_ID, WORKER_TITLE, AFFECTED_FROM) VALUES
    (1, 'Manager', '2016-02-20 00:00:00'),
    (2, 'Executive', '2016-06-11 00:00:00'),
    (8, 'Executive', '2016-06-11 00:00:00'),
    (5, 'Manager', '2016-06-11 00:00:00'),
    (4, 'Asst. Manager', '2016-06-11 00:00:00'),
    (7, 'Executive', '2016-06-11 00:00:00'),
    (6, 'Lead', '2016-06-11 00:00:00'),
    (3, 'Lead', '2016-06-11 00:00:00');



-- Q-1. Write an SQL query to fetch “FIRST_NAME” from the Worker table using the alias name as <WORKER_NAME>.

select 
  FIRST_NAME as WORKER_NAME 
from 
  Worker;


-- Q-2. Write an SQL query to fetch “FIRST_NAME” from the Worker table in upper case.

select 
  upper(FIRST_NAME) 
from 
  Worker;


-- Q-3. Write an SQL query to fetch unique values of DEPARTMENT from the Worker table.

select 
	distinct DEPARTMENT 
from 
	Worker;


-- Q-4. Write an SQL query to print the first three characters of  FIRST_NAME from Worker table.

select
	left(FIRST_NAME,3) 
from 
	Worker;

-- Q-5. Write an SQL query to find the position of the alphabet (‘a’) in the first name column ‘Amitabh’ from Worker table.

select 
 	position('a' in FIRST_NAME ) 
from 
	Worker
where
	FIRST_NAME='Amitabh';

--or

select 
 	position('a' in 'Amitabh' ) 
from 
	Worker;

-- Q-6. Write an SQL query to print the FIRST_NAME from Worker table after removing white spaces from the right side.

select 
	rtrim(FIRST_NAME)
from
	Worker;


-- Q-7. Write an SQL query to print the DEPARTMENT from Worker table after removing white spaces from the left side.

select 
	ltrim(DEPARTMENT)
from
	Worker;

-- Q-8. Write an SQL query that fetches the unique values of DEPARTMENT from Worker table and prints its length.

select 
	distinct length(DEPARTMENT) 
from 
	Worker;

-- Q-9. Write an SQL query to print the FIRST_NAME from Worker table after replacing ‘a’ with ‘A’.

select 
	replace(FIRST_NAME,'a', 'A')
from 
	Worker;

-- Q-10. Write an SQL query to print the FIRST_NAME and LAST_NAME from Worker table into a single column COMPLETE_NAME. A space char should separate them.

select 
	 FIRST_NAME ||' ' || LAST_NAME as COMPLETE_NAME
from 
	Worker;

-- Q-11. Write an SQL query to print all Worker details from the Worker table order by FIRST_NAME Ascending.

select 
  * 
from 
  Worker 
order by 
  FIRST_NAME;

-- Q-12. Write an SQL query to print all Worker details from the Worker table order by FIRST_NAME Ascending and DEPARTMENT Descending.

select 
  * 
from 
  Worker 
order by 
  FIRST_NAME asc, 
  DEPARTMENT desc;


-- Q-13. Write an SQL query to print details for Workers with the first name as “Vipul” and “Satish” from Worker table.

select 
	* 
from 
	Worker
where 
	FIRST_NAME in ('Vipul', 'Satish');

-- Q-14. Write an SQL query to print details of workers excluding first names, “Vipul” and “Satish” from Worker table.

select 
	* 
from 
	Worker
where 
	FIRST_NAME not in ('Vipul', 'Satish');

-- Q-15. Write an SQL query to print details of Workers with DEPARTMENT name as “Admin”.

select 
	* 
from 
	Worker
where 
	DEPARTMENT = 'Admin';

-- Q-16. Write an SQL query to print details of the Workers whose FIRST_NAME contains ‘a’.

select 
	*
from 
	Worker
where FIRST_NAME like '%a%';

-- Q-17. Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘a’.

select 
	*
from 
	Worker
where RTRIM(FIRST_NAME) like '%a';

-- Q-18. Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘h’ and contains six alphabets.

select 
	*
from 
	Worker
where rtrim(FIRST_NAME) like '_____h';

-- Q-19. Write an SQL query to print details of the Workers whose SALARY lies between 100000 and 500000.

select 
  * 
from 
  Worker 
where 
  SALARY between 100000 
  and 500000;


-- Q-20. Write an SQL query to print details of the Workers who have joined in Feb’2014.

select 
  * 
from 
  Worker 
where 
  JOINING_DATE BETWEEN '2014-02-01' 
  AND '2014-02-28';



-- Q-21. Write an SQL query to fetch the count of employees working in the department ‘Admin’.

select 
  count(DEPARTMENT) 
from 
  Worker 
where 
  DEPARTMENT = 'Admin';

-- Q-22. Write an SQL query to fetch worker names with salaries >= 50000 and <= 100000.

select 
  FIRST_NAME || ' ' || LAST_NAME as Names 
from 
  Worker 
where 
  SALARY >= 50000 
  and SALARY <= 100000;
  
  --OR 

select 
  FIRST_NAME || ' ' || LAST_NAME as Names 
from 
  Worker 
where 
  SALARY between 49999 
  and 100001;
  
-- Q-23. Write an SQL query to fetch the no. of workers for each department in the descending order.

select 
  count(1), 
  Department 
from 
  Worker 
group by 
  Department


-- Q-24. Write an SQL query to print details of the Workers who are also Managers.

select 
  * 
from 
  Worker w 
  join Title t on w.WORKER_ID = t.WORKER_REF_ID 
where 
  WORKER_TITLE = 'Manager';

-- Q-25. Write an SQL query to fetch duplicate records having matching data in some fields of a table.

with cte as (
  select 
    salary 
  from 
    Worker 
  group by 
    salary 
  having 
    count(1)> 1
) 
select 
  * 
from 
  Worker 
where 
  Salary = (
    select 
      * 
    from 
      cte
  )



-- Q-26. Write an SQL query to show only odd rows from a table.

select 
  * 
from 
  Worker 
where 
  WORKER_ID % 2 = 1;

-- Q-27. Write an SQL query to show only even rows from a table.

select 
  * 
from 
  Worker 
where 
  WORKER_ID % 2 = 0;

-- Q-28. Write an SQL query to clone a new table from another table.

create table Worker_copy as 
select 
  * 
from 
  Worker;
  
-- Q-29. Write an SQL query to fetch intersecting records of two tables.
select
	WORKER_ID
from 
	Worker
intersect 
select
	Worker_REF_ID
from
	Bonus;

-- Q-30. Write an SQL query to show records from one table that another table does not have.

select
	WORKER_ID
from 
	Worker
except
select
	Worker_REF_ID
from
	Bonus;

-- Q-31. Write an SQL query to show the current date and time.

select now();

-- Q-32. Write an SQL query to show the top n (say 10) records of a table.

select 
	*
from
	Worker
limit 10;

-- Q-33. Write an SQL query to determine the nth (say n=5) highest salary from a table.

select distinct
	SALARY
from
	Worker
order by SALARY desc
offset 4 limit 1


-- Q-34. Write an SQL query to determine the 5th highest salary without using TOP or limit method.
select 
  distinct SALARY 
from 
  Worker 
order by 
  SALARY desc offset 4;


-- Q-35. Write an SQL query to fetch the list of employees with the same salary.

select 
  w1.WORKER_ID, 
  w1.SALARY, 
  w2.WORKER_ID, 
  w2.SALARY 
from 
  Worker w1, 
  Worker w2 
where 
  w1.salary = w2.salary 
  and w1.WORKER_ID <> w2.WORKER_ID;


-- Q-36. Write an SQL query to show the second highest salary from a table.

select 
  salary 
from 
  Worker 
order by 
  salary offset 2 
limit 
  1

-- Q-37. Write an SQL query to show one row twice in results from a table.
select * from Worker union all select * from Worker;


-- Q-38. Write an SQL query to fetch intersecting records of two tables.

select
	WORKER_ID
from 
	Worker
intersect 
select
	Worker_REF_ID
from
	Bonus;

-- Q-39. Write an SQL query to fetch the first 50% records from a table.

select 
  * 
from 
  Worker 
limit 
  (
    select 
      count(1)/ 2 
    from 
      Worker
  )
  
-- Q-40. Write an SQL query to fetch the departments that have less than five people in it
  
 select 
  count(1), 
  DEPARTMENT 
from 
  Worker 
group by 
  DEPARTMENT 
having 
  count(1)< 5;
  
-- Q-41. Write an SQL query to show all departments along with the number of people in there.
 
  select 
  count(1), 
  DEPARTMENT 
from 
  Worker 
group by 
  DEPARTMENT 
  
-- Q-42. Write an SQL query to show the last record from a table.
  
 select 
  * 
from 
  Worker 
order by 
  WORKER_ID desc 
limit 
  1;
  
-- Q-43. Write an SQL query to fetch the first row of a table.
 
select 
  * 
from 
  Worker 
order by 
  WORKER_ID 
limit 
  1;

-- Q-44. Write an SQL query to fetch the last five records from a table.

 select 
  * 
from 
  Worker 
order by 
  WORKER_ID desc 
limit 
  5;

  
-- Q-45. Write an SQL query to print the name of employees having the highest salary in each department.
 
select 
 MAX (SALARY), DEPARTMENT
from 
  Worker 
group by department; 


  
-- Q-46. Write an SQL query to fetch three max salaries from a table.

select 
  distinct SALARY 
from 
  Worker 
order by 
  SALARY desc 
limit 
  3

  
-- Q-47. Write an SQL query to fetch three min salaries from a table.

select 
  distinct SALARY 
from 
  Worker 
order by 
  SALARY  
limit 
  3  
  
-- Q-48. Write an SQL query to fetch nth max salaries from a table.
select 
  distinct SALARY 
from 
  Worker 
order by 
  SALARY 

-- Q-49. Write an SQL query to fetch departments along with the total salaries paid for each of them.

select 
 SUM (SALARY), DEPARTMENT
from 
  Worker 
group by department; 

-- Q-50. Write an SQL query to fetch the names of workers who earn the highest salary.

with cte as (
  select 
    max(SALARY) 
  from 
    Worker
) 
select 
  * 
from 
  Worker 
where 
  Salary = (
    select 
      * 
    from 
      cte
  );



