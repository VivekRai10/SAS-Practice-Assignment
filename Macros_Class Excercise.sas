
/*Excercise-1*/

/*Assigning value to macro variables*/

/*Leading and trailing blanks are removed before assignment */
/*Quotes bounding literals are stored as part of value */
/*The case of value of preserved*/
/*Numeric tokens are stored as character strings*/
/*Mathematical expression are not evaluated*/

/*Use the rules on the above to determine the values assigned
   to macro variables by the following %LET statements*/

%let city = New Delhi;

%let city2 = '  New  Delhi  ';

%let title = "April's Report";

%let start =;

%let total = 0;

%let sum = 3 + 5;

%let total = &total + &sum;

%let x = varlist;

%let &x = name age height;



%put &&x ;


%put &&varlist;




%put &city;

%put &sum;


%put &total;

%put &x;



%put &title;

%put &city; /*display value stored in macro variable ‘city’*/

%put _USER_; /*list of all user defined macro variables */

%put _AUTOMATIC_; /*list of all automatic macros */

/*Excercise-2*/

/*Using macro variables in normal program*/

/*Import the dataset “models.txt”.
Print the list of class “Mountain”, “Road” and “Track” bikes separately.
Format the price in currency format DOLLAR6.
Title of output should be “Current models of <class> bikes”. */

DATA models;

INFILE 'D:\Google Drive\alabs\Analytics\SAS\Sample codes for class\Macros class exercise and files\models.txt';

INPUT Model $ Class $ Price Frame $;

PROC PRINT;

RUN;



%LET bikeclass = Mountain;

%LET bikeclass = Road;

%LET bikeclass = Track;


PROC PRINT DATA = models NOOBS;

WHERE Class = "&bikeclass";

FORMAT Price DOLLAR6.;

TITLE "Current Models of &bikeclass Bicycles";

RUN;



/*Excercise-3*/

/*Difference between Keyword parameters & position Parameters*/


%macro print;

proc print data=sashelp.retail;
    where month in (1);
run;

%mend;

%print;


%macro print(dataset, filter, filter_val);


proc print data=&dataset.;

    where &filter. in (&filter_val.) and ;

run;


%mend;



%print(sashelp.retail, month, 1 7);

%print(sashelp.retail, year, 1980 1981);


%print(dataset=sashelp.retail,filter=year, filter_val=1981 1980 );


%print(dataset=sashelp.retail,filter=month, filter_val=1 );




/*Excercise-4*/

/*Text + Variable  Variable + Text*/

%let mon = JAN;

%let num = 12;

/*month_of_&mon         resolves to     month_of_JAN*/
/*year&num      resolves to     year12*/

/*&mon.balance  resolves to     JANbalance*/
/*&num.year     resolves to     12year*/

/*Using Macro character functions*/
/*a. Define the following text string as macro variable “vars”
        spss sas matlab stata eviews
b. Display the following text in log:
“Stata is at position <location>.”
“Character count is <count>.”
The full string in upper case.
Pull the string ‘sas’ using the function %SCAN.
Pull the string ‘matlab’ using the function %SUBSTR. */

%let vars = spss sas matlab stata eviews;

%let pos = %index(&vars , stata);

%put Stata is at position &pos..;

%let num = %length(&vars);

%put Character count is &num..;

%let up = %upcase(&vars);
%put &up;

%let select = %scan(&vars, 2);
%put &select;

%let subword = %substr(&vars, 10, 6);
%put &subword;


/*Macro evaluation functions*/

%let x=5;

%let y=&x+1;

%let z=%eval(&x+1);

%put &x &y &z;

%let x=5;

%let y=&x+1.234;

%let z=%sysevalf(&x+1.234);

%put &x &y &z;




/*Macro quoting functions*/

%let p=proc print; run;;

%let p=%str(proc print; run;);

%put &p;

