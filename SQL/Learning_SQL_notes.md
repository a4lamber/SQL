# OREILLY Learning SQL

> After kindly recommendation by xiaohan, i am gonna systemically learn SQL as the first step with the Oreilly SQL textbook he recommended.

---

# Set-up

In order to set-up the necesary environment, do the following steps. The book recommends to use command-line but not friending for data analyst beginner. Therefore, MySQL Workbench (with GUI) is used in this learning journey.

- [x] download MYSQL and its ide MYSQL Workbench

- [x] select a dataset to work with, download the **sakila data** and start playing around with it localy (since i am in China, cloud-based platform is slow). 
  
  - [x] Download sakila data here [MySQL :: Other MySQL Documentation](https://dev.mysql.com/doc/index-other.html)

- [x] set up the environment and load .sql and schema with MySQL Workbench
  
  - [x] Reference on how to load  [MySQL Import Database using MySQL Workbench - YouTube](https://www.youtube.com/watch?v=uyP46E0UA9I&t=201s)

# Chapter 1. A little background

---

> You need a little bit background on the history of SQL, relational database.

## Intro to databases

First several decades of **computerized database system**

- Nonrelational database systems
  
  - hierarchical database system
  
  - network database system

- Relational model (more modern)
  
  - originated from a paper by IBM in 1970 "A Rela‐
    
    tional Model of Data for Large Shared Data Banks"

# What is SQL?

SQL handles relational database.

## Brief history

After the IBM paper, the arthuo **Dr Codd** prosed a language called **DSL/Alpha**, then a group in IBM build a prototype language called **SQUARE**, then it has been refined to a language **SEQUEL** and fianlly to **SQL**.

## What is MySQL?

Some commerical products handles relational database are: 

- Oracke Database by Oracle Corp

- SQL Server from Microsoft

- DB2 Universal Database by IBM

Some open-source product includes:

- MySQL

- PostgreSQL

New techlogies tailored for big company such as Amazon and Google

- Hadoop, Spark, NoSQL and NewSQL

# Chapter 2 Creating and Populating a Database

---

> This chapter mainly discusses how to construct and what's inside a .sql file including data types and stuff. 

## 2.1 Using the mysql Command-Line

> Use this part later my friend

## 2.2 MySQL Data Types

Most pupolar data types consist of following data types

- strings

- dates (temporal data)

- numbers

- Specialty data types: XML, json and spatial.

The first three will be covered. 

### 2.2.1 Character Data

Character data can be stored as either fixed-length or variable-length strings called CHAR and VARCHAR. Let's see the definition below

> CHAR is a fixed length string data type, so any remaining space in the field is padded with blanks (right-padded). CHAR takes up 1 byte per character. So, a CHAR(100) variable takes up to 100 bytes on disk, regardless of the string it holds. 

As for VARCHAR

> VARCHAR is a variable length string data type, so it holds only the characters you assign to it. VARCHAR takes up 1 byte per character, + 2 bytes to hold length information. For example, if you set a VARCHAR(100) data type = 'Claire', then it would takes up 6 bytes (For C, L, A, I, R, E) plus 2 bytes, 8 bytes in total.

这样比较下来，varchar只消耗额外2 bytes,实在是太便宜了，还能动态控制每一个data的储存空间。Practically speaking, never char.

For longer data, such as email or XML, we gonna use text types (mediumtext and longtext) to store.

#### Character sets

English, using Latin alphabet, only need a single byte to store each character. Other language such as Chinese contains larger number of characters, thus requiring multiple bytes of storage for each characer. Such character  sets are therefore called ***multibyte character sets***.

To view the supported characters sets in your vendor,

```sql
show character set;
```

The default character set is <mark>latin1</mark> for piror version of MySQL, but for the 8.0 version, it uses <mark>utf8mb4</mark>. To manually set characte set before defining a column,

```sql
varchar(20) character set latin1.
```

For more information, you could refer to [Unicode Explained [Book]](https://www.oreilly.com/library/view/unicode-explained/059610121X/)

#### Textdata

varchar has 64KB limit for varchar column. If u over that, you want to use one of the following

| Text type  | Maximum number of bytes |
| ---------- | ----------------------- |
| tinytext   | 255                     |
| text       | 65,535                  |
| mediumtext | 16,777,215              |
| longtext   | 4,294,967,295           |

varchar is 64KB for mySQL 8.0, so tinytext and text has no pratical meaning. When choosing to use one of the text types, you need to be aware that

- If the data being loaded into a text column exceeds the maximum size for that

type, the data will be truncated.

- Trailing spaces will not be removed when data is loaded into the column.

- When using text columns for sorting or grouping, only the first 1,024 bytes are
  
  used, although this limit may be increased if necessary.

- The different text types are unique to MySQL. SQL Server has a single text type
  
  for large character data, whereas DB2 and Oracle use a data type called clob, for
  
  Character Large Object.

### 2.2.2 Numeric Data

> MySQL supports, interger types and floating types.

### 2.2.3 Temporal Data

In MySQL, the following temporal types are supported to handle different cases

| Type      | Default format      | Allowable values |
| --------- | ------------------- | ---------------- |
| date      | YYYY-MM-DD          |                  |
| datetime  | YYYY-MM-DD HH:MI:SS |                  |
| timestamp | YYYY-MM-DD HH:MI:SS |                  |
| year      | YYYY                |                  |
| time      | HHH:MI:SS           |                  |

## 2.3 Table Creation

### Step1: Design

### Step2: Refinement

> Normalzation: A process of ensuring thre are no compound columns in your database design or there are no duplicate (other than foreign keys).

### Step3:Building SQL Schema

Here is an example of defining a table and only tricky part is the last line of code setting a ***primary key constraint***.

```sql
CREATE TABLE PERSON (
    person_id SMALLINT UNSIGNED,
    fname VARCHAR(20),
    lname VARCHAR(20),
    eye_color CHAR(2),
    birth_date DATE,
    street VARCHAR(30),
    city VARCHAR(20),
    state VARCHAR(20),
    country VARCHAR(20),
    postal_code VARCHAR(20),
    CONSTRAINT pk_person PRIMARY KEY (person_id) #define primary key
);
```

You can also set allowable values for certain values. Such constrain is called ***check constraint***. For example, the eye colors are set to be brown, blue or green,

```sql
#MySQL only check but don't enforce
eye_color CHAR(2) check (eye_color IN ('BR','BL','GR'))
#MySQL way to merge check constraint with acatacter data type enum
eye_color ENUM('BR','BL','GR')
```

You could also check the schema for the table, by describing table (desc table)

```sql
desc PERSON #describe the table
```

Now we design favorite_food table,

```sql
create table favorite_food
(person_id smallint unsigned,
food varchar(20),
constraint pk_favorite_food PRIMARY KEY (person_id,food),
constraint fk_fav_food_person_id FOREIGN KEY (person_id)
REFERENCES person (person_id)
);
```

## 2.4 Populating and Modifying Tables

> person and favorite_food tables are created. Now we learn the SQL data statement (四大金刚): insert, update, delete and select.

### 2.4.1 Inserting Data

Insert statement 三要素

- The name of the table

- The names of the columns in the table

- The values with which to populate the column

#### Generating numeric key data (auto_increment)

> B4 inserting data into the PERSON table, it would be useful to discuss how values are generated for numeric primary key.

每一次往table中插入数据，都需要有一次record of insertion, 来记录这一次插入，有两种逻辑

- Look at the largest value currently in the table and add one. 差不多和counter的概念是一样的. i.e. a = a + 1

- Let the database server provide the value for you.

所有的市面上数据库，都提供了一个robust method for doing this. In MySQL, you just need to turn on the auto-increment feature for you primary key column.

> Auto-increment: auto-increment allows a unique number to be generated automatically when a new record is inserted into a table. Often this is primary key field that we would like to be created automatically every time a new record is inderted. 初始时，auto_increment = 1, 每有一个新record, increment by one.

Auto-increation 在两种时候可以设置，one when it is created and another when we alter it afterwards.

```sql
#set auto_increment when created
CREATE TABLE Persons (
    Personid int NOT NULL AUTO_INCREMENT,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int,
    PRIMARY KEY (Personid)
);


#using alter statement
set foreign_key_checks = 0; #disable foreign key constraints
alter table person
    modify person_id smallint unsigned auto_increment; 
set foreign_key_checks = 1; #enable foreign key constraints
```

你必须disable foreign key constraints by setting it to 0 before you alter anything. 我的理解是，foreign key是连接本table和外界table的关系，你想redefine table, 先关闭和其它table的联系再修改，怕万一造成整个linked database的关系.

#### The insert statement

```sql
#inserting one row into the table
insert into person
(person_id,fname,lname,eye_color,birth_date)
values (null, 'adam', 'zhang', 'BL','1993-03-29')
#由于adam zhang是第一次insert record，所以person_id为1，也就是auto-increment
#的default value
```

Notes for insert statement

- 不一定要给address赋值，因为nulls are allowed 

- string '1993-03-29' provided for birth_date column，只要format符合temporal data type的格式，就可以自动转化 (in this case string to date)

Now we inserting into favorite_food table, to tell the db what's adam's favortie

```sql
insert into favorite_food (person_id,food)
values (1,'fried chicken')
```

#### Updating Data

> Remember those column we didn't insert any values in? those null values. We update them!

```sql
#update one person_id
UPDATE person 
SET 
    street = '418 white birch ave',
    city = 'waterloo',
    state = 'ON',
    country = 'Canada',
    postal_code = 'N2L 3V8'
WHERE
    person_id = 1


#update multiple person_id
#where person_id < 5, 1,2,3,4 will be updated.
```

#### Deleting Data

```sql
DELETE FROM person
where person_id = 2;
```

## 2.5 When Good Statements Go Bad

Time for debug

### 2.5.1 Nonunique Primary Key

> 一个萝卜一个坑，一山不容二虎。一个primary key，别进来.

```sql
insert into person
(person_id,fname,lname,eye_color,birth_date)
values (1, 'claire', 'song', 'BL','1994-02-25')
#Error Code: 1062.Duplicate entry '1' for key 'person.PRIMARY'
```

### 2.5.2 Nonexistent Foreign Key

> Foreign key constraints ensure all values of person_id entered into favorite_food table (child) exist in the person table (parent). 

```sql
Insert into favorite_food(person_id,food)
values (999,'lasagna')
#ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint
#fails ('sakila'.'favorite_food', CONSTRAINT 'fk_fav_food_person_id' FOREIGN KEY
#('person_id') REFERENCES 'person' ('person_id'))
```

### 2.5.3 Column Value Violations

```sql
UPDATE person 
SET 
    eye_color = 'zz'
WHERE
    person_id = 1;
#ERROR 1265 (01000): Data truncated for column 'eye_color' at row 1
```

enum data type set a constraint on the values you will be able to put in.

### 2.5.4 Invalid Date Conversions

> Input: string output:date. Make sure the format is correct otherwise you getting an error.

Refer to page 41 (59/380) for more details on temporal data formatting. 

## 2.6 The Sakila Database

Two commands need to be rememered "describe" and "show". Explore this database

```sql
show tables;
desc customers;
```

---

# Chapter 3 Query Primer

## 3.1 The query clause

In SQL, the **selection statemenet** consists of several components/clauses.

| caluse     | Purpose                                                                               |
| ---------- | ------------------------------------------------------------------------------------- |
| `SELECT`   | determine which columns to include in the query's result set                          |
| `FROM`     | identifies the tables from which to retrieve data and how the tables should be joined |
| `WHERE`    | filters out unwanted raw data                                                         |
| `group by` | Used to group rows together by common column values                                   |
| `having`   | filters out unwanted grouped data                                                     |
| `order by` | sorts the rows of the final result set by one or more columns                         |

## 3.2 The select clause

You can either select all columns from actor tables by using $*$

```sql
SELECT *
from sakila.actor
```

or you could select specifc column in actor tables by using their attributes or columne name. If you want to select column, **first__name** and **last__name**, you can do the following

```sql
SELECT first_name,last_name
from sakila.actor 
```

You can also spice things up with the select clause

- Literals, such as numbers or string

- Expression, such as transcation.amount $*$ -1

- Functions
  
  - built in function such as **ROUND(transcation.amount,2)**
  
  - user-defined functions (UDF)

### Common Aliases

> Sometimes, the column name (or arrtributes or label) gets lengthy or confusing. U prob want to get it cleaner. Similar to python, **`import pandas as pd`**

You can do it two ways

- adding a *column alias* after each element of your select clause 中间留空格

- using keyword **AS**

If you want to creat a column of 'Yes' with column name claire_pig_pig. 

The first option goes like

```sql
SELECT 
language_id,
'Rare' language_usage,
'Yes' claire_pig_pig
from 
sakila.language
```

The 2nd option with keyword AS goes like,

```sql
SELECT 
language_id,
'Rare' language_usage,
'Yes' AS claire_pig_pig
from 
sakila.language
```

### Removing Duplicates

> `SELECT DISTINCT` for this purpose. Note: data need to be sorted to get rid of duplicate. Could be time-consuming for huge data set. 

Sometimes, a query might return duplicate rows of data， that's say you query actors last name from a film, you might get duplicate. If you don't want duplicate, then you just need use **DISTINCT** right after SELECT. 

```sql
SELECT DISTINCT actor_id 
FROM sakila.film_actor
order by actor_id
```

## 3.3 The from Clause

> The from clause defines the tables used by a query, along with the means of linking the tables together.

### 3.3.1 Tables

You may picture a table as columns and rows of set data but in reality it is like water.

| Type             | Note                                           | Statement              |
| ---------------- | ---------------------------------------------- | ---------------------- |
| Permanent tables | created using the create table statement       | CREATE TABLE           |
| Derived tables   | rows returned by a subquery and held in memory | 无限套娃 (subquery)        |
| Temporary tables | volatile data held in memory                   | CREATE TEMPORARY TABLE |
| Virtual tables   | created using the "**create view**" statement  | CREATE VIEW            |

#### Derived (subquery-generated)tables

> Using subquery (a query contained in another query) 无限套娃 to generate derived table.

subquery: a query contained in another query. 

Let's say you want to get a derived table called **claire** stored temporarily in query. Claire is the alias of the subquery inside the **parenthesis ()**. 

```sql
SELECT concat(claire.last_name,',',claire.first_name) full_name,
email
FROM
(SELECT first_name,last_name,email
FROM sakila.customer
WHERE first_name = 'JESSIE') claire;
#括号中的subquery是derived table
```

The model output is 

| full_name    | email                           |
| ------------ | ------------------------------- |
| BANKS,JESSIE | JESSIE.BANKS@sakilacustomer.org |
| MILAM,JESSIE | JESSIE.MILAM@sakilacustomer.org |

Could i use join to solve the issue? 

Derived table in this example may not be useful, plz see more details in Chapter 9.

#### Temporary tables

> Temporaray looks like permanent table but it will disappear at the end of transaction or when database is closed or when the session ends.

Create a temporary table named "actors_start_with_j", then insert value into it.

```sql
#Create a temporary table
CREATE TEMPORARY TABLE actors_start_with_j
(actor_id smallint(5),
 first_name varchar(45),
 last_name varchar(45)
 );

 #Insert data into your temporary table
 INSERT INTO actors_start_with_j
 SELECT actor_id, first_name, last_name
 from sakila.actor
 where last_name LIKE 'J%';

 #Select everything from the table
 SELECT * FROM actors_start_with_j;
```

Note: you are gonna have to use the "Excetute the statement under the cursor" while hovering your cursor over the **SELECT** line.

#### Views

> A view is a query that is stored in the data dictionary. Views are created for various reasons, including to hide columns from users and to simplify complex database design.

Let's create a virtual table by view.

```sql
CREATE VIEW cust_vw1 AS
    SELECT 
        customer_id, first_name, last_name, active
    FROM
        customer;

#Select two columns from the virtual table
SELECT 
    first_name, last_name
FROM
    cust_vw1
WHERE
    active = 0
```

### 3.3.2 Table Links

> Table links is used to join multiple table together during SELECT statement.

if more than one table is used, we could link them together with table links. 

The code snippet below do the following, 建立一个3-column table来源于俩table (rental and customer). 输出所有在2005-06-14租车的客户的first name, last name and rental time. 

```sql
SELECT 
    customer.first_name,
    customer.last_name,
    TIME(rental.rental_date) rental_time
FROM
    customer
        INNER JOIN
    rental ON customer.customer_id = rental.customer_id
WHERE
    DATE(rental.rental_date) = '2005-06-14'
```

Joining multiple tables together will be included in Chapter 5 and 10. 

#### 3.3.3 Define table aliases

> Aliases are used to make code cleaner. Two ways to define table alias:
> 
> - claire c
> 
> - claire AS c

Continue use the above code snippet as example but with alias, it is simplied as,

```sql
SELECT 
    c.first_name,
    c.last_name,
    TIME(r.rental_date) rental_time
FROM
    customer c
        INNER JOIN
    rental r ON c.customer_id = r.customer_id
WHERE
    DATE(r.rental_date) = '2005-06-14'
```

Much cleaner isn't it?

## 3.4 The **where** clause

> `Where` is used to filter out unwanted rows in your result set.

The where clause is used to filter out unwanted rows so you could focus on those you care. It is usually used with conditional statement **AND, OR** for string or **>, >=** for numeric value. You could also group conditional statement together with **()** , so it would look like 

```sql
select first_name, last_name
from beautiful_people
where (height = 180 AND last_name = 'zhang')
 OR (height = 160 AND last_name = 'song')
```

This is pretty self-explantory, it would filter out the first and last name of me and claire. 

Haha, let's stick with the sakila database,

```sql
SELECT 
    title
FROM
    film
WHERE
    (rating = 'G' AND rental_duration >= 7)
        OR (rating = 'PG-13' AND rental_duration < 4);
```

## 3.5 The group by and having Clauses

> `group by` ... `having` ...: is used to generate groups of rows, having clause is used to filter grouped data. See more details in chapter 8.

Now we want to retrieve data with some manipulation,

```sql
#return first and last name of customer who rents over 40 movies.
select c.first_name, c.last_name, count(*)
from customer c
inner join rental r
on c.customer_id = r.customer_id
group by c.first_name, c.last_name
having count(*) >= 40
```

| main clause     | clause | function                                        |
| --------------- | ------ | ----------------------------------------------- |
| select ... from | where  | filter unwanted data in the selected columns.   |
| group by        | having | filter unwanted grouped date in groups of rows. |

Study <mark>chapter 8</mark> for more group by and having. 

## 3.6 The order by Clause

> `ORDER BY` clause to sort data either based on raw column data or expressions based on column data (use of built-in function for example).

Recall the query from a code snippet early on, if you want to sort the last name in alphabetical order.

```sql
SELECT 
    c.first_name,
    c.last_name,
    TIME(r.rental_date) rental_time
FROM
    customer c
        INNER JOIN
    rental r ON c.customer_id = r.customer_id
WHERE
    DATE(r.rental_date) = '2005-06-14'
    ORDER BY c.last_name; #Sort by last name
```

For those of you who got a keen eye, you might find it might be confusing when people have the same last name. So,

```sql
SELECT 
    c.first_name,
    c.last_name,
    TIME(r.rental_date) rental_time
FROM
    customer c
        INNER JOIN
    rental r ON c.customer_id = r.customer_id
WHERE
    DATE(r.rental_date) = '2005-06-14'
    ORDER BY c.last_name, c.first_name #sort first by last name, then first name
```

### 3.6.1 Ascending VS Descending

> The default is ascending. When sorting, you could specify <mark>ascending</mark> or <mark>descending</mark> order via `asc` and `desc` keywords with a space in between. 

Sort the example by descending time on 2005-06-14, so we would know who rents car so late at night.

```sql
SELECT 
    c.first_name,
    c.last_name,
    TIME(r.rental_date) rental_time
FROM
    customer c
        INNER JOIN
    rental r ON c.customer_id = r.customer_id
WHERE
    DATE(r.rental_date) = '2005-06-14'
    ORDER BY time(r.rental_date) desc;
```

### 3.6.2 Sorting via Numeric Placeholders

> Pretty much useless feature. ORDER BY x means: order by the x element in select clause. Sort data with reference columns is always better practice than column position. 

Sort by the third element 

```sql
SELECT 
    c.first_name,
    c.last_name,
    TIME(r.rental_date) rental_time
FROM
    customer c
        INNER JOIN
    rental r ON c.customer_id = r.customer_id
WHERE
    DATE(r.rental_date) = '2005-06-14'
    ORDER BY 3 desc;
```

## 3.7 Test questions

Refer to Appendix B for solution.

### Exercise 3-1

Retrieve the actor ID, first name and last name for all actors. Sort by last name and then by first name. 

```sql
#Solution for 3-1
SELECT 
    actor_id, first_name, last_name
FROM
    sakila.actor a
ORDER BY a.last_name , a.first_name;
```

### Exercise 3-2

Retrieve the actor ID, first name, and last name for all actors whose last name equals

'WILLIAMS' or 'DAVIS'.

```sql
SELECT 
    actor_id, first_name, last_name
FROM
    sakila.actor a
WHERE
    (a.last_name = 'williams')
        OR (a.last_name = 'Davis');
```

### Exercise 3-3

Write a query against the rental table that returns the IDs of the customers who ren‐

ted a film on July 5, 2005 (use the rental.rental_date column, and you can use the

date() function to ignore the time component). Include a single row for each distinct

customer ID.

```sql
#Did some extra sorting and select one more column
SELECT DISTINCT
    customer_id, rental_date
FROM
    rental r
WHERE
    DATE(r.rental_date) = '2005-07-05'
order by customer_id;
```

### Exercise 3-4

Fill in the blanks (denoted by <#>) for this multitable query to achieve the following

results:

```sql
#Solution for Exercise 3-4
SELECT 
    c.email, r.return_date
FROM
    customer c
        INNER JOIN
    rental r ON c.customer_id = r.customer_id
WHERE
    DATE(r.rental_date) = '2005-06-14'
ORDER BY r.rental_date DESC;
# positional reference or directly referencing
#ORDER BY 2 DESC
```

# Chapter 4 Filtering

> You usually tend to work with a subset of table's rows.

## 4.1 Condition Evaluation

Normally, you are gonna encouter three conditions in SQL along with parentheses () to tidy things up a bit. 和电路中<mark>与或非门</mark>一样的逻辑 

| Operator | Condition |
| -------- | --------- |
| AND      | 与         |
| OR       | 或         |
| NOT      | 非         |

This part is pretty self-explantory, let's consider the usage of where clause with condition "and" and "or".

```sql
WHERE first_name = 'ZHANG' and birth_date > '1993-03-01'
```

and 

```sql
WHERE first_name = 'ZHANG' or birth_date > '1993-03-01'
```

### Using Parentheses ()

> Interesting, if you are using more than three condions in your where clause (any programming really), you want to include parentheses () to make things neat.

### Using the `not` operator

> Easy for database to handle, but not for everyday john to read your code using operator not. Avoid it if you can!

Let's say if you want to select rows where the dude is born after 1993-03-29 and neither his first name is not "Lebron" nor his last name is not "James"

```sql
#Using OR operator
WHERE NOT (first_name = 'LEBRON' OR last_name = 'JAMES')
AND birth_day > '1993-03-29'


#Neater way 
WHERE first_name <> 'LEBRON' AND last_name <> 'JAMES'
AND 
```

Typically, we prefer the 2nd one, the opearator >, < and <> when used with string, it is calcualted alphabetically. Let's say first_name < 'Lebron', it selected those of whom have the first name before the letter L. The usage of "<>" is equivalent to not operator logically. 

## 4.2 Building a Condition

> Condition = expression + operators 

Comman expressions are:

- A number

- a column in a table or view (refer to 4 types of table)

- A string literal, such as "Lester Street"

- A built-in function, such as concat('Learning', ' ' , 'SQL')

- A subquery (无限套娃)

- A list of expressions, such as ('Waterloo', 'Montreal')

Common operators are

- Comparison operators, such as 
  
  - =,   !=,   <,   >,   <>,   like,   in,  between

- Arithmetic operators
  
  - +,   -,    *,    /

## 4.3 Condition types

> Varous way to filter out unwanted data including specific values, set of values, range of values to include or exclude. Or you can use <mark>pattern-searching techniques</mark> when dealing with string data.

### 4.3.1 Equality Condtions

Look at an example we used in last chapter, where two <mark>equality condtions</mark> are employed.

```sql
SELECT 
    c.email
FROM
    customer c
        INNER JOIN
    rental r ON c.customer_id = r.customer_id #equ condtion with on clause
WHERE
    DATE(r.rental_date) = '2005-06-14'#equ condtion with where clause
```

Naturally, inequality conditions exist. The following code snippet returns emails address of whom rent a movie on any day other than the '2005-06-14'

```sql
#Demonstration of inequlity condtion <>
SELECT 
    c.email
FROM
    customer c
        INNER JOIN
    rental r ON c.customer_id = r.customer_id #equ condtion with on clause
WHERE
    DATE(r.rental_date) <> '2005-06-14'#equ condtion with where clause
```

#### Data modification using equality condtions

> 俗称的删库跑路, 经常用到.

删掉nba_players table中，叫威少的球员

```sql
DELETE FROM nba_players
where first_name = 'Russell' and last_name = 'Westbrook';
```

You won't be able to roll-back in MySQL as it's in auto-commit mode by default. (see chapter 12)

### 4.3.2 Range Conditions

> Common when working with numeric or temporal data but also works for string data.

Range condition works for the following example. 

- Numeric 

- Temporal

- String

Upper an lower limit for range

```sql
#upper an lower limit
SELECT 
    customer_id, rental_date
FROM
    rental
WHERE
    rental_date <= '2005-06-16'#upper limit
        AND rental_date >= '2005-06-14'#lower limit
ORDER BY rental_date;
```

#### The between operator

Addititonally, you could use between operator. It makes more sense to use between and for temporal data while to use upper and lower limit for numeric data.

```sql
#Between operator: BETWEEN lower limit AND upper limit
SELECT 
    customer_id, rental_date
FROM
    rental
WHERE
    rental_date BETWEEN '2005-06-14' AND '2005-06-16'
ORDER BY rental_date

#Between operator 和 arithmatic operator的等效性
SELECT 
    customer_id, rental_date
FROM
    rental
WHERE
    rental_date >= '2005-06-14'#upper limit
        AND rental_date <= '2005-06-16'#lower limit
#This is why lower limit first for between operator
```

#### String ranges

Let's say if you want to search for customers whose last name falls within a range, between FA and FR for example.

```sql
SELECT 
    first_name, last_name
FROM
    customer
WHERE
    last_name BETWEEN 'FA' AND 'FR'
```

But it will have exception such as for <mark>FRANKLIN</mark> since he is out of range. therefore,

```sql
SELECT 
    first_name, last_name
FROM
    customer
WHERE
    last_name BETWEEN 'FA' AND 'FR'
```

### 4.3.3 Membership Conditions

> 和文献阅读时referencing一个道理，当我们引用几篇文献时 [1,2,3]很方便，但随着引用文章数量上升，我们可以用更consise的方法 [1-10]. 这就是membership的概念

There are three following types, using in, subquery and not in.

#### Using <mark>IN</mark> operator

Look at the following code snippet,

```sql
SELECT 
    title, rating
FROM
    film
WHERE
    #rating = 'PG' OR rating = 'G' this is the old way and not scalable
    rating in ('G','PG') 
```

#### Using subqueries

- [x] Not clear on this concept here. Go back later, page 78 (96/380)

Use subquery to define  your own set of expressions!! If your expression is the rating of  movie titles where it contained "PET" (Pre-sumably)

```sql
SELECT 
    title, rating
FROM
    film
WHERE
    rating IN (SELECT 
            rating
        FROM
            film
        WHERE
            title LIKE '%PET%')
```

If you look at the result for the subquery

```sql
SELECT 
    title, rating
FROM
    film
WHERE
    title LIKE '%PET%'
```

It returns 

| title         | rating |
| ------------- | ------ |
| MALKOVICH PET | G      |
| MUPPET MILE   | PG     |
| PET HAUNTING  | PG     |

Then the follwing code

```sql
    rating IN (SELECT 
            rating
        FROM
            film
        WHERE
            title LIKE '%PET%')
    #the above expression is equivalent to the code below (for this case)
    rating in ('G','PG') 
```

#### Using <mark>NOT IN</mark>

Code snippet here. 

```sql
#example using not in
SELECT 
    title, rating
FROM
    film
WHERE
    rating NOT IN ('PG-13' , 'R', 'NC-17')
```

### 4.3.4 Matching Conditions

So far, we learned the condtions that identify 

- exact string 
  
  - WHERE last_name = 'Westbrook'

- a range of strings
  
  - WHERE birth_day between '1994-02-25' and '1993-03-29' 

- a set of strings
  
  - where rating NOT IN ('PG-13','R')

Now, we are gonna be dealing with condition for partial string. 

```sql
#use built-in fcn for partial match
SELECT 
    last_name, first_name
FROM
    customer
WHERE
    LEFT(last_name, 1) = 'Q'
#Pro: quick
#Con: not-flexible. 
```

#### Using wildcard

First of all, the definition of wildcards are:

> Wildcard: A wildcard character is **a special character that represents one or more other characters**. 

从应用的角度, for partial string matches, you would be interested in:

- Strings beginning/ending with a certain character

- Strings begining/ending with a substring

- Strings containing a certain character anywhere within the string

- Strings containing a substring anywhere within the string

- Strings with a specific format, regardless of individual characters

Example wildcards are listed in table below. WILDCARDS are used for search expression.

| Wildcard characters | Matches                                |
|:-------------------:| -------------------------------------- |
| _                   | (underscore) Exactly one character     |
| %                   | Any number of characters (including 0) |

<mark>Note: the definition of percentage is not wut i thought b4. It stands for taking place of a </mark> <mark>variable number of characters.</mark>

Now, if we want to partial match a guy's last name where its 2nd character is A, 4th character is T and ends with character S. 

```sql
SELECT 
    last_name, first_name
FROM
    customer
WHERE
    last_name LIKE '_A_T%S';
```

#### Using regular expresions (regex 正则表达式)

> A regular expression is a search expression on steroids. <mark>regex</mark> is used to extract and match strings of text of anyyyyy kind.<mark></mark>

<mark>Note: thanks for jerry's help for introducing me this concept early on</mark>

For different language, syntax would look different. For SQL with MYSQL server, plz refer to code snippet below. If your search expression is anyone with last name starts with either Q or Y, then 

```sql
SELECT 
    last_name, first_name
FROM
    customer
WHERE
    last_name REGEXP '^[QY]';
```

Refers to here for more info, [Mastering Regular Expressions, 3rd Edition [Book]](https://www.oreilly.com/library/view/mastering-regular-expressions/0596528124/)

## 4.4 Null: That Four-Letter Word

> One null to rule them all, one null to find them, one null to bring them all, and in the darkness bind them;

Null的特点：

- An expression can be *null* , but it never equal *null*

- Two nulls can never equal to each other

Null could stand for multiple situations:

- Not applicable

- Value not yet known

- Value undefined

To test if an expression is *null* or not *null*

```sql
#select whether return_date is NULL (still renting)
SELECT 
    rental_id, customer_id
FROM
    rental
WHERE
    return_date IS NULL;

#select ones is not null
SELECT 
    rental_id, customer_id, return_date
FROM
    rental
WHERE
    return_date IS NOT NULL;
```

### Null pitfall

> Queston: you are asked to find all rentals that were not returned during May through August of 2005.

The result set should contains:

- Customer return their return during this period

- Customers never returns A.K.A. null

The solution should be:

```sql
SELECT 
    rental_id, customer_id, return_date
FROM
    rental
WHERE
    return_date IS NULL
        OR return_date BETWEEN '2005-05-1' AND '2005-09-01'
```

Always keep in mind that null could be inside column.

## 4.5 Test questions

### Exercise 4-1

Which of the payment IDs would be returned by the following filter conditions?

*customer_id <> 5 AND (amount > 8 OR date(payment_date) = '2005-8-23')*

Solution:

payment id: 101, 107

### Exercise 4-2

Which of the payment IDs would be returned by the following filter conditions?

*customer_id = 5 AND NOT (amount > 6 OR date(payment_date) = '2005-06-19')*

Solution:

108,110,111,112,113,115,116,117,118,119,120

### Exercise 4-3

Construct a query that retrieves all rows from the payments table where the amount

is either 1.98, 7.98, or 9.98.

```sql
SELECT 
    *
FROM
    payment
WHERE
    amount IN (1.98 , 7.98, 9.98) 
```

### Exercise 4-4

Construct a query that finds all customers whose last name contains an A in the sec‐

ond position and a W anywhere after the A.

```sql
#using wildcard
SELECT 
    *
FROM
    customer
WHERE
    last_name LIKE '_A%W%' 

#using regex
```

---

# Chapter 5 Querying Multiple Tables

- [x] what is normalization discussed in chapter 2??
  - [x] It is a process to decompose all compound column. For example, address is a compound column consists of street, city, province, country and postal code.

## 5.1 What is a join?

> When u querying more tables, you need join them by key.

### 5.1.1 Cartesian Product (cross join)

The demonstration of using <mark>join clause</mark> to extract values from two tables are shown in code snippet below. Since we don't have any specification, it returns cartesian product.This type of join is called cross join (rarely used, on purpose at least).

```sql
#Demonstration of cartesian product
SELECT 
    c.first_name, c.last_name, a.address
FROM
    customer c
        JOIN
    address a;

#599 customers and 603 rows in address table. The result table has 361,197 row
#361,197 = 599 x 603 (permutation of two tables A.K.A. cartesian product)
```

### 5.1.2 Inner joins

A slight modification is added with the inclusion of address.id which tells the SQL how two tables shoule be linked. 

```sql
SELECT 
    c.first_name, c.last_name, a.address
FROM
    customer c
        JOIN
    address a ON c.address_id = a.address_id
#result size: 599 which is same as customer number
```

However, in good pratice, you should specity the join type here. (default is inner join if join on has been specified) By chaning it to,

```sql
SELECT 
    c.first_name, c.last_name, a.address
FROM
    customer c
        INNER JOIN
    address a ON c.address_id = a.address_id
```

<mark>Note:</mark> the exception is that if address_id only exist in customer table, not in address table. The result will be excluded with <mark>inner join</mark> type but those excluded rows would show up by doing <mark>outer join</mark>.

To summarize so far,

| Type       | Application                                                          |
| ---------- | -------------------------------------------------------------------- |
| cross join | Rarely used                                                          |
| Inner join | Most common type. Preferred to use <mark>inner join ... on...</mark> |
| Outer join | Explored in chapter 10                                               |

### 5.1.2 The ANSI Join Syntax

> All major databases (Oracle, Microsoft SQL, IBM) uses SQL92 version of the ANSI SQL standard. At least for join syntax, it is same.

#### ANSI join syntax vs SQL92 join syntax

```sql
#SQL92 Join Syntax
SELECT 
    c.first_name, c.last_name, a.address
FROM
    customer c
        INNER JOIN
    address a ON c.address_id = a.address_id
WHERE
    a.postal_code = 52137;


#ANSI join syntax
SELECT 
    c.first_name, c.last_name, a.address
FROM
    customer c,
    address a
WHERE
    c.address_id = a.address_id
        AND a.postal_code = 52137;
```

The different is summarized in the tale below 

|                | Ansi                                                   | SQL92                     |
| -------------- | ------------------------------------------------------ | ------------------------- |
| Join condition | condition is in where (confused with filter condition) | inner join...on... clause |

To summarize, SQL92 join syntax better.

## 5.2 Joining >= 3 tables

Please see EER diagram to find the relationship between city, address and customer table.

```sequence
Title: relation between tables
City->Address: city_id 
Address->Customer: address_ID 
```

The logic is here

- We want column data from city and customer 

- City and cutomer table are not directly linked 

- We need a 中间商 (address) to do the job

```sql
#demonstration of joining three tables
SELECT 
    c.first_name, c.last_name, ct.city
FROM
    customer c
        INNER JOIN
    address a ON c.address_id = a.address_id
        INNER JOIN
    city ct ON a.city_id = ct.city_id
```

Since SQL is a non-proecdural language, so order doesn't matter when you using three tables with two inner join clause and on subcaluse. SQL will decide the way it interprets.

> If you have a preferred order to join (for optimization purpose for instance, refer to page 95 Orilley textbook.)

### 5.2.1 Using Subqueries as Tables

Customer table is inner-joining subquery table with alias addr as shown below,

```sequence
customer->subquery(addr): address_id 
```

```sql
SELECT 
    c.first_name, c.last_name, addr.address, addr.city
FROM
    customer c
        INNER JOIN
    (SELECT 
        a.address_id, a.address, ct.city
    FROM
        address a
    INNER JOIN city ct ON a.city_id = ct.city_id
    WHERE
        a.district = 'California') addr #addr is alias
ON c.address_id = addr.address_id;
```

### 5.2.2 Using the Same Table Twice

Let's take a look at ERR again searching for the relationship among the following three tables film, film_actor and actor. It is linked as illustrated in the sequence graph beblow with film, film_actor and actor table aliased as f, fa and a respectively.

```sequence
film->film_actor: film_id
film_actor->actor: actor_id
```

Therefore, if u wanna write a query to find all of the films which two specific actors appeared.

```sql
#Find film either "cate mcqueen" or "cuba birch" appear
SELECT 
    f.title
FROM
    film f
        INNER JOIN
    film_actor fa ON f.film_id = fa.film_id
        INNER JOIN
    actor a ON fa.actor_id = a.actor_id
WHERE
    ((a.first_name = 'CATE' AND a.last_name = 'MCQUEEN')
        OR (a.first_name = 'CUBA' AND a.last_name = 'Birch'));
```

However, let’s say that you want to retrieve only those films in which both of these

actors appeared. **To accomplish this, you will need to find all rows in the film table**

**that have two rows in the film_actor table, one of which is associated with Cate**

**McQueen, and the other associated with Cuba Birch**. Therefore, you will need to

include the film_actor and actor tables twice, each with a different alias so that the

server knows which one you are referring to in the various clauses:

```sequence
film->fa1: film_id
fa1->a: actor_id
film-->fa2: film_id
film-->a2: actor_id
```

Then the code is,

```sql
SELECT 
    f.title
FROM
    film f
        INNER JOIN
    film_actor fa1 ON f.film_id = fa1.film_id
        INNER JOIN
    actor a1 ON fa1.actor_id = a1.actor_id
        INNER JOIN
    film_actor fa2 ON f.film_id = fa2.film_id
        INNER JOIN
    actor a2 ON fa2.actor_id = a2.actor_id
WHERE
    ((a1.first_name = 'CATE' AND a1.last_name = 'MCQUEEN')
        AND (a2.first_name = 'CUBA' AND a2.last_name = 'Birch'));
```

## 5.3 Self-Joins

> Pre-req: for this section, get urself familar with the reference b4 going any further.

- [x] Refresh myself on the topic "foreign key" and "primary key"
  
  - [x] Check out this [Difference between Primary Key and Foreign Key - GeeksforGeeks](https://www.geeksforgeeks.org/difference-between-primary-key-and-foreign-key/)
  
  - [x] Also this [SQL FOREIGN KEY Constraint](https://www.w3schools.com/sql/sql_foreignkey.asp)

 

Table joins itself happens in the scenerio when the table includes a self-referencing foreign key.

> Self-referencing foreigh key: It includes a column that points to the primary key within the same table.

If you are trying to output all movies that have a sequel, it should look like this (在sakila数据库中没有这样的例子), such self-referencing key in this case is called <mark>prequel_film_id</mark> in child table (child) referring to film_id (parent)

```sql
SELECT 
    f.title, f_prnt.title prequel #prequel is column name
FROM
    film f
        INNER JOIN
    film f_prnt ON f_prnt.film_id = f.prequel_film_id
WHERE
    f.prequel_film_id IS NOT NULL;
```

The output should look something like this:

| title                                         | prequel                                            |
|:---------------------------------------------:|:--------------------------------------------------:|
| The Lord of the Rings: The Return of the King | The Lord of the Rings: The Two Towers              |
| The Lord of the Rings: The Two Towers         | The Lord of the Rings: The Fellowship of the Rings |

## 5.4 Test questions

### Exercise 5-1

Fill in the blanks (denoted by <#>) for the following query to obtain the results that

follow:

```sql
#Exercise 5-1 Solution
SELECT 
    c.first_name, c.last_name, a.address, ct.city
FROM
    customer c
        INNER JOIN
    address a ON c.address_id = a.address_id
        INNER JOIN
    city ct ON a.city_id = ct.city_id
WHERE
    a.district = 'california';
```

### Exercise 5-2

Write a query that returns the title of every film in which an actor with the first name

JOHN appeared.

```sql
#Solution
SELECT 
    f.title, a.first_name
FROM
    film f
        INNER JOIN
    film_actor fa ON f.film_id = fa.film_id
        INNER JOIN
    actor a ON a.actor_id = fa.actor_id
WHERE
    a.first_name = 'JOHN'
#double checked by outputting 2nd column of first name
```

### Exercise 5-3❌

Construct a query that returns all addresses that are in the same city. You will need to

join the address table to itself, and each row should include two different addresses.

```sql
#Solution 5-3
SELECT 
    a1.address, a2.address,a1.city_id,a2.city_id
FROM
    address a1
        INNER JOIN
    address a2 ON a1.city_id = a2.city_id
WHERE
    a1.city_id IS NOT NULL
```

I did wrong. The correct answer is illustrated in the code snippet where filtering has been added to make sure each row should include two different addresses.

```sql
SELECT 
    a1.address, a2.address, a1.city_id, a2.city_id
FROM
    address a1
        INNER JOIN
    address a2 ON a1.city_id = a2.city_id
WHERE
    a1.address_id != a2.address_id
    #a1.address_id <> a2.address_id
```

---

# Chapter 6 Working with Sets

> 这不就是Venn diagram吗？Learn how to use ***<u>union</u>***, ***<u>intersect</u>*** and <u>***except.***</u> 

## 6.1 Set Theory Primer

for the mystery date set, it could be one of the follow or more

- (A except B) union (B except A)

- (A union B) except (A intersect B)

- (A except (A intersect B)) union (B except (A intersect B)) 

## 6.2 Set Theory Practice

Rule of applying set operation on two data sets:

- Both data sets must have the same number of columns

- The data types of each column across the two data sets must be the same (or the server must be able to convert one to the other.)

```sql
#union two columns (numeric and string)
SELECT 1 num, 'abc' str 
UNION SELECT 2 num, 'zyx' str
```

## 6.3 Set Operators

> SQL set operators: union, intersect and except. 

### 6.3.1 The union operator

| Type      | Function                                      |
| --------- | --------------------------------------------- |
| UNION     | Sort the combined set and removes duplicates. |
| UNION ALL | do not sort and remove                        |

For example, we generate a set of first name and last name from two tables:

```sql
SELECT 
    'CUST' typ, c.first_name, c.last_name
FROM
    customer c 
UNION ALL 
SELECT 
    'ACTR' typ, a.first_name, a.last_name
FROM
    actor a
```

ANOTHER Example of <mark>union all</mark>,

```sql
SELECT 
    c.first_name, c.last_name
FROM
    customer c
WHERE
    c.first_name LIKE 'J%' AND c.last_name LIKE 'D%' 
UNION ALL SELECT 
    a.first_name, a.last_name
FROM
    actor a
WHERE
    a.first_name LIKE 'J%' AND a.last_name LIKE 'D%'
```

In reality, some customers might be actor or just  happen to have same name. That's why we would use <mark>union</mark> as shown below

```sql
SELECT 
    c.first_name, c.last_name
FROM
    customer c
WHERE
    c.first_name LIKE 'J%'
        AND c.last_name LIKE 'D%' 
UNION
SELECT 
    a.first_name, a.last_name
FROM
    actor a
WHERE
    a.first_name LIKE 'J%'
        AND a.last_name LIKE 'D%'
```

### 6.3.2 The intersect operator

> MySQL 8.0 doesn't support ***intersect*** although it is included in the ANSI SQL specification. 出门左转找Oracel 或者 SQL Server 2008 if u wanna play around with this command.

### 6.3.3 The except operator

> MySQL 8.0 doesn't have it broooooo.

## 6.4 Set Operation Rules

> The following sections outline some rules that you mush follow when working with compound queries.

### 6.4.1 Sorting Compound Query Results

> Compound Query: A query that uses set operator.

If compound query uses more than two set operators, then you need to consider the order you place.

### 6.4.2 Set operation precedence

The general rule is top to bottom with two exceptions:

- The ANSI SQL specification calls for the intersect operator to have precedence over the othet  set operators
  
  - 优先级：intersect > union = union all = except = except all
  
  - wut about: intersect VS intersect all???

- You could control the order by enclosing queries in parantheses.

 

## 6.5 Short summary

For set operations,

| Type          | MySQL 8.0 | Oracle | SQL Server 2008 | IBM's DB2 Universal Server |
| ------------- | --------- | ------ | --------------- | -------------------------- |
| UNION         | ✅         | ✅      | ✅               | ✅                          |
| UNION ALL     | ✅         | ✅      | ✅               | ✅                          |
| INTERSECT     | ❌         | ✅      | ✅               | ✅                          |
| INTERSECT ALL | ❌         | ✅      | ✅               | ✅                          |
| EXCEPT        | ❌         | ✅      | ✅               | ✅                          |
| EXCEPT ALL    | ❌         | ❌      | ❌               | ✅                          |

From the author's book, the availability is summarized in the table above, but newer version might be difference or the ANSI specification could be updated throughout the year.

## 6.6 Test Questions

### Exercise 6-1

If set A = {L M N O P} and set B = {P Q R S T}, what sets are generated by the follow‐

ing operations?

- A union B
  
  - {L M N O P Q R S T}

- A union all B
  
  - {L M N O P P Q R S T}

- A intersect B
  
  - {P}

- A except B
  
  - {L M N O}

### Exercise 6-2

Write a compound query that finds the first and last names of all actors and customers whose last name starts with L.

> Partial pattern searching with like clasue and wildcard characters will do the gig.

```sql
SELECT 
    c.first_name, c.last_name
FROM
    customer c
WHERE
    c.last_name LIKE 'L%'
UNION
SELECT 
    a.first_name, a.last_name
FROM
    actor a
WHERE
    a.last_name LIKE 'L%'
order by 2,1;
```

Note: you need define alias name for column for sorting them with order by with column name instead of position. Also no need to use alias here, since we doing set operation instead of joining.

### Exercise 6-3

Sort the results from Exercise 6-2 by the last_name column.

<mark>Implemented in Exercise 6-2.</mark>

---

# Chapter 7 Data Generation, Manipulation and Conversion

> SQL lanaguage doesn't provide ways to deal with data generation, manupulation of string, numeric and temporal data but built-in functions from different servers vendor would solve this. 

## 7.1 Working with String Data

### 7.1.1 String Generation

> 略

为了学习这一个chapter, 我们建立一个string_chap7 table,然后赋值

```sql
CREATE TABLE string_chap7 (
    char_fld CHAR(30),
    vchar_fld VARCHAR(30),
    text_fld TEXT
);

insert into string_chap7 (char_fld,vchar_fld,text_fld)
values ('This is char data',
'This is varchar data',
'This is text data'
);
```

#### Including single quotes

what if your string has single quote's in it? Let's say

```sql
#wrong way of inserting
UPDATE string_chap7
set text_fld = 'This string doesn't work'
#连高亮都错了，没法识别
```

The work-around that allow you to escape a single quote by adding another single quote or backslash directly b4, as in:

```sql
#work-around 1
UPDATE string_chap7
set text_fld = 'This string doesn''t work, jkkkkk';


#work-around 2
UPDATE string_chap7
set text_fld = 'This string doesn\'t work, jkkkkk';
```

Also, you could use built-in function quote(str)

> quote(str): Quotes a string to product a result can be used as a properly escaped data value in an SQL statement. 应用场景为since using quote() to retrieve the entire string and automatically add escapes to any single quote/apostrophes within the stirng.

Example

```sql
select quote('claire''s little babe')
#return 'claire\'s little babe'
```

#### Including special characters

> Get back to this when i encounter with é and ö from german or french.

## 7.1.2 String Manupulation

> In this subsection, we gonna learn two types of string function. Type1: take string return numbers. Type2: take string return string

为了学习下面subsection, we do this

```sql
delete from string_chap7

insert into string_chap7 (char_fld,vchar_fld,text_fld)
values ('This string is 28 characters',
'This string is 28 characters',
'This string is 28 characters'
);
```

#### String functions that return numbers

> length(string): return number of characters inside the string.

```sql
SELECT 
    LENGTH(char_fld) char_length,
    LENGTH(vchar_fld) char_length,
    LENGTH(text_fld) char_length
FROM
    string_chap7
```

> position(): search the first letter of the substring and return the position of substring by returning the location of first character in the substring if found, else return 0.

如果你想找到location of the substring, use position(). If no match availble, it returns 0. 

```sql
SELECT 
    POSITION('characters' IN vchar_fld)
FROM
    string_chap7
```

Note: for SQL language, it is like matlab. The position of characters start at 1.

> locate(substring, where to search, starting_position): 

```sql
SELECT 
    LOCATE('is', vchar_fld, 5)
FROM
    string_chap7
```

> strcmp(): takes two strings as input arguments and returns one of the following:
> 
> - -1 if the first string comes before the second string in sort order
> 
> - 0 if the strings are identical
> 
> - 1 if the first string comes after the 2nd string in sort order

The example is 

```sql
#not important atm.
#refer to page 124 (142/380)
```

Similarly, there are other ways we have learnt to compare string such as ***<mark>like*** </mark>clause and <mark>regular expression.</mark>

```sql
#exampe of using like clause to compare string
#return 0,false, return 1, true
SELECT 
    name, name LIKE '%y' ends_in_y
FROM
    category
```

上面就是一些input string output number的例子, 没想到like clause 还可以用在这里.

#### String functions that return strings

> concat(): concatenate string

```sql
SELECT 
    CONCAT(first_name,
            '',
            last_name,
            ' has been a loyal customer since ',
            DATE(create_date)) cust_narrative
FROM
    customer;
```

It is very similar what's encountered in python for string concatenation 

```python
a = 'zhang'
b = 'yixiang'
space = ' '
c = a + space + b
print(c)
#return zhang yixiang
```

concat() is good at adding string at the end of a string. What if you want to add string into the middle of another stirng? WE HAVE insert() for you!

> insert('string_1',position_1, position_2,'string_2'): insert() takes four arguments. It could be used to insert string or replace whole or partial string if done carefully.
> 
> - string_1:  original string
> 
> - position_1: 插在第几个character
> 
> - position_2: number of characters to replace
> 
> - string_2: replacement string 

```sql
#insert string (replace nothing)
select insert('goodbye world',9,0,'cruel ') string
#return "goodbye cruel world"

#replace partial string
select insert('goodbye world',9,1,'cruel ') string
#return "goodbye cruel orld"

#replace whole string
SELECT INSERT('goodbye world', 1, 7, 'hello') string;
#return "hello world"
```

## 7.2 Working with Numeric Data

> Basic arithmetic operator (+,-,*,/) and paranthese for precedence are just like other language. Unlike python where data type is determined at run-time, you don't need to worry so much about the truncation or rounding when stored. You do care about data type in SQL.

### 7.3.1 Performing Arithmetic Functions

> Very straight-forward. 略

### 7.3.2 Controlling Number Precision

> 老样子，四大金刚
> 
> - ceil(): round up to closest integer
> 
> - floor(): round down to closest integer
> 
> - round(): round up or down from midpoint between two integers. (四舍五入) 2nd argument is optional and it tells numbers to the right of decimal place are rounded.
>   
>   - round(72.5) = 73
>   
>   - round(72.0909,2) = 73.09
>   
>   - round(79,-1) = 80
> 
> - truncate(): truncate number according to the 2nd input argument
>   
>   - truncate(72.0909,1) = 72.0
>   
>   - truncate(79,-1) = 70

### 7.3.3 Handling Signed Data

> Use of SIGN() and ABS()

## 7.3 Working with Temporal Data

> Temporal data是重头戏

### 7.3.1 Dealing with Time Zones

A bit history, to ensure a common point of reference for timekeeping, 15-th century navigators set their clocks to the time of day in Greenwich, England. It is known as ***Greenwich Mean Time (GMT).*** Now, it is replacing by a variation of GMT called ***Coordinated Universal Time (UTC).*** 

> utc_timestamp() or utc_timestamp: return the current UTC timestamp. These two are almost the same. For exact differnce, 
> 
> - [MySQL UTC_TIMESTAMP() function - w3resource](https://www.w3resource.com/mysql/date-and-time-functions/mysql-utc_timestamp-function.php) 

### 7.3.2 Generating Temporal Data

You could generate temporal data via any of the following means:

- Copying data from an existing date, datetime or time column

- Executing a built-in function that returns a date, datetime, or time

- Building a string representation of the temporal data to be evaluated by the server.

#### String-to-date conversions

> cast(): one way to assign string to date.

```sql
select cast('2022-05-02 20:44:00' as datetime)
```

or you could assign it to date and time seperately,

```sql
SELECT 
    CAST('2022-05-02' AS DATE) date_field,
    CAST('20:44:00' AS TIME) time_field
```

<mark>Note: Unlike table alias, as is not optional!</mark>

#### Functions for generating dates

> cast() sucks! 由于需要关注string的格式符合temporal data的格式，pain in the ass the work with. We use built-in functions.

The loved built-in function is,

> STR_TO_DATE():

```sql
UPDATE rental
SET return_date = STR_TO_DATE('September 17,2019','%M %d, %Y')
where rental_id = 99999;
```

where %M: a month name, %d: a numeric day, %Y: a four-digit numeric year

For more supported date format components, plz refer to page 139 (157/380).

如果你想得到现在的时间，更好办

> current_date(), current_time() and current_timestamp() 

```sql
select current_date(),current_time(),current_timestamp()
#MySQL 8.0 中不存在 current_datetime()别搞错了
```

### 7.3.3 Manipulating Temporal Data

#### Temporal functions that return dates

> date_add(): add any kind of interval to a specified date to generate another date. It takes in four arguments, 
> 
> - original date
> 
> - INTERVAL keyword
> 
> - desired quantity
> 
> - interval types (or unit)

```sql
SELECT DATE_ADD(CURRENT_DATE(), INTERVAL 5 DAY)
```

| Interval      | Description                                                                       |
| ------------- | --------------------------------------------------------------------------------- |
| second        | number of seconds                                                                 |
| minute        | number of minutes                                                                 |
| hour          | number of hours                                                                   |
| day           | number of days                                                                    |
| month         | number of months                                                                  |
| year          | number of years                                                                   |
| minute_second | number of minutes and seconds, separated by ":"                                   |
| hour_second   | number of hours, minutes, and seconds, separated by ":" 比如 三小时10分钟，23秒    3:10:23 |
| year_month    | number of years and months, separated by"-" 比如1-3                                 |

Also, it is pretty need to find the last day of each month with last_day(). 比如你每月月底会收到你的bank e-statement就可以通过这种方式获得时间

> last_day(): return the last day of the input month

```sql
select last_day(current_date)
```

#### Temporal functions that return strings

> extract(): extracting information from date values.

```sql
SELECT EXTRACT(YEAR FROM '2019-09-18 22:19:05');
```

#### Temporal functions that return numbers

> datediff('time1','time2'): self-explantory

```sql
SELECT DATEDIFF('2019-09-03', '2019-06-21');
```

## 7.4 Conversion Functions

> 略

## 7.5 Test Questions

### Exercise 7-1❌

Write a query that returns the 17th through 25th characters of the string 'Please

find the substring in this string'.

```sql
SELECT SUBSTRING('Please find the substring in this string',17,9);
```

Didn't know this built-in function.

### Exercise 7-2

Write a query that returns the absolute value and sign (−1, 0, or 1) of the number

−25.76823. Also return the number rounded to the nearest hundredth.

```sql
SELECT sign(-25.76823) sign, abs(-25.76823),2 abs, round(-25.76823,2) round
```

### Exercise 7-3

Write a query to return just the month portion of the current date.

```sql
SELECT EXTRACT(Month FROM current_timestamp());
```

---

# Chapter 8 Group and Aggregates

## 8.1 Group Concepts

Let's say your task if to give free rentals to your best customers.

```sql
select cutstomer_id from rental

#remove duplicates
select distinct cutstomer_id from rental
```

It retruns more than 16,000 rental records with only 599 customers. You could use select distinct to remove duplicates. But you could also ask the database to group by data using `group by` clause.

> group by: a type of cluase that is used to group data by certain condition.

```sql
SELECT 
    customer_id
FROM
    rental
GROUP BY customer_id
```

But we still miss information on who rented the most movies! Since we already group the data with group by clause, we could then use an ***<mark>aggregate function</mark>*** in the `select` clause to count the number of rows in each group. 

> `count(*)`: aggregate function. to count the number of rows in each group. used together with group by.

```sql
SELECT 
    customer_id, COUNT(*) total
FROM
    rental
GROUP BY customer_id
ORDER BY total DESC #sort the total column descendingly
```

Now, the 2nd column named total contain information on how many ordered.

#### 优先级:group by, where and having

> 由于`where`优先级比`group by`高，所以你只能group by filtered raw data. 但有些应用场景，你需要filter grouped data by result set.这时候我们引入一个新clause, `having `clause.

```sql
SELECT 
    customer_id, COUNT(*)
FROM
    rental
WHERE
    COUNT(*) >= 40 #can't use aggregate fcn since not grouped by yet
GROUP BY customer_id

#error code:111. Invalid use of group function
```

> having: filter condition by group data.

```sql
SELECT 
    customer_id, COUNT(*)
FROM
    rental
GROUP BY customer_id
HAVING COUNT(*) >= 40 #cutoff 
```

## 8.2 Aggregate Functions

> Aggregate functions are used in conjuction with grouped data (explicit or implicit)
> 
> Common aggregate functions:
> 
> max(): return the maximum value within a set
> 
> min(): returns the minimum value within a set
> 
> avg(): returns the average valuse across a set
> 
> sum(): returns the sum of the values across a set
> 
> count(): returns the sum of the value across a set

```sql
#找到所有payment table中，amount的max, min
#implicit groups
SELECT 
    MAX(amount) max_amt,
    MIN(amount) min_amt,
    AVG(amount) avg_amt,
    SUM(amount) tot_amt,
    COUNT(*) num_payments
FROM
    payment
```

### 8.2.1 Implicit vs Explicit Groups

用`group by`的就是explicit group，反之就是implicit.

```sql
#找到每个customer_id的max, min etc
#explicit groups
SELECT 
    customer_id,
    MAX(amount) max_amt,
    MIN(amount) min_amt,
    AVG(amount) avg_amt,
    SUM(amount) tot_amt,
    COUNT(*) num_payments
FROM
    payment
GROUP BY customer_id;
```

### 8.2.2 Counting Distinct Values

Similar to <mark>***select***</mark> clause and its option ***<mark>select distinct</mark>***, count() function has similar option,

> `count`(input): counting all members in the group
> 
> `count`(distinct input): counting only distinct values in the group

```sql
SELECT 
    COUNT(customer_id) num_rows, COUNT(DISTINCT customer_id)
FROM
    payment
```

但后台是如何计算的呢，这一类count-distinct problem的时间复杂度为$O(N)$

比如说用hyperloglog:  calculating the cardinality of a set. 把one set of data

- convert each number in the set to its binary representation

- find the number of trailing zero

Plz see the reference for more details. 

https://amitj975.medium.com/an-efficient-way-of-calculating-distinct-count-over-a-data-hyperloglog-a7481f0fcf3d

### 8.2.3 Using Expressions

aggregate functions的argument可以是columns,也可以是一个expression,

> `datediff`(date_1,date_2): is used to compute the number of days between the date_1 and date_2. The first argument minus the second argument.

Example,

```sql
#max()的argument为一个expression
SELECT 
    MAX(DATEDIFF(return_date, rental_date))
FROM
    rental
```

See more details on expression in Chapter 11 (case expressions with aggregate functions). 

### 8.2.4 How Nulls Are Handled

Now we create a dummy table number_tbl,

> `values` keyword: the `values` command specifies the values of an INSERT INTO statement.
> 
> example: insert into table_name values (argument)

```sql
CREATE TABLE number_tbl (
    val SMALLINT
)

insert into number_tbl values(1)

insert into number_tbl values(2)

insert into number_tbl values(3)

select * from number_tbl
```

#### Without NULL

```sql
SELECT 
    COUNT(*) num_rows,
    COUNT(val) num_vals,
    SUM(val) total,
    MAX(val) max_val,
    AVG(val) avg_val
FROM
    number_tbl;
```

the output is: 

| num_rows | num_vals | total | max_val | avg_val |
| -------- | -------- | ----- | ------- |:-------:|
| 3        | 3        | 9     | 5       | 3.0000  |

#### With NULL

We insert the null then rerun the code snippet

```sql
insert into number_tbl values (null)

SELECT 
    COUNT(*) num_rows,
    COUNT(val) num_vals,
    SUM(val) total,
    MAX(val) max_val,
    AVG(val) avg_val
FROM
    number_tbl;
```

The output is

| num_rows | num_vals | total | max_val | avg_val |
| -------- | -------- | ----- | ------- |:-------:|
| 4        | 3        | 9     | 5       | 3.0000  |

From the observation,max(), avg() and sum() ignores the null when encountered. count(*) which simply counts number of rows will count the null contains null value. However, count(val) will ignore any null value in val column.

## 8.3 Generating Groups

In this section, you will learn grouping data with group by clause,

- [x] group data by one column 

- [x] group data by multiple columns

- [x] group data by expression

- [x] generate rollups

### 8.3.1 Single-Column Group

Very self-explantory

```sql
SELECT 
    actor_id, COUNT(*)
FROM
    film_actor
GROUP BY actor_id
```

### 8.3.2 Multicolumn Grouping

Let's say if you want to find the total number of films for each film rating (G,PG,...) for each actor,

First, we join data from two tables to obtain each combination of actor and film rating (actor和film rating的所有排列组合).

```sql
SELECT 
    fa.actor_id, f.rating
FROM
    film_actor fa
        INNER JOIN
    film f ON fa.film_id = f.film_id
ORDER BY 1 , 2;
```

> 小知识: relational database is huge. analyst have a constant need to extract records from two or more table based on certain conditions. This is why we need JOINs. 
> 
> JOINS are used to retrieve data from multiple tables in a single query. More details in chapter 10.

这里我们需要

- 每个actor_id from film_actor table

- 每个rating from film table

- Joined by foreign key : film_id

Then we group them based on actor_id and rating,

```sql
SELECT 
    fa.actor_id, f.rating, COUNT(*)
FROM
    film_actor fa
        INNER JOIN
    film f ON fa.film_id = f.film_id
GROUP BY fa.actor_id , f.rating
ORDER BY 1 , 2;
```

> Note: If u select two columns (columns with aggregate fcn not included), u gonna have to group by two sets of data.

### 8.3.3 Grouping via Expressions

比如说你的supervisor想统计，每年rental的数量, 看看哪年比较旺，

```sql
SELECT 
    EXTRACT(YEAR FROM rental_date) year, COUNT(*) how_many
FROM
    rental
GROUP BY EXTRACT(YEAR FROM rental_date)
```

### 8.3.4 Generating Rollups

In 8.3.2, we calculated 每个演员出演每个不同限制级的作品数量

| actor_id | rating | count(*) |
| -------- | ------ |:--------:|
| 1        | G      | 4        |
| 1        | PG     | 6        |
| 1        | PG-13  | 1        |
| 1        | R      | 3        |
| 1        | NC-17  | 5        |

比如说我现在想sum一下，actor_id = 1的演员，一共出席了多少, simply with another keyword rollup

> `GROUP BY ... WITH ROLLUP` clause: The `rollup` is an extension of `group by` clause that allows you to include extra rows that represent the subtotals, which are commonly referred to **as super-aggregate rows**, along with the grand total row.

The result is

```sql
SELECT 
    fa.actor_id, f.rating, COUNT(*)
FROM
    film_actor fa
        INNER JOIN
    film f ON fa.film_id = f.film_id
GROUP BY fa.actor_id , f.rating with rollup
ORDER BY 1 , 2;
```

## 8.4 Group Filter Conditions

Use having clause to filter grouping data,

```sql
SELECT 
    fa.actor_id, f.rating, COUNT(*)
FROM
    film_actor fa
        INNER JOIN
    film f ON fa.film_id = f.film_id
GROUP BY fa.actor_id , f.rating
HAVING COUNT(*) > 9
```

If we use want to filter raw data with where clause

```sql
#
SELECT 
    fa.actor_id, f.rating, COUNT(*)
FROM
    film_actor fa
        INNER JOIN
    film f ON fa.film_id = f.film_id
where f.rating in ('G','PG')
GROUP BY fa.actor_id , f.rating
HAVING COUNT(*) > 9
```

Short summay,

| clause | application                 | Note                                    |
| ------ | --------------------------- | --------------------------------------- |
| where  | filter raw data (ungrouped) | precedance b4 group by                  |
| having | filter grouped data         | typically used with aggredate functions |

## 8.5 Test Questions

### Exercise 8-1

Construct a query that counts the number of rows in the payment table.

```sql
select count(*) how_many from payment
```

### Exercise 8-2

Modify your query from Exercise 8-1 to count the number of payments made by each

customer. Show the customer ID and the total amount paid for each customer.

```sql
SELECT 
    customer_id, COUNT(*), SUM(amount) tot_paid
FROM
    payment
GROUP BY customer_id
```

### Exercise 8-3❌

Modify your query from Exercise 8-2 to include only those customers who have

made at least 40 payments.

```sql
SELECT 
    customer_id, COUNT(*), SUM(amount) tot_paid
FROM
    payment
GROUP BY customer_id
HAVING COUNT(*) > 40
#HAVING COUNT(*) >= 40
```

At least 等效的是大于等于

---

# Chapter 9 Subqueries

In this section, you will learn

- [x] What is a subquery?

## 9.1 What is a subquery?

> Subquery is a query contained within another SQL statement and is always enclosed within parantheses.

和Query类似，it returns a result set consists of 

- A single row with a single column (scalar query+)

- Multiple rows with a single column

- Multiple rows having multiple columns

和工具人一样，subquery的result结算完，就被扔掉. A subquery act like a temporary table with statement scope.

举个例子，

```sql
SELECT 
    customer_id, first_name, last_name
FROM
    customer
WHERE
    customer_id = (SELECT 
            MAX(customer_id)
        FROM
            customer)
```

但下面这个code snippet不行，由于max()是aggregate function, 必须搭配group by来用 

```sql
SELECT 
    customer_id, first_name, last_name
FROM
    customer
WHERE
    customer_id = MAX(customer_id)
```

而这个subquery, 实际上只return了one row of one column data.

```sql
SELECT 
    MAX(customer_id)
FROM
    customer
```

| MAX(customer_id) |
|:----------------:|
| 599              |

## 9.2 Subquery Types

之前以result set来分类subquery,

- one row, one column, also called a scalar subquery
  
  - used for <mark>equality condition</mark> with comparison operators like (=, <>,<, >, <=,>= )

- 一行多列

- 多行多列

你可以按照另一个分类方式，分成

- non-correlated subqueries

- correlated subqueries

## 9.3 Non-correlated Subqueries

### 9.3.1 Scalar subquery

Let's say if you want to return all cities that are not in India.Use inequlity conditon with a scalar subquery, it is 

```sql
SELECT 
    *
FROM
    city
WHERE
    country_id <> (SELECT 
            country_id
        FROM
            country
        WHERE
            country = 'India')
```

### 9.3.2 Multiple-Row, Single-Column Subqueries

> 其实也就是用matching condition中的membership condition with in and not in clause.

Recall membership conditions, we could have a set of string enclosed with parenthesis like ('China','Canada')

```sql
SELECT 
    *
FROM
    country
WHERE
    country IN ('China' , 'Canada')
```

如果你需要return 所有在中国和加拿大的city_id and city, 你总不能再mannually type in a set of string containing all cities in china and canada. Subquery would do the trick

```sql
SELECT 
    city_id, city
FROM
    city
WHERE
    country_id IN (SELECT 
            country_id
        FROM
            country
        WHERE
            country IN ('CHINA' , 'CANADA'))
#一般用foreign key在where里，会比较方便
```

city table

- city_id, city, country_id and last_update

country table

- country_id, country and last_update

#### The all operator

> all operator: allows you to make comparisons between a single value and every value in a set. 用comparisons operators along with all operator.

Let's say, 你想找到customers that never gotten a free film rental, 

```sql
#use of all operator
SELECT 
    first_name, last_name
FROM
    customer
WHERE
    customer_id <> ALL (SELECT 
            customer_id
        FROM
            payment
        WHERE
            amount = 0);
```

Practically speaking, no one really uses it. It would be achieved with the following codes as well,

```sql
SELECT 
    first_name, last_name
FROM
    customer
WHERE
    customer_id NOT IN (SELECT 
            customer_id
        FROM
            payment
        WHERE
            amount = 0);
```

You should avoid the pitfall for both not in and <> all when it comes to null. You have to make sure the set of values you use are null-free. Any attempt to equate a value to null yields unknown.

> 案例: return the total number of film rentals for all customers in North america. North america has canada, united states and mexico. Look at the EER diagram shown below,

```sequence
rental->customer: customer_id 
customer->address: address_id
address->city: city_id
city->country: country_id 
```

```sql
(SELECT 
    count(*)
FROM
    rental r
        INNER JOIN
    customer c ON r.customer_id = c.customer_id
        INNER JOIN
    address a ON c.address_id = a.address_id
        INNER JOIN
    city ct ON a.city_id = ct.city_id
        INNER JOIN
    country co ON ct.country_id = co.country_id
WHERE
    co.country IN ('Mexico' , 'Canada', 'United States')
GROUP BY r.customer_id)
```

This query returns 

> 案例(cont): return all customers whose total number of film rentals exceeds any of the north american customers.

```sql
SELECT 
    customer_id, COUNT(*)
FROM
    rental
GROUP BY customer_id
HAVING COUNT(*) > ALL (SELECT 
        COUNT(*)
    FROM
        rental r
            INNER JOIN
        customer c ON r.customer_id = c.customer_id
            INNER JOIN
        address a ON c.address_id = a.address_id
            INNER JOIN
        city ct ON a.city_id = ct.city_id
            INNER JOIN
        country co ON ct.country_id = co.country_id
    WHERE
        co.country IN ('Mexico' , 'Canada', 'United States')
    GROUP BY r.customer_id)
```

> 小贴士: All operator 解决了equality condition中两边只能是一个value的限制条件，可以完成scalar 和one set of value进行比较的壮举

#### The any operator

> ANY operator: allow a value to be compared to the members of a set of values. It returns true as long as one comparison is favorable.

Now we will find all customers whose total film rental payments exceed the total payments for all customers in Bolivia, Paraguay, or Chile:

```sequence
payment->customer: customer_id 
customer->address: address_id
address->city: city_id
city->country: country_id 
```

```sql
(SELECT 
    sum(p.amount)
FROM
    payment p
        INNER JOIN
    customer c ON p.customer_id = c.customer_id
        INNER JOIN
    address a ON c.address_id = a.address_id
        INNER JOIN
    city ct ON a.city_id = ct.city_id
        INNER JOIN
    country co ON ct.country_id = co.country_id
WHERE
    co.country IN ('Bolivia' , 'Paraguay', 'Chile')
GROUP BY co.country)
```

The above returns the sum for bolivia, paraguay and chile.

| sum(p.amount) |
| ------------- |
| 183.53        |
| 328.29        |
| 275.38        |

Now we compare.

```sql
SELECT 
    customer_id, SUM(amount)
FROM
    payment
GROUP BY customer_id
HAVING SUM(amount) > ANY (SELECT 
        SUM(p.amount)
    FROM
        payment p
            INNER JOIN
        customer c ON p.customer_id = c.customer_id
            INNER JOIN
        address a ON c.address_id = a.address_id
            INNER JOIN
        city ct ON a.city_id = ct.city_id
            INNER JOIN
        country co ON ct.country_id = co.country_id
    WHERE
        co.country IN ('Bolivia' , 'Paraguay', 'Chile')
    GROUP BY co.country)
```

#### 比较any 和 all的应用场景

- When it comes to equality/inequality comparison
  
  - in 和 = any是等效的
  
  - not in 和 <> all是等效的

- when it comes to comparison operator
  
  - any和all显然更加robust

- Note: avoid null at all cost when using both any and all operator.

> 灵感: 顿时明白了EER diagram, foreign key 和inner join之间的美妙连接，让我可以同时提取多个table中的数据，随意操作

### 9.3.3 Multicolumn Subqueries

B4 we dive into the world of multi-column subqueries, we look at multiple single column subqueries.

We want you reteieve all actor and film id from all actors with the last name Monroe appeared in a PG film.

> Solution_1: solved with multiple single-column subqueries. 

```sql
#two single-column subquery to solve it
select fa.actor_id,fa.film_id
from film_actor fa
where fa.actor_id in 
(select actor_id from actor where last_name = 'Monroe')
and fa.film_id IN
(select film_id from film where rating = 'PG')
```

> Solution_2: solved with multi-column subqueries.

First, we look at the subquery that result in two columns (第一列actor id, 第二列film id). The cross join type returns all possible combination.

```sql
SELECT 
    a.actor_id, f.film_id
FROM
    actor a
        CROSS JOIN
    film f
WHERE
    a.last_name = 'MONROE'
        AND f.rating = 'PG'
```

Then we compare it directly.

```sql
#multi-column solution
select fa.actor_id,fa.film_id
from film_actor fa
where (actor_id,film_id) in
(select a.actor_id, f.film_id
from actor a 
cross join film f
where a.last_name = 'MONROE'
and f.rating = 'PG');
```

## 9.4 Correlated Subqueries

以上我们聊的都是non-correlated subquery, 也就是subquery statement离开了its containing statement, 也可以run

> Correlated subquery: a subquery is dependent on its containing statement from which it references one or more columns.

Non-correlated subquery is exectued prior to execution of the containing statement while correlated subquery is executed once for each candidate row (rows that might be included in the final results).

> Example: query those customers who have rented exactly 20 films. Correlated subquery在equality condition的应用

```sql
select c.first_name, c.last_name
from customer c
where 20 =
(select count(*) from rental r where r.customer_id = c.customer_id)
```

The last line `where r.customer_id = c.customer_id` refers back to the containing statement which makes it correlated subquery. 

由于containing query有多少行，每一行都要跑一遍subquery, 非常computationally expensive.

> Example: query those customers whose total payments for all film rental ranging between 180 and 240. Correlated subquery在range conditon的应用

```sql
SELECT 
    c.first_name, c.last_name
FROM
    customer c
WHERE
    (SELECT 
            SUM(p.amount)
        FROM
            payment p
        WHERE
            p.customer_id = c.customer_id) BETWEEN 180 AND 240;
```

### 9.4.1 The exists Operator

> `exists` (correlated subquery): checks whether the subquery returned one or more rows.

Using the data, it sucks ass.

```sql
SELECT 
    c.first_name, c.last_name
FROM
    customer c
WHERE
exists (select 1 from rental r
where r.customer_id = c.customer_id
and date(r.rental_date) < '2005-05-25');
```

Since the condition in the containing query only needs to know how many rows have been returned regardless of what's inside the column (result set for subquery). This is why `select 1 from rental r` the dummy 1 has been used.

> `not exists` (correlated subquery): checks for subqueries that return no rows.

Now, we look at this. This query finds all actors who have never appeared in an R-rated film. 

```sql
SELECT 
    a.first_name, a.last_name
FROM
    actor a
WHERE
    NOT EXISTS( SELECT 
            1
        FROM
            film_actor fa
                INNER JOIN
            film f ON f.film_id = fa.film_id
        WHERE
            fa.actor_id = a.actor_id
                AND f.rating = 'R');
```

### 9.4.2 Data Manipulation Using Correlated Subqueries

> 上面讲了correlated subqueries和`select` clause的运用，但其实也extensively used with `update` and `delete` clause.

#### Correlated subqueries X `update`

The follow code snippet modifies every row in the customer table by finding the latest rental date for each customer in the rental table.

```sql
update customer c
SET c.last_update = 
(
    select max(r.rental_date) from rental r
    where r.customer_id = c.customer_id
);
```

It has one problem that if there is one customer didn't rent any films, the value will be `null`. If it is `null`, the subquery would return no rows. 

In order to solve this, we use 2nd correlated subquery, to protect the date in the last_update column to be overwritten with a `null`.

```sql
update customer c
SET c.last_update = 
(
    select max(r.rental_date) from rental r
    where r.customer_id = c.customer_id
) where exists
(select 1 from rental r where r.customer_id = c.customer_id);
```

#### Correlated subqueries X `delete`

Remove rows from the customer table where there have been no film rentals in the past year:

```sql
delete from customer
where 365 < ALL
(select datediff(now(),r.rental_date) days_since_last_rental
from rental r
where r.customer_id = customer.customer_id);
```

> 小贴士：Correlated subqueries with delete statements in MySQL, table aliases are not allowed when using delete.

## 9.5 When to Use Subqueries

学习了subquery的类别, 现在需要学习用subquery来实现不同功能了

- [ ] to construct custom tables

- [ ] to build conditions

- [ ] to generate column values in results sets

### 9.5.1 Subqueries as Data Source

#### Subquery to summarize existing data

Remember the `selecte ... from ...` clause? We can select from table but we also can select from subquery since the results set are all columns and rows of data.

```sql
SELECT 
    c.first_name,
    c.last_name,
    pymnt.num_rentals,
    pymnt.tot_payments
FROM
    customer c
        INNER JOIN
    (SELECT 
        customer_id, COUNT(*) num_rentals, SUM(amount) tot_payments
    FROM
        payment
    GROUP BY customer_id) pymnt ON c.customer_id = pymnt.customer_id
```

In the example above, we could see a subquery that generates a list of customer_id, number of film rentals and the total paymerns.

```sql
SELECT 
        customer_id, COUNT(*) num_rentals, SUM(amount) tot_payments
    FROM
        payment
    GROUP BY customer_id
```

| customer_id | num_rentals | tot_payments |
| ----------- | ----------- | ------------ |
| 1           | 32          | 118.68       |
| 2           | 27          | 128.73       |
| 3           | 26          | 135.74       |
| 4           | 22          | 81.78        |
| ...         |             |              |
| 599         | 19          | 83.31        |

Then the containing query retrieves the customer's name from customer table, along with the summary columns from pymnt subquery.

#### Data fabrication

> Data fabrication: You can use subqueries to generate data that doesn't exist in any form within your database.

Firstly we generate a query,

```sql
select 'small fry' name, 0 low_limit, 74.99 high_limit
union all
select 'average joes' name, 75 low_limit, 149.99 high_limit
union all
select 'heavy hitters' name, 150 low_limit, 9999999.99 high_limit
```

然后我们可以把customer的消费总额，塞进不同消费的payment group里.

```sql
SELECT 
    pymnt_grps.name, COUNT(*) num_customers
FROM
    (SELECT 
        customer_id, COUNT(*) num_rentals, SUM(amount) tot_payments
    FROM
        payment
    GROUP BY customer_id) pymnt
        INNER JOIN
    (SELECT 'small fry' name, 0 low_limit, 74.99 high_limit 
    UNION ALL
    SELECT 'average joes' name, 75 low_limit, 149.99 high_limit 
    UNION ALL 
    SELECT 'heavy hitters' name, 150 low_limit, 9999999.99 high_limit) pymnt_grps 
    ON pymnt.tot_payments BETWEEN pymnt_grps.low_limit AND pymnt_grps.high_limit
GROUP BY pymnt_grps.name
```

Then the results are

| name          | num_customers |
|:-------------:|:-------------:|
| Average Joes  | 515           |
| Heavy Hitters | 46            |
| Small Fry     | 38            |

> 上述这个例子，完全可以用`create table` or `create temporary table` 来建立permanent or temporary table来实现subquery一样的功能，把顾客按照购买力分组。但subquery的好处是，不会在你的database中留下任何痕迹，只是temporary held in memory (derived table), 所以不会pile up dummy table in your database everywhere until you lost track of them all. Database的功能是用来储存data, 而不是dumpster.

#### Task-oriented subqueries

> Example: 现在你需要输出一份report, 把每个客人的姓名，所在城市，消费总额，和总计租赁次数都汇总在一张表格之中.

看一下ERR diagram,

```sequence
payment->customer: customer_id

customer->address: address_id

address->city: city_id
```

第一种方法, 我的solution比书上快一步，group by p.customer_id和同时group by first_name, last_name and city比起来更简洁，而且更严谨，一个城市很可能有很多同名同姓的人在这家店消费.

```sql
#Solutions 1:
select c.first_name, c.last_name, ct.city,
sum(p.amount) tot_payments, count(*) tot_rentals
from payment p
inner join customer c 
on p.customer_id = c.customer_id
inner join address a
on c.address_id = a.address_id
inner join city ct
on a.city_id = ct.city_id
group by p.customer_id
#Duration/Fetch Time: 0.033sec/0.00011 sec 三次平均
```

You will find out that, 消费总额和总计租赁次数，全可以直接从payment table计算出，而你join customer, address, city 这三个tables,只是为了retrieve姓名和city罢了. 个人还是认为customer_id比姓名精准更严谨定位一个人.

接下来我们用sub-query, 提炼出我们需要的信息, 这个subquery的results set的primary key是customer_id

```sql
SELECT 
    customer_id,
    COUNT(*) total_rentals,
    SUM(amount) tot_payments
FROM
    payment
GROUP BY customer_id
```

我们把这个subquery取一个alias为pymnt, 把这个作为一个"table" 和其它join起来，则

```sequence
pymnt->customer: customer_id

customer->address: address_id

address->city: city_id
```

这个err和上一个的区别是pymnt subquery包含了我们需要的所有信息，接下来我们只需要join其它table, retrieve一些string就可以了.

```sql
#Solution 2
SELECT 
    c.first_name,
    c.last_name,
    ct.city,
    pymnt.tot_payments,
    pymnt.total_rentals
FROM
    (SELECT 
        customer_id,
            COUNT(*) total_rentals,
            SUM(amount) tot_payments
    FROM
        payment
    GROUP BY customer_id) pymnt
        INNER JOIN
    customer c ON pymnt.customer_id = c.customer_id
        INNER JOIN
    address a ON c.address_id = a.address_id
        INNER JOIN
    city ct ON a.city_id = ct.city_id
#Duration/Fetch Time: 0.025sec/0.00012 sec 三次平均
```

速度没优化多少, 但格式更加清晰了，不需要group by 四个表格join之后的table, 而是group by一个table之后再join其它的.

#### Common table expressions

> 暂略，具体看reference [MySQL :: MySQL 8.0 Reference Manual :: 13.2.15 WITH (Common Table Expressions)](https://dev.mysql.com/doc/refman/8.0/en/with.html)

### 9.5.2 Subqueries as Expression Generators

Now we look at example we dealt with in 9.5.1. We want to generate the following table,

| first_name | last_name | city | tot_payments | tot_rentals |
| ---------- | --------- | ---- | ------------ | ----------- |
|            |           |      |              |             |

We could use subquery as an expression for `select` clause in containing statment to select it. 

```sql
SELECT 
    (SELECT 
            c.first_name
        FROM
            customer c
        WHERE
            c.customer_id = p.customer_id) first_name,
    (SELECT 
            c.last_name
        FROM
            customer c
        WHERE
            c.customer_id = p.customer_id) last_name,
    (SELECT 
            ct.city
        FROM
            customer c
                INNER JOIN
            address a ON c.address_id = a.address_id
                INNER JOIN
            city ct ON a.city_id = ct.city_id
        WHERE
            c.customer_id = p.customer_id) city,
    SUM(p.amount) tot_payments,
    COUNT(*) tot_rentals
FROM
    payment p
GROUP BY p.customer_id;
```

和之前的例子有两个区别

- Instead of joining the customer, address and city tables to the payment data, <mark>correlated scalar subqueries</mark> are used in the select clause to look up the customer's first/last names and city.

- The customer table is accessed three times (once in each of the three subqueries rather than just once)

Subquery 同样能和`order by `clause. The following query retrieves an actor's first and last names and sorts by the number of films in which the actor appeared:

```sql
SELECT 
    a.actor_id, a.first_name, a.last_name
FROM
    actor a
ORDER BY (SELECT 
        COUNT(*)
    FROM
        film_actor fa
    WHERE
        fa.actor_id = a.actor_id) DESC
```

上述的correlated subquery is used only for sorting purpose.

## 9.6 Subquery Wrap-Up

总结一下subquery的应用场景

- 根据subquery return的数据格式，分为
  
  - Return a single column and row, 
  
  - Return a single column with multiple rows, and 
  
  - Return multiple columns and rows.

- 根据subquery是否独立分为
  
  - Are independent of the containing statement (non-correlated subquerise)
  
  - Reference one or more columns from the containing statement (correlated subqueries)

- Are used in conditions that utilize:
  
  - comparison operator: `>`, `<`, `<>`, `!=`
  
  - special purpose operators, `in`, `not in`, `exists`, `not exists`

- Can be found in select, update, delete and insert statements.

- Generate result sets that can be joined to other tables (subqueries) in a query

- Can be used to generate values to populate a table or to populate columns in a query's results set

## 9.7 Test Questions

### Exercise 9-1 ❌

Construct a query against the film table that uses a filter condition with a noncorre‐

lated subquery against the category table to find all action films (category.name =

'Action').

```sequence
film->film_category: film_id
film_category->category: category_id
```

```sql
#solution 1
SELECT 
    title
FROM
    film f
        INNER JOIN
    film_category fc ON f.film_id = fc.film_id
        INNER JOIN
    category c ON fc.category_id = c.category_id
WHERE
    c.name = 'Action'


#Solution 2
SELECT 
    title
FROM
    film f
        INNER JOIN
    film_category fc ON f.film_id = fc.film_id
        INNER JOIN
    category c ON fc.category_id = c.category_id
WHERE
    c.name = (select name from category where name = 'Action')

#Solution 3(参考答案)
SELECT 
    title
FROM
    film
WHERE
    film_id IN (SELECT 
            fc.film_id
        FROM
            film_category fc
                INNER JOIN
            category c ON fc.category_id = c.category_id
        WHERE
            c.name = 'Action')
```

> 总结：用noncorrelated subquery在`where` clause应用，你只需要title column from film, 剩下的都可以打包在subquery中来做

### Exercise 9-2 ❌

Rework the query from Exercise 9-1 using a correlated subquery against the category

and film_category tables to achieve the same results.

```sql
SELECT 
    f.title
FROM
    film f
WHERE
    EXISTS( SELECT 
            1
        FROM
            film_category fc
                INNER JOIN
            category c ON fc.category_id = c.category_id
        WHERE
            c.name = 'Action'
                AND fc.film_id = f.film_id)
```

### Exercise 9-3 ❌

Join the following query to a subquery against the film_actor table to show the level

of each actor:

```sql
SELECT 'Hollywood Star' level, 30 min_roles, 99999 max_roles
UNION ALL
SELECT 'Prolific Actor' level, 20 min_roles, 29 max_roles
UNION ALL
SELECT 'Newcomer' level, 1 min_roles, 19 max_roles
```

The subquery against the film_actor table should count the number of rows for each

actor using group by actor_id, and the count should be compared to the

min_roles/max_roles columns to determine which level each actor belongs to.

```sql
#Solution
select actr.actor_id, grps.level
from 
(select actor_id, count(*) num_roles
from film_actor
group by actor_id
) actr
inner join
(
SELECT 'Hollywood Star' level, 30 min_roles, 99999 max_roles
UNION ALL
SELECT 'Prolific Actor' level, 20 min_roles, 29 max_roles
UNION ALL
SELECT 'Newcomer' level, 1 min_roles, 19 max_roles
) grps
ON actr.num_roles BETWEEN grps.min_roles AND grps.max_roles;
```

---

# Chapter 10 Joins Revisited

## 10.1 Outer Joins

> 问题：return film_id, title and 多少copy

From 

```sql
SELECT 
    f.film_id, f.title, COUNT(*) num_copies
FROM
    film f
        INNER JOIN
    inventory i ON f.film_id = i.film_id
GROUP BY f.film_id , f.title
#GROUP BY f.film_id 只aggregate film_id一样work

#return 958 rows
```

但实际上，有很多电影虽然在film_id table之中，但并不存在于inventory之中, 可能是卖断货了，也可能是还没入库，在物流运输之中。因为我们用的join condition: inner join on key film_id from both tables, some film (like id 14) doesn't appear in the results since it is not in the inventory table.

如果你想要query 所有films regardless of whether or not there are rows in the inventory table, you can use 

> `left outer join` clause: instructs the server to include all rows from the table on the left side of the join

```sql
SELECT 
    f.film_id, f.title, COUNT(i.inventory_id) num_copies
FROM
    film f
       LEFT OUTER JOIN
    inventory i ON f.film_id = i.film_id
GROUP BY f.film_id, f.title

#returns 1000 rows. Some rows is 0 in num_copies column.
```

但是注意，一共变动了两个地方

- `inner join` to `left outer join`

- count(*) to count(i.inventory_id)

如果我们跑以下code

```sql
SELECT 
    f.film_id, f.title, COUNT(*) num_copies
FROM
    film f
       LEFT OUTER JOIN
    inventory i ON f.film_id = i.film_id
GROUP BY f.film_id, f.title
```

实际上没货的film_id 14 Alice FANTASIA, 因为count(*) 单纯只计算行数，有一行算一行，即使为0.

> The `count(*)` function returns the number of rows in a dataset using the select statement. The function counts rows with Null, duplicate, and non-Null

> The`count(expression)` function returns the number of rows that do not contain NULL values.

> The `count (DISTINCT expression)` function returns the number of distinct non-NULL values.

Now, we remove the group by clause and filter out most of the rows to see clearly what's the difference between `inner join` and `outer joins`.

```sql
SELECT 
    f.film_id, f.title, i.inventory_id
FROM
    film f
        INNER JOIN
    inventory i ON f.film_id = i.film_id
WHERE
    f.film_id BETWEEN 13 AND 15;
```

| film_id | title        | inventory_id |
|:-------:| ------------ | ------------ |
| 13      | ALI FOREVER  | 67           |
| 13      | ALI FOREVER  | 68           |
| 13      | ALI FOREVER  | 69           |
| 13      | ALI FOREVER  | 70           |
| 15      | ALIEN CENTER | 71           |
| 15      | ALIEN CENTER | 72           |
| ...     | ...          | ...          |

If we do left outer join,

```sql
SELECT 
    f.film_id, f.title, i.inventory_id
FROM
    film f
        LEFT OUTER JOIN
    inventory i ON f.film_id = i.film_id
WHERE
    f.film_id BETWEEN 13 AND 15;
```

It returns additioanly row,

| film_id | title          | inventory_id |
| ------- | -------------- | ------------ |
| 13      | ALI FOREVER    | 70           |
| 14      | ALICE FANTASIA | NULL         |
| 15      | ALIEN CENTER   | 71           |

### 10.1.1 `LEFT OUTER JOIN` vs `RIGHT OUTER JOIN`

> keyword `left` : it indicates that the table on the left side of the join is responsible for determining the number of rows in the result set, whereas the table on the right side is used to provide column values whenever a match is found.

这俩没必要记住，used interchangbly `A left outer join B` = `B right outer join A`.

如果你想要outer join table A and B together. 然后你需要all rows from A with additional columns from B whenever there is matching data, you just use either `A left outer join B` = `B right outer join A`.

阅读顺序都是从左到右的，这样比较习惯.

### 10.1.2 Three-Way Outer Joins

有些应用场景你需要数据from three tables, 所以你需要join more than 2 tables.

```sequence
film->inventory: film_id
inventory->rental: inventory_id
```

我们可以,

```sql
SELECT 
    f.film_id, f.title, i.inventory_id, r.rental_date
FROM
    film f
        LEFT OUTER JOIN
    inventory i ON f.film_id = i.film_id
        LEFT OUTER JOIN
    rental r ON i.inventory_id = r.inventory_id
WHERE
    f.film_id BETWEEN 13 AND 15;
```

## 10.2 Cross Joins

> 几乎没有应用场景，大多数都是意外用的 (forgetting to add the join condition to the from clause). `Cross join` 不需要join的条件

下面三个code snippet是equivalent的，但最好用第一种where you specify the join type.

```sql
#solution1
SELECT 
    c.name category_name, l.name language_name
FROM
    category c
        CROSS JOIN
    language l

#solution2
SELECT 
    c.name category_name, l.name language_name
FROM
    category c
        JOIN
    language l

#solution3 (case where you forget condition)
SELECT 
    c.name category_name, l.name language_name
FROM
    category c
        INNER JOIN
    language l
```

> 书中讲了一个cross join的妙用，但对我现在用处不大.

## 10.3 Natural Joins

> `NATURAL JOIN` :let databse server determine what the join conditions need to be. This shit sucks. Never use it.

## 10.4 Test Questions

### Exercise 10-1❓

Using the following table definitions and data, write a query that returns each cus‐

tomer name along with their total payments:

Include all customers, even if no payment records exist for that customer.

```sql
SELECT 
    c.name, SUM(p.amount) tot_amount
FROM
    customer c
        LEFT OUTER JOIN
    payment p ON c.customer_id = p.customer_id
GROUP BY p.customer_id
```

solution是，

```sql
SELECT 
    c.name, SUM(p.amount) tot_amount
FROM
    customer c
        LEFT OUTER JOIN
    payment p ON c.customer_id = p.customer_id
GROUP BY c.name;
```

但我感觉，我`group by p.customer_id`也可以吧.

等有时间回头create table, 再测试一下.

### Exercise 10-2

互换一下就好，不做了。

### Exercise 10-3 (Extra Credit)

---

# Chapter 11 Conditional Logic

## 11.1 What is Conditional Logic?

> 在sql语言中，conditional logic是用`case` 来完成的, which can be utilized in select, insert, update and delete statements.

```sql
#Example of searched case
SELECT 
    first_name,
    last_name,
    CASE
        WHEN active = 1 THEN 'active'
        ELSE 'inactive'
    END activity_type
FROM
    customer;
```

## 11.2 The `case` Expression

### 11.2.1 Searched `case `Expresions

The searched case expression has the following syntax:

```sql
#Pseudo-code
CASE
    WHEN C1 THEN E1
    WHEN C2 THEN E2
    ...
    WHEN CN THEN EN
    [ELSE ED] #ED symbol represents the default expression
END
```

Here's an example of a searched case expression:

```sql
#this is an expression, not runable
CASE 
    when category.name IN ('Children','Family','Sports','Animation')
        then 'All Ages'
    when category.name = 'Horror'
        then 'Adult'
    when category.name IN ('Music','Games')
        then 'Teens'
    else 'Other'
END
#return spring
```

This expression returns a string that can be used to classify films depending on their category. 可以把a series of movies genre归类到适合All Ages, adult and Teens的人群观看.

Instead of returning string, it can also return subquery. Return the number of rentals, but only for active customers:

```sql
#correlated subquery with case
SELECT 
    c.first_name,
    c.last_name,
    CASE
        WHEN active = 0 THEN 0
        ELSE (SELECT 
                COUNT(*)
            FROM
                rental r
            WHERE
                r.customer_id = c.customer_id)
    END num_rentals
FROM
    customer c
```

### 11.2.2 Simple case Expressions

The simple case expression is quite similar to the searched case expression but is a bit less flexible. 

> simple case expression: V0 represents a value. V1...VN represents a value to be compared to v0  

```sql
#Pseudo-code for simple case expression
CASE V0
    WHEN V1 THEN E1
    WHEN V2 THEN E2
    ...
    WHEN VN THEN EN
    [ELSE ED] #ED symbol represents the default expression
END
```

For example,

```sql
CASE category.name
    WHEN 'Children' THEN 'All Ages'
    WHEN 'Family' THEN 'All Ages'
    WHEN 'Sports' THEN 'All Ages'
    WHEN 'Animation' THEN 'All Ages'
    WHEN 'Horror' THEN 'Adult'
    WHEN 'Music' THEN 'Teens'
    WHEN 'Games' THEN 'Teens'
ELSE 'Other'
END
```

## 11.3 Examples of `case` Expressions

### 11.3.1 Result Set Transformations

> When aggregating over a finite set of values(days of the week A.K.A.7), Result set contain a single row with one column per value instead of one row per value. (Transpose of each other)

Example, write a query that shows the number of film rentals for May, June and July of 2005.

```sql
#先filter出05年may to august
#再group by month
SELECT 
    MONTHNAME(rental_date) rental_month, COUNT(*) num_rentals
FROM
    rental
WHERE
    rental_date BETWEEN '2005-05-01' AND '2005-08-01'
GROUP BY MONTHNAME(rental_date)
```

The output is:

| rental_month | num_rentals |
| ------------ | ----------- |
| May          | 1156        |
| June         | 2311        |
| July         | 6709        |

However, if we want to transpose the output, wut should we do?

```sql
#i can use aggregate fcn without using group by? wow!
SELECT 
    SUM(CASE
        WHEN MONTHNAME(rental_date) = 'May' THEN 1
        ELSE 0
    END) May_rentals,
    SUM(CASE
        WHEN MONTHNAME(rental_date) = 'May' THEN 1
        ELSE 0
    END) May_rentals,
    SUM(CASE
        WHEN MONTHNAME(rental_date) = 'May' THEN 1
        ELSE 0
    END) May_rentals
FROM
    rental
WHERE
    rental_date BETWEEN '2005-05-01' AND '2005-08-01';
```

The output is:

| rental_month | num_rentals |
| ------------ | ----------- |
| May          | 1156        |
| June         | 2311        |
| July         | 6799        |

> `monthname(datetime)`: return the month for the datetime type data. 

### 11.3.2 Checking for Existence

> 应用场景：如果你想知道小宋今天吃了烧卖了吗？而不关心她吃了多少个烧麦，please use the `case` statement.

Here is an example that uses multiple case expressions to generate three output columns, one to show whether the actor has appeared in G-rated films, another for PG-rated films, and a third for NC-17-rated films:

```sql
select a.first_name, a.last_name,
    case
        when exists (select 1 from film_actor fa
                    inner join film f on fa.film_id = f.film_id
                    where fa.actor_id = a.actor_id
                    and f.rating = 'G') then 'Y'
        else 'N'
    END g_actor,
    case 
        when exists (select 1 from film_actor fa
                        inner join film f on fa.film_id = f.film_id
                        where fa.actor_id = a.actor_id
                        and f.rating = 'NC-17') THEN 'Y'
                    else 'N'
                end nc17_actor
    from actor a
    where a.last_name LIKE 'S%' or a.first_name LIKE 'S%';
```

> `exists` statement usually goes with a subquery with (select 1 from xx) since we don't really care for content.

`case` 还可以用在以下应用场景,

> 应用场景:你想知道，小宋肚子的状态，饿，半饱，饱，撑死了. Assuming claire needs to eat at least 10 烧卖 to be in the status "撑死了" and her stomach is like an abyss, you don't care whether she ate 11 cuz it's all gonna be labelled as "撑死了".

```sql
SELECT 
    f.title,
    CASE (SELECT 
            COUNT(*)
        FROM
            inventory i
        WHERE
            i.film_id = f.film_id)
        WHEN 0 THEN 'Out Of Stock'
        WHEN 1 THEN 'Scarce'
        WHEN 2 THEN 'Scarce'
        WHEN 3 THEN 'Available'
        WHEN 4 THEN 'Available'
        ELSE 'Common'
    END film_availability
FROM
    film f
```

### 11.3.3 Division-by-Zero Errors

> In MySQL, if denominators are zeros, it sets the result to `null` shown by `select 100/0`

Common practice to avoid such situation is to wrap all denominators in conditional logic,

```sql
SELECT 
    c.first_name,
    c.last_name,
    SUM(p.amount) tot_payment_amt,
    COUNT(p.amount) num_payments,
    SUM(p.amount) / CASE
        WHEN COUNT(p.amount) = 0 THEN 1 #
        ELSE COUNT(p.amount)
    END avg_payment
FROM
    customer c
        LEFT OUTER JOIN
    payment p ON c.customer_id = p.customer_id
GROUP BY c.first_name , c.last_name
```

### 11.3.4 Conditional Updates

> 略

### 11.3.5 Handling Null Values

> 应用场景: When `null` is encountered and you wish to display some other strings.

Let's say, you might want to display the word unknown on a data entry screen rather than leaving a field blank, we do the following 

```sql
SELECT 
    c.first_name,
    c.last_name,
    #check three columns whether null
    CASE
        WHEN a.address IS NULL THEN 'Unknown'
        ELSE a.address
    END address,
    CASE
        WHEN ct.city IS NULL THEN 'unknown'
        ELSE ct.city
    END city,
    CASE
        WHEN cn.country IS NULL THEN 'Unknown'
        ELSE cn.country
    END country
FROM
    customer c
        LEFT OUTER JOIN
    address a ON c.address_id = a.address_id
        LEFT OUTER JOIN
    city ct ON a.city_id = ct.city_id
        LEFT OUTER JOIN
    country cn ON ct.country_id = cn.country_id
```

## 11.4 Test Questions

### Exercise 11-1

Rewrite the following query, which uses a simple case expression, so that the same

results are achieved using a searched case expression. Try to use as few when clauses

as possible.

```sql
select 
    case 
        when l.name in ('ENGLISH','Italian','French','gERMAN') 
        then 'LATIN1'
        when l.name in ('japanese','mandarin') 
        then 'utf8'
        else 'unknown'
        end character_set
from language l
```

### Exercise 11-2

Rewrite the following query so that the result set contains a single row with five col‐

umns (one for each rating). Name the five columns G, PG, PG_13, R, and NC_17.

```sql
SELECT 
    SUM(CASE WHEN f.rating = 'G' THEN 1 ELSE 0 END) g,
    SUM(CASE WHEN f.rating = 'PG' THEN 1 ELSE 0 END) pg,
    SUM(CASE WHEN f.rating = 'PG-13' THEN 1 ELSE 0 END) pg_13,
    SUM(CASE WHEN f.rating = 'R' THEN 1 ELSE 0 END) r,
    SUM(CASE WHEN f.rating = 'NC-17' THEN 1 ELSE 0 END) nc_17
FROM
    film f
```

---

# Chapter 16: Analytic Functions
