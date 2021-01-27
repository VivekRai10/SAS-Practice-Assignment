/*Appending*/
Data A;
Input ID Var_A $;
Cards;
1 A1
2 A2
3 A3
;
run;

Data B;
Input ID Var_A $ Var_B $ ;
Cards;
1 A6 B1
2 A7 B2
4 A8 B3
;
run;

Data C;
set A B;
run;

Data C;
set A B;
drop var_B;
run;

proc append base=A data=B;
run;

/*Merging*/

Data Demog;
Input Obs ID $ Age Gender $ DoB mmddyy8.;
format DoB mmddyy8.;
Cards;
1 A001 21 m 05/22/75
2 A002 32 m 06/15/63
3 A003 24 f 08/17/72
4 A004 .  m  03/27/69
5 A005 44 f 02/24/52
6 A007 39 m 11/11/57
;
run;


Data Visits;
Input Obs ID $ Visit SysBP DiasBP Weight Date_visit mmddyy8.;
format Date_visit mmddyy8.;
Cards;
1 A001 1 140 85 195 11/05/98
2 A001 2 138 90 198 10/13/98
3 A001 3 145 95 200 07/04/98
4 A002 1 121 75 168 04/14/98
5 A003 1 118 68 125 08/12/98
6 A003 2 112 65 123 08/21/98
7 A004 1 143 86 204 03/30/98
8 A005 1 132 76 174 02/27/98
9 A005 2 132 78 175 07/11/98
10 A005 3 134 78 176 04/16/98
11 A008 1 126 80 182 05/22/98
;
run;

proc sort data=Demog;
by ID;
run;

proc sort data=Visits;
by ID;
run;


Data Combined;
merge demog visits;
by ID;
run;

Data Combined_common;
merge demog (in=a) visits (in=b);
by ID;
if a=1 and b=1;
run;

/*Accummulator variable*/
data bank_tot;
set k.bank_transactions;
retain total 0;
total=total+amount;
run;

data bank_tot;
set k.bank_transactions;
total+amount;
run;

/*By-group processing*/
proc sort data=k.bank_transactions out=trans;
by Year month;
run;

data trans_fl;
set trans;
by year month;
if first.month=1 then monthly_amnt=0;
monthly_amnt+amount;
if last.month=1;
keep year month day monthly_amnt;
run;
