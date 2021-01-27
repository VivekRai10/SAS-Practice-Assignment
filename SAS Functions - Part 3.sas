/****SAS FUNCTIONS PART 3****/

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

/***The Sign Function********/

/***Returns the value of -1 if the var<0, 0 if the var=0 and 1 if the var>0****/
data test;
input a;
cards;
12
34
0
0
-56
-66
;
data test1;
set test;
x=sign(a);
run;
proc print;
run;

/***The SQRT Function********/

/***Square Root of a Value*****/
data test;
input a;
cards;
25
625
2
;
data test1;
set test;
x=sqrt(a);
run;
proc print;
run;

/***The STD Function********/

/***standard deviation******/
data test;
x=std(12.45,34.56,87.89);
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

/****Sum Function*******/
data test;
x=sum(23,876,10,67);
x1=sum(-12,-45,-32,-2);
run;
proc print;
run; 

/***Time Function****/

/**Returns the Current time of the day******/
data test;
ttime=time();
format ttime time9.;
run;
proc print;
run;

/****The Timepart Function*****/

/***returns the time part from the datetime format******/
data test;
format dt datetime18.;
dt=dhms('01Oct2004'd,11,34,12);
format x time9.;
x=timepart(dt);
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

/*****The Upcase and Lowcase Function*********/
data test;
input a $8.;
cards;
ioyf
hffh
ytht
;
data test1;
set test; 
x=upcase(a);
y=lowcase(x);
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

/*****The YYQ Function*********/ 

/****returns the first date of the quarter in the specified year********/
data test;
format x date9.;
x=yyq(2004,3);
run;
proc print;
run;
