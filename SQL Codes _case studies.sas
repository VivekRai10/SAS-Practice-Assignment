libname c "D:\Dropbox\Public\Temp\Analytics\SAS\Sample codes for class\SQL";

proc sql;
/* Example query 1*/
select custid, expense, category 
from c.ccu;

/* Example query 2 */
select * from c.ccu;
proc sql;
/* Example query 3 */
create table sql_table
as select custid, expense, category 
from c.ccu
where expense>10000;

quit;

/*Case Study-1
Look at the dataset CCU. It has information about 10 latest credit card transactions of 100 customers.
Study the variables and then report on following points

Q1-Who are the top 10 customers on the basis on expense?

Q2-What are the top 3 categories of expense?

Q3-What was the average expense of each customer in the month of September?

Q4-How many distinct categories of expenses are there?

Q5-Find out average , standard deviation for expense across categories and overall in one table.

Q6-How many customers have expense in (1)atleast 5 categories and (2) all the categories ?*/



/*Question-1*/
proc sql;

create table cust_summ  as
select  custid, sum(expense) as expense
from c.ccu
group by custid
order by expense desc;



Title "Question-2: Top 10 customers by expenses";

select * from cust_summ (obs=10);

quit;

/*Question-2*/

proc sql;
create table cat_exp as
select category, sum(expense) as expense
from c.ccu
group by category
order by expense desc
;

Title "Question-3: Top 3 categories by expenses";
select * from cat_exp (obs=3);
quit;

/*Question-3*/

proc sql;
Title "Question-4: Average expenses by each customer in september";

select custid, avg(expense) as avg_exp_sep
from c.ccu

/* where date between '01SEP2012'd and '30SEP2012'd */

/*or */

where month(date) = 9

group by custid;

quit;

/*Question-4*/

proc sql;
Title "Question-2: Distinct categories";
select category, count(category) as cnt  from c.ccu
group by category
order by cnt desc;


proc sql;
select distinct category from c.ccu;
select count(distinct category) from c.ccu;
quit;



/*Question-5*/
proc sql;

Title "Question-5: Avg, std of expense by each category and across categories in single table";

select "Overall" as category, avg(expense) as exp_avg, std(expense) as exp_stdev
from c.ccu

UNION corresponding ALL

select category, avg(expense) as exp_avg, std(expense) as exp_stdev
from c.ccu
group by category;

quit;

/*Question-6*/

proc sql;

Title "Question-6: customers cnt with expense in  atleast 5 categories";

select custid, count(distinct category) as dist_cat_cnt
from c.ccu
group by custid
having dist_cat_cnt >= 5;

Title "Question-6: customers cnt with expense in  all categories";
select custid, count(distinct category) as dist_cat_cnt
from c.ccu
group by custid

having dist_cat_cnt = (select count(distinct category) from c.ccu);

quit;

/*Question related to CASE-WHEN

Corresponding to each id calculate total expense and expenses by categories defined as:

 electronics: laptops,cellphone,tablets
 home: clothes,food,medicines
 other: toys,club,casino,books,movie*/
 
 
 
proc sql;
create table cust_pro as
select custid ,

SUM(CASE WHEN category='laptops' or category='cellphone' or category='tablets' THEN expense ELSE 0 END) as expense_electronic,
SUM(CASE WHEN category in ('clothes' 'food' 'medicines') THEN expense ELSE 0 END) as expense_home,
SUM(CASE WHEN category='toys' or category='club' or category='casino' or category='books' or category='movie' THEN expense ELSE 0 END) as expense_other,

sum(expense)as Total_expense

/* OR */

/* (calculated expense_electronic + calculated expense_home + calculated expense_other) as Total_expense */

from c.ccu
group by custid
order by custid;
quit;

/*Case Study-2

Datasets gaming1,2,3 have data from a gaming company
which lets players play dota, starcraft, aoe and CS on their servers .
They have collected data on 1000+ players which have gamers id, their OS,
average time spent per session, license type, session type, game name and
native network speed.

Extract following information from these data sets.

.Create 360 degree view(consolidation of all tables) of gamers using gamerid(one record for each gamer id)

.From consolidation table, Extract Players with mac os who play dota as solo and spend more than
  40 minutes per session on free version of license.

.From consolidation table, Average time spent  and standard deviation of ATPS for each game
  across OS type and network speeds

.Create tables a and b and do all four joins based on game type as id
where tables a and b are as follows:

.A: distinct combination of game name, license version and session type present
    in the data set for cs , aoe , dota games
.B: average time spent per session for only dota and starcraft games across network speed and OS */

/*Question-1*/
proc sql;
create table consolidate as
select a.*, b.*, c.*
from c.gaming1 as a left join c.gaming2 as b on a.gamer_id = b.gamer_id
      left join c.gaming3 as c on a.gamer_id = c.gamer_id
;
quit;

/*Question-2*/

proc sql;
select * from consolidate
where OS like '%mac%' and _game_name = 'dota'  and session_type = 'solo'
and license  ='free' and ATPS >40;
quit;

/*Question-3*/


proc sql;
select _game_name, os, netspeed , avg(ATPS) as avg_time_spent, std(atps) as std_time_spent
from consolidate
group by  _game_name, os, netspeed
;
quit;

/*Question-4*/

/*Creating Data sets*/

/*A: distinct combination of game name, license version and session type present */
/*    in the data set for cs , aoe , dota games  */
/*B:average time spent per session for only dota and starcraft games across network speed and OS*/

Proc Sql;
create table DS_A as
select distinct _game_name, license, session_type
from consolidate
where _game_name ne "starcraft" ;

create table DS_B as
select distinct _game_name, netspeed, OS, avg(ATPS) as avg_time_spent
from consolidate
where  _game_name = "dota" or _game_name = "starcraft"
group by _game_name, netspeed, OS;
Quit;

/*Performing All four joins*/


proc sql;
create table Inner_join as
select a.*, b.*
from DS_A as a inner join DS_B as b on a._game_name = b._game_name;

create table LEft_join as
select a.*, b.*
from DS_A as a Left join DS_B as b on a._game_name = b._game_name;

create table right_join as
select a.*, b.*
from DS_A as a right join DS_B as b on a._game_name = b._game_name;

create table full_join as
select a.*, b.*
from DS_A as a full join DS_B as b on a._game_name = b._game_name;

quit;
