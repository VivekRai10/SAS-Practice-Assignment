 /*  Functions*/
/*A SAS function performs a computation or system manipulation on
arguments and returns a value. Most functions use arguments supplied
 by the user, but a few obtain their arguments from the operating environment.*/

/*SAS has a number of in-built functions Broadly they can be classified as
/* Numerical(Mathematical-Trignometric-Hyperbolic, Financial,
statistical-Quantile-random number,
Character-Array,
Date & Time,
Conversion and Utilities,
Others */

libname class5 '/folders/myfolders/sample dataset';

/* Numerical Functions */

data stores1;
set class5.stores;
Total_cost = sum(OperatingCost, AcqCostPercust*Total_Customers)*-1;
avg_sales =  mean(sales_m1, sales_m2, sales_m3, sales_m4, sales_m5,sales_m6,sales_m7,
                 sales_m8, sales_m9, sales_m10, sales_m11, sales_m12);
sum_sales =  sum(sales_m1, sales_m2, sales_m3, sales_m4, sales_m5,sales_m6,sales_m7,
                 sales_m8, sales_m9, sales_m10, sales_m11, sales_m12);
avg_sales1 = mean(of sales_m1- sales_m12);
sum_sales1 =sum(of sales_:);
min_sales = min(of sales_m1- sales_m12);
max_sales = max(of sales_m1- sales_m12);
median_sales = median(of sales_m1- sales_m12);
var_sales = var(of sales_m1- sales_m12);
std_sales = std(of sales_m1- sales_m12);
range_sales = range(of sales_m1- sales_m12);
run;

/* Conversion Functions */

Data stores2;
set class5.stores;
format Profit comma10.;
format date1 date9.;
format date2 date9.;
Profit = input(Latest_Month_Profit, comma10.);
date1 = input(Store_Launch_Date, date9.);
date2 = input(Store_Expansion_Date, date9.);
segment = put(storeSegment, 2.);
run;

/*Some More numeric Functions */

Data stores3;
set stores2;
ABS_PROFIT = ABS(Profit);
Round_BS = Round(BasketSize);
Int_BS= INT(BasketSize);
CEIL_BS = CEIL(BasketSize);
FLOOR_BS = FLOOR(BasketSize);
RUN;

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

/* Date & Time Functions */
data stores4;
set stores2;
keep date1 date2;
run;

data stores4;
set stores4;
store_launch_year= year(date1);
store_launch_month = month(date1);
store_launch_day = day(date1);
store_launch_week_day= weekday(date1);
store_launch_qtr = qtr(date1);
cur_today = mdy(2,13, 2016);
cur_now = datetime();
cur_today1 = today();
x=datepart(cur_now);
y=timepart(cur_now);

n_y=intck('year',date1,date2);
n_m=intck('month',date1,date2);
n_q=intck('qtr',date1,date2);
n_w=intck('week',date1,date2);
n_d=intck('day',date1,date2);

n1_y=intnx('year',date1,2);
n1_m=intnx('month',date1,4,'m');

o_n=datdif(date1,date2,'act/act');
o_n1=datdif(date1,date2,'30/360');

o_n2=yrdif(date1,date2,'act/act');
o_n3=yrdif(date1,date2,'30/360');

format cur_today mmddyy10. cur_today1 mmddyy10. cur_now datetime16. x mmddyy10. y time8.
n1_y mmddyy10. n1_m mmddyy10.;
run;


/* Character Functions */

data stores5;
set stores;
keep store_manager_name Location storeid;
run;

data stores5;
set stores5;

length_name = length(store_manager_name);
length_col = lengthc(store_manager_name);
name = compress(store_manager_name, ",");
name1 = Lowcase(store_manager_name);
name2 = upcase(store_manager_name);
name3 = SUBSTR(store_manager_name,1,5);

City = SCAN(Location,1,"-");
Pincode = SCAN(Location,2,"-");

comma_Position = FIND(store_manager_name,",");
Hyphen_Position = FIND(storeid,"-");

new_location=cat(pincode,city);
new_name=catX(' ,', pincode,city);

Tran_word = Tranwrd(storeid, 'STR','STORE');
Trans_late = Translate(storeid, '12345', 'ABCDE');

RUN;

data temp;
cmp=compbl("  ABC   DEF  ");
run;
proc print;
run;

/*compbl - reduce multiple spaces to single space
compress (Default option is space) - remove all spaces
trim - remove trailing spaces*/

data temp;
pos_1 = find ("Sachin Tendulkar","kar");
pos_2 = find ("Sachin Tendulkar","ten");
pos_3 = find ("Sachin Tendulkar","ten","i"); /*ignore case*/
pos_4 = find ("Sachin Tendulkar","a",-99); /*search from right to left*/
run;

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