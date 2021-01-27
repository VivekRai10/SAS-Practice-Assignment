/*
Sum
mean
min
max
var
Std
input
put
Year
QTR
Month
day
weekday
mdy
date
today
time
intck
intnx
datepart
datdif
yrdif
scan
substr
trim
catx
index
find
upcase
lowcase
propcase
Tranwrd
translate-Replaces or removes all occurrences of a character within a character string
Int
round
*/


libname s "D:\Google Drive\alabs\Analytics\SAS\Sample codes for class";

data usage;

set s.cust_seg;

avg_usage=mean(Post_usage_1month,Latest_mon_usage);

run;





/****Sum Function*******/

data test;

x=sum(23,876,10,67);

x1=sum(-12,-45,-32,-2);

run;

proc print;
run;

/****Mean Function*******/

data test;

x=mean(23,876,10,67);

x1=mean(-12,-45,-32,-2);

run;

proc print;
run;

/****Min Function*******/

data test;

x=min(23,876,10,67);
x1=min(-12,-45,-32,-2);

run;

proc print;
run;

/****Max Function*******/
data test;

x=max(23,876,10,67);
x1=max(-12,-45,-32,-2);

run;

proc print;
run;


/***The STD &var Function********/

/***standard deviation & Variance******/

data test;

x=std(12.45,34.56,87.89);

x1=var(12.45,34.56,87.89);

run;

proc print;
run;

/****The Input function*******/

/***converts character vars to numeric vars********/



data cars;

set s.car_sales;

Ldate=input(Latest_launch,date9.);

format Ldate date9.;

run;



data test;
input a $8.;
cards;
125678
342639
563843
655454
;



data test1;
set test;

x=input(a,8.);

z=a*1;

run;


proc print;
run;
proc contents;
run;


/********The PUT Function*************/



/***converts numeric vars to character vars********/
data test;
input a ;
cards;
125678
342639
563843
655454
;

data test1;
set test;

x=put(a,8.);

run;

proc print;
run;

proc contents;
run;

/****Appending forced zeroes using the PUT Function********/
data test;
input a;
cards;
0012
0001
0124
5678
;

data test1;
set test;
x=put(a,z4.);
run;

proc print;
run;


/*****The Year Function*********/

/***returns the year from a SAS date value*******/
data test;
informat a date9.;
format a date9.;
input a;
cards;
03Oct2004
15Dec2002
;

data test1;
set test;

x=year(a);

run;

proc print;
run;

/*****The Quarter Function*********/

/***returns the yearly quarter from a SAS date value*******/
data test;
informat a date9.;
format a date9.;
input a;
cards;
03Oct2004
15jan2004
;

data test1;
set test;
y=qtr(a);
run;

proc print;
run;

/*****The Month Function*********/

/***returns the month from a SAS date value*******/
data test;
informat a date9.;
format a date9.;
input a;
cards;
03Oct2004
15Dec2004
;
data test1;
set test;
x=month(a);
run;
proc print;
run;

/***Day Function*****/

/***returns the day of the month from a SAS date value****/
data test;
informat a date9.;
format a date9.;
input a;
cards;

03Oct2004
15Oct2004
;

data test1;
set test;
x=day(a);
run;

proc print;
run;

/****The Weekday Function*******/

/******returns the day of the week from a SAS date value******/
/**Note : 1 implies Sunday and 7 implies Saturday*****/

data test;

x=weekday('16Sep2005'd);
run;

proc print;
run;

/****The MDY Function*****/

/***returns a SAS date value from month, day and year values******/
data test;
input dd mm yy;
cards;
12 8 2004
18 3 2002
;

data test1;
set test;
format dt date9.;
dt=mdy(mm,dd,yy);
run;

proc print;
run;

/***Date Function****/

/**Returns the Current date as a SAS Date Value******/
data test;

tday=date();

/*format tday date9.;*/

run;

proc print;
run;


/***Today Function****/

/**Returns the Current date as a SAS Date Value******/
data test;
tday=today();
format tday date9.;
run;
proc print;
run;

/***Time Function****/

/**Returns the Current time of the day******/

data test;
ttime=time();
dtime=datetime();
format ttime time9. dtime datetime16.;
run;

proc print;
run;


/****The Datepart Function*****/

/***returns the date part from the datetime format******/
data test1;
set test;
format x date9. y time7.;

x=datepart(dtime);

y=timepart(dtime);

run;

proc print;
run;






/****The INTCK Function********/

/****returns the number of intervals in a given time span*******/
data test;
dd=intck('day','01jan1999'd,'31Dec1999'd);
mm=intck('month','01jan1999'd,'31Dec1999'd);
ww=intck('week','01jan1999'd,'31Dec1999'd);
qq=intck('qtr','01jan1999'd,'31Dec1999'd);
yy=intck('year','01jan1999'd,'31Dec1999'd);
run;
proc print;
run;

/****The INTNX Function********/

