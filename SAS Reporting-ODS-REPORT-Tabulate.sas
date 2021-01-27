*Proc Tabulate - Pivot tables in excel;
*proc report - proc print, proc sort, proc means/proc summary, formating capabilities;


libname c "C:\Users\Chandra Mouli Kotta\Desktop\Stats Test";

proc contents data=c.cust_seg varnum; run;



/*The COLUMN statement is insufficient to provide total control of the appearance of individual columns and how they are to be used. This task falls to the DEFINE statement.*/
/*DEFINE types include:*/
/*• display Shows or displays the value of the variable (default for character variables).*/
/*• group Consolidate observations using this variable.*/
/*• analysis Used in calculations with a statistic (default type for numeric variables).*/
/*• computed Specifies a variable not on the incoming data set that is to be created in a compute block.*/
/*• order Sorts the data and forms groups when summary statistics are requested.*/
/*• across Used to create groups across the page rather than down the page.*/

/*OTHER DEFINE STATEMENT OPTIONS*/
/*• A number of supplemental options can be used with the design statement to augment the display of the information. Some of these other options include:*/
/*• format Specifies how the information within this column is to be formatted.*/
/*• width Width of column, number of characters to allocate.*/
/*• noprint This column is not to be displayed.*/
/*• flow Text that is wider than the 'width=' option wraps within the block (split characters are supported).*/
/*• statistic Statistic to be calculated (analysis variables).*/

/*A number of options are available with the BREAK and RBREAK statements. These include:*/
/*• OL inserts an overline*/
/*• DOL inserts a double overline*/
/*• UL inserts an underline*/
/*• DUL inserts a double underline*/
/*• summarize calculates an across group summary*/
/*• skip skips a line after the break*/
/*• suppress suppresses the printing or overlines and underlines around the group variables. */

libname c "C:\Users\Chandra Mouli Kotta\Desktop\Stats Test\SAS Reporting";
proc print data=c.cust_seg; 
var custid AqChannel;
run;

proc report data=c.cust_seg; 
column custid AqChannel;
run;


proc report data=c.cust_seg; run;
proc report data=sashelp.cars headline;
column make model type origin msrp;
where type="SUV";
run;

proc report data=c.cust_seg ;
columns region gender post_usage_1month pre_usage;
define region/group "Region" ;
define gender/group  "Gender";
define post_usage_1month/ mean   "Post_usage_avg" format=comma8.2;
define pre_usage/max  "Pre_usage_max" format=dollar8.2;
break after region / summarize style=[foreground=black background=blue];
rbreak after /ol  summarize style=[foreground=black background=red];
run;


proc report data=c.cust_seg nofs split='*';
column region gender post_usage_1month post_usage_1month=post_usage_1month_avg;
define region / group width=6 'Region*--';
define gender / group width=6 'Gender*--' ;
define post_usage_1month / analysis n format=5. 'Count*--';
define post_usage_1month_avg / analysis mean format=6.2 'Mean*--';
break after region / ol skip summarize;
rbreak after / dol skip summarize;
title1 'Using Proc REPORT';
title2 'RBREAK At the End of the Report';
run;

/*PROC TABULATE*******************************************************************************************/

proc tabulate data =c.cust_seg;
Title " SUMMARY of PREUSAGE VS. POST USAGE BY REGION, GENDER and SEGMENT";
  class region gender segment;
  var post_usage_1month pre_usage;
  table (segment=segment * gender = Gender) , region = cust_region*(post_usage_1month=PostUsage pre_usage=Pre_usage)*(mean="")
;
/*  where region=1;*/
run;

proc tabulate data =c.cust_seg;
  class region gender;
  var post_usage_1month;
  table region*mean, post_usage_1month*gender;
run;

proc tabulate data = c.cust_seg;
  class region gender;
  var post_usage_1month;
  table region='customer region'*mean, 
        post_usage_1month='Mean post usage'*gender;
run;

proc tabulate data=c.cust_seg;
  class region gender;
  var post_usage_1month;
  table region='Customer region', 
        mean=' '*post_usage_1month='Mean post usage'*gender='';
run;

proc tabulate data=c.cust_seg;
/*  class region gender;*/
  class region/ style=[foreground=black background=red];
  class gender/  style=[foreground=black background=blue];
  var post_usage_1month;
  table region*mean, 
        post_usage_1month*gender /style=[foreground=black background=red] ;
run;

proc tabulate data = c.cust_seg;
  class region gender;
  var post_usage_1month post_usage_2ndmonth;
  table region*mean*(post_usage_1month post_usage_2ndmonth), 
        gender;
run;



proc tabulate data = c.cust_seg;
  class region gender segment;
  var post_usage_1month post_usage_2ndmonth;
  table region='customer region'*segment='segment Type'*(mean std),
        (post_usage_1month='post usage of campaign from 1 month' post_usage_2ndmonth='Post Usage of campaing from 2nd month')*gender=''/ rts=43 ;
run;

/*ODS - Output delivery systems************************************************************************************************/

ods html body = "C:\Users\Chandra Mouli Kotta\Desktop\Stats Test\Summary1.html";
ods pdf file = "C:\Users\Chandra Mouli Kotta\Desktop\Stats Test\Summary1.pdf";

proc tabulate data = c.cust_seg;
Title 'Summary report by region & gender';
  class region gender;
  var post_usage_1month post_usage_2ndmonth;
  table region*mean*(post_usage_1month post_usage_2ndmonth), 
        gender;
run;



proc tabulate data = c.cust_seg;
  class region gender segment;
  var post_usage_1month post_usage_2ndmonth;
  table region='customer region'*segment='segment Type'*(mean std),
        (post_usage_1month='post usage of campaign from 1 month' post_usage_2ndmonth='Post Usage of campaing from 2nd month')*gender=''/ rts=43 ;
run;

Title '';

ods html close;
ods html close;
/*ods _all_ colse;*/





