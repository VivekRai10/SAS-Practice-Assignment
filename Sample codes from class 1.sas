/*Some sample codes for reference along with study material*/
/*assigning Permanent Library in portable version*/
libname S "C:\Users\alabs\Analytics\SAS\Sample codes for class";
/*assigning Permanent Library in University edition version*/
libname S '/folders/myfolders/SAS/Sample codes for class';

/*Copying data from work library to permanent library*/
Data S.Car_sales;
set car_sales;
run;

/*Copying data from work library to permanent library and adding a new column*/
Data S.Car_sales;
set car_sales;
Price_INR=Price_in_thousands*1000*65;
run;

/*Using proc import to import data from a CSV file - portable version*/
/*Method 1 - specifying DBMS (Data Base Management System) and delimiter*/
proc import datafile ="C:\Users\alabs\Analytics\SAS\Sample data for class\Car_sales_data.csv" out=work.car_sales dbms=csv replace;
getnames=Yes; datarow=2;
run;
/*Using proc import to import data from a CSV file - university edition version*/
/*Method 1 - specifying DBMS (Data Base Management System) and delimiter*/
proc import datafile ='/folders/myfolders/SAS/Sample data for class/Car_sales_data.csv' out=work.car_sales dbms=csv replace;
getnames=Yes; datarow=2;
run;

/*Method 2 - specifying delimiter instaed of DBMS - portable version*/
proc import datafile ='C:\Users\alabs\Analytics\SAS\Sample data for class\Car_sales_data.csv' out=work.car_sales_2 dbms=dlm replace;
delimiter=","; getnames=yes; datarow=2;
run;
/*Method 2 - specifying delimiter instaed of DBMS - university edition*/
proc import datafile ='/folders/myfolders/SAS/Sample data for class/Car_sales_data.csv' out=work.car_sales_2 dbms=dlm replace;
delimiter=","; getnames=yes; datarow=2;
run;

/*Using Proc contents to see the contents of Car_sales_data*/
proc contents data=Car_sales_data;
run;
/*Using Proc contents to see the contents of ALL THE DATASETS IN A SPECIFIED LIBRARY along with changing
the sorting order of variable names*/
proc contents data=S._all_ varnum;
run;

proc sort data=Car_sales1;
by manufacturer descending sales_in_thousands;
run;

proc copy in=S out=work;
select grocery car_sales; /*(Select statement - only if to copy selected data sets otherwise will copy all the datasets present in "IN" Library)*/
run;

Data s.emp_details;
Input id $ name $ age Location $;
cards;
2458 Murray,W 42 NCRGGN
2462 Almers,C 38 BAG
2501 Bonaventure,T 48 MUM
2523 Johnson,R 39 NCR
2539 LaMance,K 45 MUM
2544 Jones,M 49 BAG
;
run;

Data s.emp_details;
length name $15.;
Input id $ name $ age Location $;
cards4;
2458 Murray,W 42 NCR;GGN
2462 Almers,C 38 BAG
2501 Bonaventure,T 48 MUM
2523 Johnson,R 39 NCR
2539 LaMance,K 45 MUM
2544 Jones,M 49 BAG
;;;;
run;