/***Advances a date, time or datetime value by a given interval******/
data test;
format dd date9.;
dd=intnx('day','31Dec1999'd,-364);
format mm date9.;
mm=intnx('month','31Dec1999'd,-11);
format yy date9.;
yy=intnx('year','31Dec1999'd,0);
run;
proc print;
run;



/* Datdif - Calculate the difference in days between two SAS dates. Accept dates that are specified as SAS date values. */
/*DATDIF function gives the difference between two dates in number of days.*/

data test;
set test;
date= DATDIF('31Dec1989'd,'31Dec1999'd,'ACT/ACT');
run;

/* YRdif -Calculate the difference in years between two SAS dates
Accept start dates and end dates that are specified as SAS date values
Use a basis argument that describes how SAS calculates the date difference */
/*YRDIF function gives the difference between the two dates in number of years. */


data test;
set test;
date1= YRDIF ('31Dec2011'd,'31Dec2020'd, 'ACT/ACT');
run;



/******The Scan Function*******/

data test;
input a $12.;
cards;
we/yio/pu
tr/ipr
;
run;
data test1;
set test;
x=scan(a,2,'/');
x1=scan(a,1,'/');
run;
proc print;
run;

/***The SUBSTR Function********/

/****Extracts a substring from an argument or replaces character value contents*****/
/****use only in case of a character variable*********/
data test;
input a $12.;
cards;
671476076
886559852
546123454
;
/***Extracting a Sub String******/
data test1;
set test;
x=substr(a,3,2);
run;
proc print;
run;
/********Replacing a Sub String*****/
data test1;
set test;
substr(a,1,2)='AB';
run;
proc print;
run;

/******Trim Function******/

/***removes trailing blanks from character expressions*****/
data test;
input part1 $ 1-10 part2 $11-20;
cards;
app              stu
royt             rtt
;
run;
data test1;
set test;
p1=part1||part2;
p2=trim(part1)||part2;
run;
proc print;
run;

/* Catx -Enables to concatenate character strings, remove leading and trailing blanks, and insert separators
Results of the CATX function are usually equivalent to those that are produced by a combination of the concatenation operator and the TRIM and LEFT functions
The above program uses CATX function to concatenate the variables city, state & zip into new variable newaddress and separates each values with comma. */

Data zipcode ;
Set sashelp.zipcode;
NewAddress = CATX ( ',' , city , STATE, ZIP);
Run;

/* Index- Enables to search a character value for a specified string. Searches values from left to right, looking for the first occurrence of
the string. Returns the position of the string's first character. If the string is not found, it returns a value of 0. Is case sensitive.
*/
data test;
input name $50.;
cards;
spss sas matlab stata eviews
Business sas matlab Analytics eviews
Analytixlabs sas matlab stata eviews
;

Data test1;
Set test;
x=Index ( name , 'spss' );
y=Index ( name , 'labs' );
z=Index ( name , 'Analyti');
Run;

/* Find- Search for a specific substring of characters within a character string specified. Returns the position of that substring.
If the substring is not found in the string, returns a value of 0. Similar to the INDEX function.*/

Data test1;
Set test;
x=Find ( name , 'spss' );
y=Find ( name , 'labs','t',10 );
z=Find ( name , 'Analyti','t',15);
Run;

/*****The Upcase, Lowcase and Propcase Function*********/
data test;
input a $12.;
cards;
ioyf chm
hffh fac
ytht dms
;
data test1;
set test;
x=upcase(a);
y=lowcase(x);
y=propcase(x);
run;
proc print;
run;

/*tranwrd-Replaces or removes all occurrences of a pattern of characters within a character string
Translated characters can be located anywhere in the string

The above program change all occurrences of Miss or Mrs. to Ms. in the variable name. */
data test;
input name $30.;
cards;
Mrs. Rajesh
Miss Laxmi
Ms. Prabha
;

Data test1;
Set test;
name1 = TRANWRD (name, 'Miss', 'Ms.');
name2 = TRANWRD (name ,'Mrs. ','Ms.');
Run;


/*translate-Replaces or removes all occurrences of a character within a character string
The below program will replace all the A’s with X, B’s with Y and C’s with Z in the name variable*/
data test;
input name $12.;
cards;
Xoyf ZhY
XCfZ YBc
AytB dmX
;

Data test1;
Set test;
name1 = TRANSLATE (name, 'XYZ', 'ABC.');
Run;


/***The INT function********/

/****returns the integer portion of the argument
If the argument's value is positive the result is the same as that of the Floor Function
If the argument's value is negative the result is the same as that of the Ceil Function*******/
data test;
input a;
cards;
12.34
15.67
-12.45
-14.66
;
data test1;
set test;
x=int(a);
run;
proc print;
run;

/***The Round Function********/

/***Rounds to the nearest round-off unit*******/
data test;
x=round(223.456);
x1=round(223.456,1);
x2=round(223.456,10);
x3=round(223.456,100);
x4=round(223.456,.1);
x5=round(223.456,.01);
run;
proc print;
run;
