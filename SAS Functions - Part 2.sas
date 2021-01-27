/*PART 2*/

/****SAS Functions Part 2****/

/****The lag Function********/

data test;
input a;
cards;
13
45
56
67
87
256
;
data test1;
set test;
x=lag(a);
x1=lag1(a);
x2=lag2(a);
run;
proc print;
run;

/***The LEFT Function********/

/**Left aligns an argument*****/
data test;
input a $8.;
cards;
AS UIO
ADFGH
DFG
;
data test1(keep=y);
set test;
y=right(a);
run;
data test2;
set test1;
x=left(y);
run;
proc print;
run;
/***The length function********/

/***returns the length of an argument*******/
data test1;
set test;
l1=length(a);
run;
proc print;
run;

/***The Natural Logarithm********/
data test;
x=log(1);
y=log(2.71828);
run;
proc print;
run;

/****Logarithm to the Base 10****/
data test;
x=log10(1);
y=log10(10);
z=log10(100);
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

/****The Minute Function*******/

/**returns the minute from a SAS time or datetime value*******/
data test;
format tt time8.;
tt=hms(11,34,12);
mint=minute(tt);
run;
proc print;
run;

/****The Second Function*******/

/**returns the second from a SAS time or datetime value*******/
data test;
format ss time8.;
ss=hms(11,34,12);
sect=second(ss);
run;
proc print;
run;

/****The Mod Function*******/ 

/****Returns the remainder when argument1 is divided by argument2*****/
data test;
input a b;
cards;
12.2 5.2
15.8 5
40 3
;
data test1;
set test;
x=mod(a,b);
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
12
1
124
5678
;
data test1;
set test;
x=put(a,z4.);
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

/*******The Repeat Function**********/

/***repeats a character expression*******/
data test;
x=repeat('2',5);
run;
proc print;
run;
/*******The Reverse Function**********/

/***reverses a character expression*******/
data test;
x=reverse('ONE');
run;
proc print;
run;

/***The RIGHT Function********/

/**Right aligns an argument*****/
data test;
input a $8.;
cards;
ASUIO
ADFG
DFG
;
data test1;
set test;
y=left(a);
x=right(y);
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

/****The Ranuni Function (generating random numbers by using uniform distribution*******/

data test;
input a;
cards;
22
45
56
67
34
45
33
43
99
;
data test1 test2;
set test;
if ranuni(7777) le 0.3 then output test1; else output test2;
run;
proc print data=test1;
run;
proc print data=test2;run;


/****The Rannor Function (generating random numbers by using normal distribution*******/

data test;
input a;
cards;
22
45
56
67
34
45
33
43
99
;
data test1 test2;
set test;
if rannor(7777) le 0.3 then output test1; else output test2;
run;
proc print data=test1;
run;
proc print data=test2;run;
