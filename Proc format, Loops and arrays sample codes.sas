libname k "C:\Users\Desktop\SAS";

proc import datafile="C:\Documents and Settings\wwinxp\Desktop\assignment2\Grocery_coupons.xls" 
out=work.Grocery_coupons dbms=xls replace; getnames='yes'; datarow=2;
run;

PROC FORMAT lib=K;
VALUE Health_food_store
0=’NO’
1=’YES’;
VALUE Size_of_store
1=’SMALL’
2=’MEDIUM’
3=’LARGE’;
VALUE Gender
0=’MALE’
1=’FEMALE’;
VALUE amount
low-100= 'Low spend'
100-150= 'Average'
150-high= 'High spend';
RUN;

options fmtsearch =(k);
data k.GROCERY;
set k.GROCERY;
format hlthfood Health_food_store. size Size_of_store. gender Gender.;
run;

proc freq data=k.grocery;
table vegetarian amtspent;
format amtspent amount.;
run;

data earnings;
amount=1000;
rate=.075/2;
	do month =1 to 12;
	earned+(amount+earned)*rate;
	output;
	end;
run;


data invest;
input amount;
cards;
1000
1500
2500
;
run;
data earnings;
set invest;
rate=.075/2;
	do month =1 to 12;
	earned+(amount+earned)*rate;
	output;
	end;
run;

data earn2;
	do year=1 to 20;
	Capital+2000 ;
		do month = 1 to 12 ;
		Interest = capital * (.075/12) ;
		capital + interest ;
		output;
		end;
	end;
run;

/*Conditional loops*/
data invest;
	do until (Capital>50000);
	capital+2000;
	capital+(capital*.10);
	Year+1;
	output;
	end;
run;

/*do while (Capital<50000);*/

data invest;
	capital=51000;	
	do while (Capital<50000);
	capital+2000;
	capital+(capital*.10);
	Year+1;
	output;
	end;
run;

/*Infinite loop*/
data invest2;                                                                                                              capital=51000;                                                                                                             
      do while (Capital>0);                                                                                                
      capital+51000;                                                                                                       
      capital+(capital*.10);                                                                                               
      Year+1;                                                                                                              
      output;                                                                                                              
      end;                                                                                                                 
run;  

data earn;
Value =200000;
do Year =20 to 1 by -1;
Interest = value*.1 ;
value + interest ;
if value>300000 then fund_val="+ve"; else fund_val="Neutral";
output ;
end;
run;

data array_temp;
input mon tue wed thu fri sat sun;
datalines;
78 83 74 79 77 81 69
78 83 74 79 77 81 69
78 83 74 79 77 81 69
78 83 74 79 77 81 69
78 83 74 79 77 81 69
;
run;

data array_temp_0;
set array_temp;
array wkday {7} mon tue wed thu fri sat sun;
do i=1 to 7;
wkday{i}=(wkday{i}-32)*(5/9);
end;
run;

data array_wt;
input Name $ Weight1 Weight2 Weight3 Weight4 Weight5 Weight6;
datalines;
Alicia 69.6 68.9 68.8 67.4 66.0 66.2
Betsy 52.6 52.6 51.7 50.4 49.8 49.1
Brenda 68.6 67.6 67.0 66.4 65.8 65.2
Carl 67.6 66.6 66.0 65.4 64.8 64.2
Carmela 63.6 62.5 61.9 61.4 60.8 58.2
David 70.6 69.8 69.2 68.4 67.8 67.0
;
run;

data diff;
set array_wt;
array wt{6} weight1-weight6;
array WgtDiff{5};
do i=1 to 5;
wgtdiff {i} = wt {i+1} - wt {i};
end;
run;

/*array colr (3)$("Red" "Blue" "Green");*/