%let c = %bquote(Jan Month's Report);

%let c = Jan Month's Report;

%put &c;




/*Excercise-5*/

/*Using Call Symput & symget*/

/*a. Import the dataset “client.txt”.*/
/*b. Add all the product numbers and store the total in a macro variable.*/
/*Transfering data step variable value to macro variable*/

PROC IMPORT OUT= WORK.client
            DATAFILE= "D:\Google Drive\alabs\Analytics\SAS\Sample codes for class\Macros class exercise and files\client.txt"
            DBMS=TAB REPLACE;
     GETNAMES=YES;
     DATAROW=2;
PROC PRINT;
RUN;

data test ;
set client end = eof;
retain cml 0;
cml = cml + product;
if eof = 1 then call symput('mac_cml',cml);run;
proc print;
run;
%put &mac_cml;

/*Transferring information between DATA step and Macro processor*/
/*Performing table lookup using SYMGET*/
/*a. Import the datasets “client.txt” and “supplier.txt”.*/
/*b. Lookup the variable “supplier” using the key variable “product” from “client” dataset,*/
/*and save as a new dataset “client_supplier”.*/

PROC IMPORT OUT= WORK.supplier
            DATAFILE= "C:\Users\Chandra Mouli Kotta\Desktop\alabs\SAS Macros\Raw Data\supplier.txt"
            DBMS=TAB REPLACE;
     GETNAMES=YES;
     DATAROW=2;
PROC PRINT;
RUN;
/*Assign Macro variables*/
data _NULL_;
set supplier;
call symput('prod'||left(product),supplier);
run;
/*Table lookup using SYMGET*/
data client_supplier;
set client;
supplier = symget('prod'||left(product));
run;




/*Excersie-6*/


/* Write a macro that takes color as macro parameter and executes either of the
two codes to display the following depending upon the color.
color object Output
red   Roses  Roses are red.
blue  Violets Violets are blue.
other         Color not found. */

%macro color_test(color);

%if &color = red %then
        %do;
                %let object = Roses ;
                %put &object are &color.. ;
        %end;
%else %if &color = blue %then
        %do;
                %let object = Violets ;
                %put &object are &color.. ;
        %end;
%else %put Color not found. ;

%mend;
%color_test(red);
%color_test(blue);
%color_test(green);

/*Excercise-7*/

/*Creating macro variables using PROC SQL */
/*
a. Create a macro variable containing the sum of price for all models from the dataset ‘models’.
B. Create a macro variable containing space separated list of all models from the dataset ‘models’.*/

/*Transferring summary statistics into macro*/
proc sql;
select sum(price) into :pr
from models;
quit;
%put &pr;

/*Transferring list of values into macro*/
proc sql;
select model into :list separated by ' '
from models;
quit;
%put &list;


/*Excercise-8*/

/*Using macro in as part of work.*/

/* Create variable list by using macro variables
write a macro to find out correlations between dependent variables and variable list created as in (1)*/

%Let varlist_1=
price1 price2 price3 ;

%Let varlist_2=
price1 price2 price3 price4 price5 price6 price7;

%Let varlist_3 =
price1 price2 price3 price4 price5 price6 price7 price8 price9 price10;
;

options mprint;
/*symbolgen mlogic merror serror;*/

%macro corrs(dataset=, deps=,indeps=,filter=, filter_val=);
proc corr data=&dataset. noprob nosimple outp=wtr_corrs;
   var &deps.;
   with &indeps.;
where &filter in (&filter_val );
run;
%mend;

ods html file="C:\Users\Chandra Mouli Kotta\Desktop\alabs\SAS Macros\WTR_Corrs.xls" style=minimal;
%corrs(dataset=sashelp.pricedata, deps=sale,indeps=&varlist_1,filter=regionname, filter_val="Region1");
/*%corrs(dataset=sashelp.pricedata, deps=sale,indeps=&varlist_2,filter=regionname, filter_val="Region2");*/
/*%corrs(dataset=sashelp.pricedata, deps=sale,indeps=&varlist_3,filter=regionname, filter_val="Region3");*/
ods html close;
