 
/***********************SAS MACROS WORKSHOP***************************/
/* Create the sample data set used for this work shop                */
/* Specify a LIBNAME statement to define a libref for BOOKS          */
/*********************************************************************/

libname Books "C:\Users\Chandra Mouli Kotta\Desktop\alabs\SAS\SAS Macros\";

data bookdb;

  attrib section  length=$30 label='Section'
         booktitle length=$50 label='Title of Book'
         author   length=$50 label='First Author'
         publisher length=$50 label='Publisher'
         cost     length=8 label='Wholesale Cost'
                  format=dollar10.2
         listprice length=8 label='List Price'
                  format=dollar10.2
         saleprice length=8 label='Sale Price'
                  format=dollar10.2;

  array sname{6} $ 30 ('Internet'
                       'Networks and Telecommunication'
                       'Operating Systems'
                       'Programming and Applications'
                       'Certification and Training'
                       'Web Design');

  array ln{125} $ 15 _temporary_ (
      'Smith        '  'Johnson      ' 'Williams     ' 'Jones        '
      'Brown        '  'Davis        ' 'Miller       ' 'Wilson       '
      'Moore        '  'Taylor       ' 'Anderson     ' 'Thomas       '
      'Jackson      '  'White        ' 'Harris       ' 'Martin       '
      'Thompson     '  'Garcia       ' 'Martinez     ' 'Robinson     '
      'Clark        '  'Rodriguez    ' 'Lewis        ' 'Lee          '
      'Walker       '  'Hall         ' 'Allen        ' 'Young        '
      'Hernandez    '  'King         ' 'Wright       ' 'Lopez        '
      'Hill         '  'Scott        ' 'Green        ' 'Adams        '
      'Baker        '  'Gonzalez     ' 'Nelson       ' 'Carter       '
      'Mitchell     '  'Perez        ' 'Roberts      ' 'Turner       '
      'Phillips     '  'Campbell     ' 'Parker       ' 'Evans        '
      'Edwards      '  'Collins      ' 'Stewart      ' 'Sanchez      '
      'Morris       '  'Rogers       ' 'Reed         ' 'Cook         '
      'Morgan       '  'Bell         ' 'Murphy       ' 'Bailey       '
      'Rivera       '  'Cooper       ' 'Richardson   ' 'Cox          '
      'Howard       '  'Ward         ' 'Torres       ' 'Peterson     '
      'Gray         '  'Ramirez      ' 'James        ' 'Watson       '
      'Brooks       '  'Kelly        ' 'Sanders      ' 'Price        '
      'Bennett      '  'Wood         ' 'Barnes       ' 'Ross         '
      'Henderson    '  'Coleman      ' 'Jenkins      ' 'Perry        '
      'Powell       '  'Long         ' 'Patterson    ' 'Hughes       '
      'Flores       '  'Washington   ' 'Butler       ' 'Simmons      '
      'Foster       '  'Gonzales     ' 'Bryant       ' 'Alexander    '
      'Russell      '  'Griffin      ' 'Diaz         ' 'Hayes        '
      'Myers        '  'Ford         ' 'Hamilton     ' 'Graham       '
      'Sullivan     '  'Wallace      ' 'Woods        ' 'Cole         '
      'West         '  'Jordan       ' 'Owens        ' 'Reynolds     '
      'Fisher       '  'Ellis        ' 'Harrison     ' 'Gibson       '
      'Mcdonald     '  'Cruz         ' 'Marshall     ' 'Ortiz        '
      'Gomez        '  'Murray       ' 'Freeman      ' 'Wells        '
      'Webb         ');

  array fn{70} $ 11 _temporary_ (
      'James      ' 'John       ' 'Robert     ' 'Michael    '
      'William    ' 'David      ' 'Richard    ' 'Charles    '
      'Joseph     ' 'Thomas     ' 'Christopher' 'Daniel     '
      'Paul       ' 'Mark       ' 'Donald     ' 'George     '
      'Kenneth    ' 'Steven     ' 'Edward     ' 'Brian      '
      'Ronald     ' 'Anthony    ' 'Kevin      ' 'Jason      '
      'Matthew    ' 'Gary       ' 'Timothy    ' 'Jose       '
      'Larry      ' 'Jeffrey    ' 'Jacob      ' 'Joshua     '
      'Ethan      ' 'Andrew     ' 'Nicholas   '
      'Mary       ' 'Patricia   ' 'Linda      ' 'Barbara    '
      'Elizabeth  ' 'Jennifer   ' 'Maria      ' 'Susan      '
      'Margaret   ' 'Dorothy    ' 'Lisa       ' 'Nancy      '
      'Karen      ' 'Betty      ' 'Helen      ' 'Sandra     '
      'Donna      ' 'Carol      ' 'Ruth       ' 'Sharon     '
      'Michelle   ' 'Laura      ' 'Sarah      ' 'Kimberly   '
      'Deborah    ' 'Jessica    ' 'Shirley    ' 'Cynthia    '
      'Angela     ' 'Melissa    ' 'Emily      ' 'Hannah     '
      'Emma       ' 'Ashley     ' 'Abigail    ');

  array pubname{12} $ 30 ('AMZ Publishers'    'Technology Smith'
                          'Mainst Media'       'Nifty New Books'
                          'Wide-World Titles' 'Popular Names Publishers'
                          'Eversons Books' 'Professional House Titles'
                          'IT Training Texts' 'Bookstore Brand Titles'
                          'Northern Associates Titles' 'Doe&Lee Ltd.');

  array prices{13} p1-p13 (27,30,32,34,36,40,44,45,50,54,56,60,86);
  array smax{6} (850,450,555,890,470,500);

  keep section booktitle author publisher listprice saleprice cost;
  do i=1 to 6;
    section=sname{i};
    sectionmax=smax{i};
    do j=1 to sectionmax;
      booktitle=catx(' ',section,'Title',put(j,4.));

      lnptr=round(125*(uniform(54321)),1.);
      if lnptr=0 then lnptr=125;
      author=cats(ln{lnptr},',');
      fnptr=round(70*(uniform(12345)),1.);
      if fnptr=0 then fnptr=70;
      author=catx(' ',author,fn{fnptr});

      pubptr=round(12*(uniform(7890)),1.);
      if pubptr=0 then pubptr=12;
      publisher=pubname{pubptr};

      pval=round(2*normal(3),1) + 7;
      if pval > 13 then pval=13;
      else if pval < 1 then pval=1;
      listprice=prices{pval} + .95;
      saleprice=listprice;
      if mod(j,8)=0 then saleprice=listprice*.9;
      if mod(j,17)=0 and mod(j,8) ne 0 then saleprice=listprice*.8;
      cost=.5*listprice;
      if mod(j,12)=0 then cost=.6*listprice;

      ncopies=round(rangam(33,.5),1);
      do n=1 to ncopies;
        output;
      end;

      output;
    end;
  end;
run;


data books.ytdsales(label='Sales for 2007');

  keep section--saleprice;
  attrib section  length=$30 label='Section'
         saleid   length=8 label='Sale ID'
                  format=8.
         saleinit length=$3 label='Sales Person Initials'
         datesold length=4 label='Date Book Sold'
                  format=mmddyy10. informat=mmddyy10.
         booktitle length=$50 label='Title of Book'
         author   length=$50 label='First Author'
         publisher length=$50 label='Publisher'
         cost     length=8 label='Wholesale Cost'
                  format=dollar10.2
         listprice length=8 label='List Price'
                  format=dollar10.2
         saleprice length=8 label='Sale Price'
                  format=dollar10.2;

   array mos{12} _temporary_ 
(555,809,678,477,300,198,200,500,655,719,649,356);

   array momax{12} momax1-momax12
                   (30,27,30,29,30,29,30,30,29,30,29,30);

   array inits{7} $ 3 _temporary_ ('MJM' 'BLT' 'JMB' 'JAJ' 'LPL' 'SMA' 
'CAD');
   retain saleid 10000000;

   do m=1 to 12;
     do j=1 to mos{m};
       day=round(momax{m}*uniform(3),1)+1;
       datesold=mdy(m,day,2007);
       obsno=int(uniform(3929)*5366)+1;
       set bookdb point=obsno;

       person=mod(day,7)+1;
       saleinit=inits{person};

       saleid+1;
       output;
    end;
    if m=12 then stop;
  end;
run;

/*********************************** End of the Data set creation **********************************************/

/*********How to create & use macro variables*************/

%let month_sold=4;
proc print data=books.ytdsales(where=(month(datesold)=&month_sold));
  title "Books Sold for Month &month_sold";
  var booktitle saleprice;
  sum saleprice;
run;

quit;

/******More examples of macro variables creation for better understanding**************************/

%let nocalc=53*21 + 100.1;

%let value1=982;
%let value2=813;
%let result=&value1 + &value2;

%let reptext=This report is for *** Department XYZ ***;

%let region=Region 3;
%let text=Sales Report;
%let moretext="Sales Report";
%let reptitle=&text &region;
%let reptitl2=&moretext &region;

%let sentence= This one started with leading blanks.;

%let chars=Symbols: !@#$%^&*;

%let novalue=;

%let holdvars=varnames;
%let &holdvars=title author datesold;

/**How to look at existed macro variables in the system?*****************/

%put _automatic_;
%put _all_;
%put _user_;

%let reptitle=Book Section;
%let reptvar=section;
%put _global_;
%put _LOCAL_;

/*******Use SAS SYSTEM MACRO VARIABLES*********************/

title "Sales Report";
title2 "As of &systime &sysday &sysdate";
title3 "Using SAS Version: &sysver";
proc means data=books.ytdsales n sum;
  var saleprice;
run;

/** Use Macro variables and creation of report & graphs dynamically by using SAS**/

%let repmonth=4;
%let repyear=2007;
%let repmword=%sysfunc(mdy(&repmonth,1,&repyear),monname9.);

data temp;
  set books.ytdsales;
  mosale=month(datesold);
  label mosale='Month of Sale';
run;
proc tabulate data=temp;
  title "Sales During &repmword &repyear";
  where mosale=&repmonth and year(datesold)=&repyear;
  class section;
  var saleprice listprice cost;
  tables section all='**TOTAL**',(saleprice listprice cost)*(n*f=4. sum*f=dollar10.2);
run;
proc gchart data=temp (where=(mosale <= &repmonth and 
year(datesold)=&repyear));
  title "Sales Through &repmword &repyear";
  pie section / coutline=black percent=outside
  sumvar=saleprice noheading ;
run;

proc setinit; run;  /*To know the what are the modules available in the current license */

/*Split the YTD sale file into monthly files(make datasets) by using macros and Do loops in SAS */

%macro makesets;
  data
    %do i=1 %to 12;
      month&i
    %end;
    ;
    set books.ytdsales;

    mosale=month(datesold);

    if mosale=1 then output month1;
    %do i=2 %to 12;
      else if mosale=&i then output month&i;
    %end;
  run;
%mend makesets;

%makesets

/********Use system functions & create a report by using macros********/
data web;
  set books.ytdsales;
  if section='Web Design' and datesold > "&sysdate"d-6;
run;
proc print data=web;
  title "Web Design Titles Sold in the Past Week";
  title2 "Report Date: &sysday &sysdate &systime";
  footnote1 "Data Set Used: &syslast SAS Version: &sysver";
  var booktitle datesold saleprice;
run;

%macro dsreport(dsname);
  %*----Open data set dsname;
  %let dsid=%sysfunc(open(&dsname));

  %*----How many obs are in the data set?;
  %let nobs=%sysfunc(attrn(&dsid,nobs));

  %*----When was the data set created?;
  %let when = %sysfunc(putn(%sysfunc(attrn(&dsid,crdte)),datetime9.));

  %*----Close data set dsname identified by dsid;
  %let rc=%sysfunc(close(&dsid));

  title "Report on Data Set &dsname";
  title2 "Num Obs: &nobs Date Created: &when";
  proc means data=&dsname sum maxdec=2;
    class section;
    var saleprice;
  run;
%mend dsreport;

%dsreport(books.ytdsales)


/********Creation of summary statastics dyanamically by using SAS******/

%let reptitle=Book Section;
%let repvar=section;
title "Frequencies by &reptitle as of &sysday";
proc freq data=books.ytdsales;
  tables &repvar;
run;

title "Means by &reptitle as of &sysday";
proc means data=books.ytdsales;
  class &repvar;
  var saleprice;
run;


/* Create a dynaymic report  by using macro variables for the list of books sold in any month and also 
   create a report of how many books sold above 25 and below 25 in the month 4*/

%let mosold=4;
%let level=25;

data book&mosold&level;
  set books.ytdsales(where=(month(datesold)=&mosold));

  attrib over&level length=$3 label="Cost > $&level";

  if cost > &level then over&level='YES';
  else over&level='NO';
run;

proc freq data=book&mosold&level;
  title "Frequency Count of Books Sold During Month &mosold";
  title2 "Grouped by Cost Over $&level";
  tables over&level;
run;


/***************some more examples************************************/
%let section1=Certification and Training;
%let section2=Internet;
%let section3=Networking and Communication;
%let section4=Operating Systems;
%let section5=Programming and Applications;
%let section6=Web Design;

*----Look for section number defined by macro var n;
%let n=4;

proc means data=books.ytdsales;
  title "Sales for Section: &&section&n";
  where section="&&section&n";
  var saleprice;
run;


/***************Examples of options-symbolgen******************************************************/
options symbolgen; /* Symbolgen print the value of macro variable holds in the log*/

%let section4=Operating Systems;
%let n=4;

%put &section&n;


/*********************************************************************/
options symbolgen;

%let section4=Operating Systems;
%let n=4;

%put &&section&n;


/*********************More Examples for macro variables************************************************/
options symbolgen;

%let section1=Certification and Training;
%let section2=Internet;
%let section3=Networking and Communication;
%let section4=Operating Systems;
%let section5=Programming and Applications;
%let section6=Web Design;

%let dept1=Computer;
%let dept2=Reference;
%let dept3=Science;

%let n=4;
%let wherevar=section;

proc means data=books.ytdsales;
  title "Sales for &wherevar: &&&wherevar&n";
  where &wherevar="&&&wherevar&n";
  var saleprice;
run;

/*********************************************************************/
proc catalog c=work.sasmacr;
  contents;
run;
quit;


/*********************************************************************/
data temp;
  set books.ytdsales;

  attrib profit label='Sale Price-Cost' format=dollar8.2;

  profit=saleprice-cost;
run;

/**************Examples for Positional parameters(List parameters)*******************************************************/
options mprint mlogic;
%macro listparm(opts,start,stop);
  title "Books Sold by Section Between &start and &stop";
  proc means data=books.ytdsales &opts;
    where "&start"d le datesold le "&stop"d;
    class section;
    var saleprice;
  run;
%mend listparm;

*----First call to LISTPARM, all 3 parameters specified;
%listparm(n sum,01JUN2007,15JUN2007)

*----Second call to LISTPARM, first parameter is null,;
*----second and third parameters specified;
%listparm(,01SEP2007,15SEP2007)


/****************Examples for key word parameters*****************************************************/
options mprint mlogic;
%macro keyparm(opts=N SUM MIN MAX,start=01JAN2007,stop=31DEC2007);
  title "Books Sold by Section Between &start and &stop";
  proc means data=books.ytdsales &opts;
    where "&start"d le datesold le "&stop"d;
    class section;
    var saleprice;
  run;
%mend keyparm;

*----First call to KEYPARM: specify all keyword parameters;
%keyparm(opts=n sum,start=01JUN2007,stop=15JUN2007)

*----Second call to KEYPARM: specify start and stop,;
*----opts is null: should see default stats for PROC MEANS;
%keyparm(opts=,start=01SEP2007,stop=15SEP2007)

*----Third call to KEYPARM: use defaults for start and stop,;
*----specify opts;
%keyparm(opts=n sum)

/****************Examples for Mixed parameters*****************************************************/
options mprint mlogic;
%macro mixdparm(stats,othropts,start=01JAN2007,stop=31DEC2007);
  title "Books Sold by Section Between &start and &stop";
  proc means data=books.ytdsales &stats &othropts;
    where "&start"d le datesold le "&stop"d;
    class section;
    var saleprice;
  run;
%mend mixdparm;

%*----Compute default stats for December 2007 and allow
      missing values to be valid in creating combinations of the CLASS 
variables;
%mixdparm(,missing,start=01DEC2007)

%*----Compute default stats for all of 2007;
%mixdparm()


/*********************************************************************/

%macro pbuffparms / parmbuff;
  goptions reset=all;

  pattern1 c=graybb;
  pattern2 c=graydd;
  pattern3 c=white;
  pattern4 c=grayaa;

  goptions ftext=swiss rotate=landscape;

  %*----Process this section when parameter values specified;
  %if &syspbuff ne %then %do;
    %let i=1;
    %let month=%scan(&syspbuff,&i);
    %do %while(&month ne);
      proc gchart data=books.ytdsales(where=(month(datesold)=&month));
        title "Sales Report for Month &month";
        hbar section / sumvar=saleprice type=sum;
      run;
      quit;
      %let i=%eval(&i+1);
      %let month=%scan(&syspbuff,&i);
    %end;
  %end;

  %*----Process this section when no parameter values specified;
  %else %do;
    proc gchart data=books.ytdsales;
      title "Annual Sales by Quarter";
      hbar section / sumvar=saleprice type=sum subgroup=datesold 
coutline=black;
      format datesold qtr.;
    run;
    quit;
  %end;
%mend pbuffparms;

*----Analyze sales for August and November;
%pbuffparms(8,11)

*----Analyze sales for entire year;
%pbuffparms()

/*********************************************************************/

options symbolgen mprint;

%let subset=Internet;

%macro makeds(subset);
  data temp;
    set books.ytdsales(where=(section="&subset"));

    attrib qtrsold label='Quarter of Sale';

    qtrsold=qtr(datesold);
  run;
%mend makeds;

%makeds(Internet)

proc tabulate data=temp;
  title "Book Sales Report Produced &sysdate9";
  class qtrsold;
  var saleprice listprice;
  tables qtrsold all,
        (saleprice listprice)*(n*f=6. sum*f=dollar12.2) / box="Section: 
&subset";
  keylabel all='** Total **';
run;


/*********************************************************************/
options symbolgen mprint;
%macro makeds(subset);
  data temp;
    set books.ytdsales(where=(section="&subset"));
    attrib qtrsold label='Quarter of Sale';
    qtrsold=qtr(datesold);
  run;
  proc tabulate data=temp;
    title "Book Sales Report Produced &sysdate9";
    class qtrsold;
    var saleprice listprice;
    tables qtrsold all,
           (saleprice listprice)*(n*f=6. sum*f=dollar12.2) / 
box="Section: &subset";
    keylabel all='** Total **';
  run;
%mend makeds;

%makeds(Internet)

/*********************************************************************/

options symbolgen mprint;

%let subset=Internet;

%macro loclmvar;
  %local subset;
  %let subset=Web Design;

  proc means data=books.ytdsales n sum maxdec=2;
    title "Book Sales Report Produced &sysdate9";
    title2 "Uses LOCAL SUBSET macro variable: &subset";
    where section="&subset";
    var saleprice;
  run;
%mend loclmvar;

%loclmvar

proc means data=books.ytdsales n sum maxdec=2;
  title "Book Sales Report Produced &sysdate9";
  title2 "Uses GLOBAL SUBSET macro variable: &subset";
  where section="&subset";
  var saleprice;
run;

/*********************************************************************/

proc means data=books.ytdsales;
  title "Sales for 01%substr(&sysdate,3,3) through &sysdate9";
  where "01%substr(&sysdate,3)"d le datesold le "&sysdate"d;
  class section;
  var saleprice;
run;


/*********************************************************************/

%let months=January February March April May June;
%let repmonth=3;

proc print data=books.ytdsales;
  title "Sales Report for %scan(&months,&repmonth)";
  where month(datesold)=&repmonth;
  var booktitle author saleprice;
run;


/*********************************************************************/
%macro listtext(keytext);
  %let keytext=%upcase(&keytext);
  proc print data=books.ytdsales;
    title "Book Titles Sold Containing Text String &keytext";
    where upcase(booktitle) contains "&keytext";
    var booktitle author saleprice;
  run;
%mend listtext;

%listtext(web)

/*********************************************************************/

%* For example purposes only, ensure these two macro variables do not 
exist in the global symbol table;
%symdel glbsubset subset;

%macro makeds(subset);
  %global glbsubset;
  %let glbsubset=&subset;

  %* What is domain of SUBSET and GLBSUBSET inside MAKEDS?;
  %put ******** Inside macro program;
  %put Is SUBSET a local macro variable(0=No/1=Yes): %symlocal(subset);
  %put Is SUBSET a global macro variable(0=No/1=Yes): %symglobl(subset);
  %put Is GLBSUBSET a local macro variable(0=No/1=Yes): 
%symlocal(glbsubset);
  %put Is GLBSUBSET a global macro variable(0=No/1=Yes): 
%symglobl(glbsubset);
  %put ********;

  data temp;
    set books.ytdsales(where=(section="&subset"));

    attrib qtrsold label='Quarter of Sale';

    qtrsold=qtr(datesold);
  run;
%mend makeds;

%makeds(Internet)

%* Are SUBSET and GLBSUBSET in global symbol table?;

%put Does SUBSET exist (0=No/1=Yes): %symexist(subset);
%put Is SUBSET a global macro variable(0=No/1=Yes): %symglobl(subset);
%put Is GLBSUBSET a global macro variable(0=No/1=Yes): 
%symglobl(glbsubset);

proc tabulate data=temp;
  title "Book Sales Report Produced &sysdate9";
  class qtrsold;
  var saleprice listprice;
  tables qtrsold all,
         (saleprice listprice)*(n*f=6. sum*f=dollar12.2) / box="Section: 
&glbsubset";
  keylabel all='** Total **';
run;


/*********************************************************************/
title "Sales for %sysfunc(date(),monname.) %sysfunc(date(),year.)";


/*********************************************************************/
%macro getopt(whatopt);
  %let optvalue=%sysfunc(getoption(&whatopt));
  %put Option &whatopt = &optvalue;
%mend getopt;

%getopt(ps)
%getopt(ls)
%getopt(date)
%getopt(symbolgen)
%getopt(compress)


/*********************************************************************/
%macro checkvarname(value);
  %let position=%sysfunc(notname(&value));
  %put **** Invalid character in position: &position (0 means &value is 
okay);
  %let valid=%sysfunc(nvalid(&value,v7));
  %put **** Can &value be a variable name(0=No, 1=Yes)? &valid;
  %put;
  %put;
%mend checkvarname;

%checkvarname(valid_name)
%checkvarname( valid_name)
%checkvarname(invalid name)
%checkvarname(book_sales_results_for_past_five_years!)


/************************Evalution Functions*********************************************/
%let a=1.5;
%let b=-2.0;
%let c=1.978;
%let d=-3.5;
%let meanstat=%sysfunc(mean(&a,&b,&c,&d));
%put ****** The mean of &a, &b, &c, and &d is &meanstat..;


/*********************************************************************/

%let a=1.5;
%let b=-2.0;
%let c=1.978;
%let d=-3.5;
%let meanstat=%sysevalf( (&a+&b+&c+&d)/4);
%put ****** The mean of &a, &b, &c, and &d is &meanstat..;


/*********************************************************************/
%let dsname=books.ytdsales;
%let dsid=%sysfunc(open(&dsname));
%let lastupdate=%sysfunc(attrn(&dsid,modte));
%let rc=%sysfunc(close(&dsid));

proc report data=books.ytdsales nowd headline;
  title "Publisher List Report &sysdate9";
  title2 "Last Update of &dsname: 
%sysfunc(putn(&lastupdate,datetime.))";
  column publisher saleprice;
  define publisher / group width=30;
  define saleprice / format=dollar11.2;
  rbreak after / dol dul summarize;
run;


/*********************************************************************/

%macro checksurvey(response);
  %let validresponses=123459ABCDEZ;
  %let result=%verify(%upcase(&response),&validresponses);
  %put ******* Response &response is valid/invalid (0=valid 1=invalid): 
&result;
%mend checksurvey;

%checksurvey(f)
%checksurvey(a)
%checksurvey(6)


/*********************************************************************/

%macro checksurvey(response);
  %let validresponses=123459ABCDEZ;
  %let 
result=%sysfunc(verify(%sysfunc(upcase(&response)),&validresponses));
  %put ******* Response &response is valid/invalid (0=valid 1=invalid): 
&result;
%mend checksurvey;

%checksurvey(f)
%checksurvey(a)
%checksurvey(6)

/*********************************************************************/
%macro comp2vars(value1,value2);
  %put COMPARISON 1:;
  %if &value1 ne &value2 %then %put &value1 is not equal to &value2..;
  %else %put &value1 equals &value2..;

  %put COMPARISON 2:;
  %if &value1 > &value2 %then %put &value1 is greater than &value2..;
  %else %if &value1 < &value2 %then %put &value1 is less than &value2..;
  %else %put &value1 equals &value2..;

  %put COMPARISON 3:;
  %let result=%eval(&value1 > &value2);
  %if &result=1 %then %put EVAL result of &value1 > &value2 is TRUE.;
  %else %put EVAL result of &value1 > &value2 is FALSE.;

  %put COMPARISON 4:;
  %let result=%sysevalf(&value1 > &value2);
  %if &result=1 %then %put SYSEVALF result of &value1 > &value2 is 
TRUE.;
  %else %put SYSEVALF result of &value1 > &value2 is FALSE.;
%mend comp2vars;

*----First call to COMP2VARS;
%comp2vars(3,4)

*----Second call to COMP2VARS;
%comp2vars(3.0,3)

*----Third call to COMP2VARS;
%comp2vars(X,x)


/*********************************************************************/
%macro reports(reptype,repmonth);
  %let 
lblmonth=%sysfunc(mdy(&repmonth,1,%substr(&sysdate,6,2)),monname.);

  %*----Begin summary report section;
  %if %upcase(&reptype)=SUMMARY %then %do;
    %*----Do summary report for report month;
    proc tabulate data=books.ytdsales;
      title "Sales for &lblmonth";
      where month(datesold)=&repmonth;
      class section;
      var listprice saleprice;
      tables section,(listprice saleprice)*(n*f=6. sum*f=dollar12.2);
    run;

    %*----If end of quarter, also do summary report for qtr;
    %if &repmonth=3 or &repmonth=6 or &repmonth=9 or &repmonth=12 %then 
%do;
      %let qtrstart=%eval(&repmonth-2);
      %let 
strtmo=%sysfunc(mdy(&qtrstart,1,%substr(&sysdate,6,2)),monname.);
      proc tabulate data=books.ytdsales;
        title "Sales for Quarter from &strtmo to &lblmonth";
        where &qtrstart le month(datesold) le &repmonth;
        class section;
        var listprice saleprice;
        tables section,(listprice saleprice)*(n*f=6. sum*f=dollar12.2);
      run;
    %end;
  %end;
  %*----End summary report section;
  %*----Begin detail report section;
  %else %if %upcase(&reptype)=DETAIL %then %do;
    %*----Do detail report for month;
    proc print data=books.ytdsales;
      where month(datesold)=&repmonth;
      var booktitle cost listprice saleprice;
      sum cost listprice saleprice;
    run;
  %end;
  %*----End detail report section;
%mend reports;

*----First call to REPORTS does a Summary report for September;
%reports(Summary,9)

*----Second call to REPORTS does a Detail report for October;
%reports(Detail,10)


/*********************************************************************/
%macro publisherreport(reptype);
  %let reptype=%upcase(&reptype);

  title "Publisher Report";
  footnote "Macro Program: &sysmacroname Report Type: &reptype";

  proc report data=books.ytdsales nowd headline;
    column publisher saleprice cost profit
      %if &reptype=DETAIL %then %do;
        n
      %end;
      %else %if &reptype=QUARTER %then %do;
        datesold,(saleprice=saleprice2)
      %end;
      ;
    define publisher / group width=25;
    define saleprice / analysis sum format=dollar11.2;
    define cost / analysis sum format=dollar11.2
                  %if &reptype=BASIC %then %do;
                    noprint
                  %end;
                  ;
    define profit / computed format=dollar11.2 'Profit';

    %if &reptype=DETAIL %then %do;
      define n / 'Number of Titles Sold' width=6;
    %end;
    %else %if &reptype=QUARTER %then %do;
      define saleprice2 / 'Quarter Sale Price Total';
      define datesold / across ' ' format=qtr.;
    %end;

    compute profit;
      profit=saleprice.sum-cost.sum;
    endcomp;

    rbreak after / summarize dol;

    compute after;
      publisher='Total for All Publishers';
    endcomp;
  run;
%mend publisherreport;

%* First call to PUBLISHERREPORT, do BASIC report;
%publisherreport(basic)

%* Second call to PUBLISHERREPORT, do DETAIL report;
%publisherreport(detail)

%* Third call to PUBLISHERREPORT, do QUARTER report;
%publisherreport(quarter)


/*********************************************************************/
%macro vendortitles(publisher) / mindelimiter='!';
  title "Vendor-Publisher Report";
  %if &publisher in AMZ Publishers!Eversons Books!IT Training Texts 
%then %do;
    title2 "Vendor for &publisher is Baker";
  %end;
  %else %if &publisher in Northern Associates Titles!Professional House 
Titles
           %then %do;
    title2 "Vendor for &publisher is Mediasuppliers";
  %end;
  %else %do;
    title2 "Vendor for &publisher is Basic Distributor";
  %end;
%mend vendortitles;

%vendortitles(AMZ Publishers)

%vendortitles(Mainst Media)


/*********************************************************************/
%macro multrep(startyear,stopyear);
  %do yrvalue=&startyear %to &stopyear;
    title "Sales Report for &yrvalue";
    proc means data=sales.year&yrvalue;
      class section;
      var cost listprice saleprice;
    run;
    proc gchart data=sales.year&yrvalue;
      hbar section / sumvar=saleprice type=sum;
    run;
    quit;
  %end;
%mend multrep;

*----Produce 3 sets of reports: one for 2005, one for 2006,
*----and one for 2007;
%multrep(2005,2007)


/*********************************************************************/

%macro sumyears(startyear,stopyear);
  data manyyears;
    set
        %do yearvalue=&startyear %to &stopyear;
          sales.year&yearvalue
        %end;
        ;
  run;
  %let yearstring=;
  %do yearvalue=&startyear %to &stopyear;
    %let yearstring=&yearstring &yearvalue;
  %end;

  proc gchart data=manyyears;
    title "Charts Analyze Data for: &yearstring";
    hbar section / sumvar=saleprice type=sum;
  run;
  quit;
%mend sumyears;

*----Concatenate three data sets: one from 2005, one from;
*----2006, and one from 2007;
%sumyears(2005,2007)


/*********************************************************************/

%macro mosales / parmbuff;
  %let listindex=1;
  %do %until (%scan(&syspbuff,&listindex) eq );
    %let repmonth=%scan(&syspbuff,&listindex);
    proc means data=books.ytdsales n sum;
      %if &repmonth ne %then %do;
        title "Sales during month &repmonth";
        where month(datesold)=&repmonth;
      %end;
      %else %do;
        title "Overall Sales";
      %end;
      class section;
      var saleprice;
    run;
    %let listindex=%eval(&listindex+1);
  %end;
%mend mosales;

*----First call to MOSALES: produce stats for March, May, and
*----October;
%mosales(3 5 10)

*----Second call to MOSALES: produce overall stats;
%mosales()


/*********************************************************************/

%macro staffsales(salesreps,repmonth);
  %let personnumber=1;
  %do %while (%scan(&salesreps,&personnumber) ne );
    %let salesinits=%scan(&salesreps,&personnumber);
    proc means data=books.ytdsales n sum;
      title "Sales for &salesinits during month &repmonth";
      where saleinit="&salesinits" and month(datesold)=&repmonth;
      class section;
      var saleprice;
    run;
    %let personnumber=%eval(&personnumber+1);
  %end;
%mend staffsales;

%staffsales(MJM BLT JMB,5)

/*********************************************************************/
%macro detail(dsname,varlist);
  %* Does DSNAME exist?;
  %let foundit=%sysfunc(exist(&dsname));
  %if &foundit le 0 %then %goto nodataset;

  title "PROC PRINT of &dsname";
  proc print data=&dsname;
    var &varlist;
  run;
  %goto finished;

  %nodataset:
    %put ERROR: **** Data set &dsname not found. ****;
    %put;

    %* Find the data set libref. If it is not;
    %* specified, assume a temporary data set;
    %* and assign WORK to DSLIBREF;
    %let period=%index(&dsname,.);
    %if &period gt 0 %then %let dslibref=%scan(&dsname,1,.);
    %else %let dslibref=work;

    proc datasets library=&dslibref details;
    run;
    quit;

  %finished:
%mend detail;

*----First call to DETAIL, data set exists;
%detail(books.ytdsales,datesold booktitle saleprice)

*----Second call to DETAIL, data set does not exist;
%detail(books.ytdsaless,datesold booktitle saleprice)

%*----Third call to DETAIL, look for data set in WORK library;
%detail(ytdsales,datesold booktitle saleprice)



/*********************************************************************/

proc means data=books.ytdsales(where=(publisher='Doe&Lee Ltd.')) 
noprint;
  var saleprice;
  output out=salesdl sum=;
run;
data _null_;
  set salesdl;
  call symputx('totsales_dl',
         cat('The total sales for Doe&Lee Ltd is ', 
put(saleprice,dollar10.2),'.'));
run;
footnote "%superq(totsales_dl)";


/*********************************************************************/
%macro mosectdetail(monthlist,section);
  proc print data=books.ytdsales;
    title "List of titles sold for months &monthlist";
    where month(datesold) in (&monthlist) and section="&section";
    var booktitle saleprice;
  run;
%mend mosectdetail;

%mosectdetail(3,6,Internet)

%mosectdetail(%str(3,6),Internet)


/*********************************************************************/


%macro publishersales(destination,styleheader,stylereport);
  ods listing close;
  ods &destination;

  title "Sales by Publisher";
  proc report data=books.ytdsales style(header)={&styleheader}
                                  style(report)={&stylereport} nowd;
    column publisher saleprice n;
    define publisher / group;
    define saleprice / format=dollar10.2;
  run;

  ods &destination close;
  ods listing;
%mend publishersales;

%publishersales(html,%str(font_style=italic),%str(rules=rows 
cellspacing=0))


/*********************************************************************/

%macro mypages(titletext=,jtitle=center,ctitle=black,
               footnotetext=,jfootnote=right,cfootnote=black);
  %if %superq(titletext)= %then %do;
    title1;
  %end;
  %else %do;
    title justify=&jtitle color=&ctitle "&titletext";
  %end;
  %if %superq(footnotetext)= %then %do;
    footnote1;
  %end;
  %else %do;
    footnote justify=&jfootnote color=&cfootnote "&footnotetext";
  %end;
%mend mypages;

options mprint;
*----First call of MYPAGES;
%mypages(titletext=Sales Report,ctitle=blue,footnotetext=Last Review 
Date: Feb 1%str(,) 2008)

*----Second call of MYPAGES;
%mypages(titletext=2007+ Sales,footnotetext=Prepared with SAS &sysver)

*----Third call of MYPAGES;
%mypages(titletext=Sales Report,footnotetext=Last Reviewed by 
%str(O%'Malley))

*----Fourth call of MYPAGES;
%mypages(titletext=%nrstr(Audited&Approved),
         footnotetext=%nrstr(%Increase in Sales for Year was 8%%),
         jfootnote=center)


/*********************************************************************/

%macro mar;
  This is March
%mend;

%let m=%nrstr(%mar);

title "Macro call &m generates the following text";
title2 "%unquote(&m)";


/*********************************************************************/
%let publisher=Doe and Lee;
%let publisher2=%sysfunc(tranwrd(&publisher,and,&));
%let publisher3=%sysfunc(compress(&publisher2)) Ltd.;
%put PUBLISHER3 defined with %nrstr(%SYSFUNC): &publisher3;

%let publisher3=%qsysfunc(compress(&publisher2)) Ltd.;
%put PUBLISHER3 defined with %nrstr(%QSYSFUNC): &publisher3;


/*********************************************************************/

%let months=%nrstr(Jan&Feb&Mar);
%let month3=%substr(&months,8);
%put Unquoted: &month3;

%let qmonth3=%qsubstr(&months,8);
%put Quoted: &qmonth3;

/*********************************************************************/
%let certific=CNT283817;
%let internet=INT3521P8;
%let networks=NET3UD697;
%let operatin=OPSI18375;
%let programm=PRG8361WQ;
%let webdesig=WBD188377;

data temp;
  set books.ytdsales;

  attrib compsect length=$8 label='Section'
         sectionid length=$9 label='Section ID';

  *----Construct macro variable name by compressing section name and
       taking the first 8 characters. When section=Web Design, 
COMPSECT="WebDesig";
  compsect=substr(compress(section),1,8);
  sectionid=symget(compsect);
run;
proc print data=temp;
  title "Defining the Section Identification Code";
  var section compsect sectionid;
run;


/*********************************************************************/
%let webfctr=1.20;
%let intfctr=1.35;
data temp;
  set books.ytdsales(where=(section in ('Web Design', 'Internet')));

  if section='Web Design' then costfctr=symgetn('webfctr');
  else if section='Internet' then costfctr=symgetn('intfctr');

  newprice=costfctr*cost;
run;
proc print data=temp;
  title "Prices based on COSTFCTR";
  var section cost costfctr newprice;
  format newprice dollar8.2;
run;


/*********************************************************************/
%let managerquarter1=HCH;
%let managerquarter2=EMB;
%let managerquarter3=EMB;
%let managerquarter4=JBR;

data managers;
  set books.ytdsales;

  length managerinits $ 3;

  managerinits=symget(cats('managerquarter',put(qtr(datesold),1.)));
run;
proc print data=managers;
  title "Sale Dates and Managers";
  var datesold managerinits;
run;


/*********************************************************************/
data _null_;
  set books.ytdsales end=eof;

  if saleprice ge 45 then nhigh+1;
  if eof then call symput('n45',put(nhigh,comma5.));
run;
proc means data=temp n mean min max;
  title "All Books Sold";
  title2 "Number of Books Sold for More Than $45: &n45";
  var saleprice;
run;


/*********************************************************************/
data newbooks;
  input booktitle $ 1-40;
  call symputx('lasttitle',booktitle);
datalines;
Hello Java Programming
My Encyclopedia of Networks
Strategic Computer Programming
Everyday Email Etiquette
run;

%put The value of macro variable LASTTITLE is &lasttitle..;


/*********************************************************************/
proc freq data=books.ytdsales noprint;
  tables section / out=sectname;
run;
data _null_;
  set sectname;

  call symput('name' || put(_n_,1.),section);
  call symputx('n' || put(_n_,1.),count);
run;

%put _user_;

/*********************************************************************/
%macro statsection(section);
  proc means data=books.ytdsales noprint;
    where section="&section";
    var saleprice;
    output out=sectionresults mean=avgsaleprice min=minsaleprice 
max=maxsaleprice;
  run;
  data _null_;
    set sectionresults;

    call symputx('average',put(avgsaleprice,dollar8.2),'G');
    call symputx('min',put(minsaleprice,dollar8.2),'G');
    call symputx('max',put(maxsaleprice,dollar8.2),'G');
  run;

  %* Submit this statement to see the variables stored in the 
STATSECTION local symbol table;
  %put _local_;
%mend statsection;

%statsection(Internet)

title "Section Results for Average Sale Price: &average";
title2 "Minimum Sale Price: &min";
title3 "Maximum Sale Price: &max";


/*********************************************************************/
%macro listautomatic;
  %put **** Start list of automatic macro variables;
  %put _automatic_;
  %put **** End list of automatic macro variables;
%mend listautomatic;

data _null_;
  call execute("%listautomatic");
run;


/*********************************************************************/
%macro listlibrary;
  %put **** This statement precedes the PROC step;
  proc datasets library=books;
  run;
  quit;
  %put **** This statement follows the PROC step;
%mend listlibrary;

data _null_;
  call execute("%listlibrary");
run;


/*********************************************************************/
%macro rep60k(section);
  proc report data=books.ytdsales headline center nowd;
    where section="&section";
    title "Sales > $60,000 Summary for &section";

    column publisher n saleprice;
    define publisher / group;
    define n / "Number of Books Sold" ;
    define saleprice / sum format=dollar10.2 "Sale Price" ;
    rbreak after / summarize dol;
  run;
%mend rep60k;

options mprint;

proc means data=books.ytdsales nway noprint;
  class section;
  var saleprice;
  output out=sectsale sum=totlsale;
run;
data _null_;
  set sectsale;
  if totlsale > 60000 then call execute(cats('%rep60k(',section,')'));
run;


/*********************************************************************/
%macro highreport(section);
  proc report data=books.ytdsales headline center nowd;
    where section="&section";
    title "Sales > $60,000 Report for Section &section";

    column publisher n saleprice;

    define publisher / group;
    define n / "Number of Books Sold" ;
    define saleprice / sum format=dollar10.2 "Sale Price" ;

    rbreak after / summarize dol;
  run;
%mend highreport;

%macro lowreport(section);
  proc report data=books.ytdsales nowd;
    where section="&section";
    title "Sales < $35,000 Report for Section &section";

    column datesold n saleprice;

    define datesold / group format=month. "Month Sold" width=6;
    define n / "Number of Books Sold";
    define saleprice / sum format=dollar10.2 "Sales Total";

    rbreak after / summarize dol;
  run;
%mend lowreport;

proc means data=books.ytdsales nway noprint;
  class section;
  var saleprice;
  output out=sectsale sum=totlsect;
run;
data _null_;
  set sectsale;

  if totlsect < 35000 then call 
execute(cats('%lowreport(',section,')'));
  else if totlsect > 60000 then call 
execute(cats('%highreport(',section,')'));
run;


/*********************************************************************/
%let quartersale1=Holiday Clearance;
%let quartersale2=2 for the Price of 1;
%let quartersale3=Back to School;
%let quartersale4=New Releases;

data temp;
  set books.ytdsales;

  length quartersalename $ 30;

  quarter=qtr(datesold);
  quartersalename=resolve(cats('&quartersale',put(quarter,1.)) );
run;
proc freq data=temp;
  title 'Quarter by Quarter Sale Name';
  tables quarter*quartersalename / list nocum nopct;
run;

/*********************************************************************/

%macro getsalename(quarter);
  %if &quarter=1 %then %do;
    Holiday Clearance
  %end;
  %else %if &quarter=2 %then %do;
    2 for the Price of 1
  %end;
  %else %if &quarter=3 %then %do;
    Back to School
  %end;
  %else %if &quarter=4 %then %do;
    New Releases
  %end;
%mend getsalename;

proc means data=books.ytdsales noprint nway;
  class datesold;
  var saleprice;
  output out=quarterly sum=;
  format datesold qtr.;
run;
data quarterly;
  set quarterly(keep=datesold saleprice);

  length quartersalename $ 30;

  quartersalename=resolve(cats('%getsalename(',put(datesold,qtr.),')') 
);
run;
proc print data=quarterly label;
  title 'Quarter Sales with Quarter Sale Name';
  label datesold='Quarter'
        saleprice='Total Sales'
        quartersalename='Sale Name';
run;


/*********************************************************************/
%let findpublisher=Technology Smith;
proc sql noprint;
  select sum(saleprice) format=dollar10.2, count(saleprice)
         into :totsales, :nsold
  from books.ytdsales
  where publisher="&findpublisher";
quit;

%put &findpublisher Total Sales=&totsales, Total Number Sold=&nsold;


/*********************************************************************/
proc sort data=books.ytdsales out=datesorted;
  by datesold;
run;
proc sql noprint;
  select datesold,booktitle,saleprice
         into :date1,:title1,:price1
         from datesorted;
quit;

%put One of the first books sold was on &date1;
%put The title of this book is &title1;
%put The sale price was &price1;

proc print data=datesorted(obs=5);
title 'First Five Observations of Sorted by Date BOOKS.YTDSALES';
run;


/*********************************************************************/
proc sql noprint;
  select section, sum(saleprice) format=dollar10.2
         into :section1 - :section6,
              :sale1 - :sale6
         from books.ytdsales
         group by section;
quit;

%put *** 1: &section1 &sale1;
%put *** 2: &section2 &sale2;
%put *** 3: &section3 &sale3;
%put *** 4: &section4 &sale4;
%put *** 5: &section5 &sale5;
%put *** 6: &section6 &sale6;


/*********************************************************************/
proc sql noprint;
  select unique(section)
         into :allsect separated by '/'
         from books.ytdsales
         order by section;
quit;

%put The value of macro variable ALLSECT is &allsect;


/*********************************************************************/
%let listlib=BOOKS;
proc sql noprint;
  select memname
         into :datasetnames separated by ' '
         from dictionary.tables
         where libname="&listlib";
quit;

%put The datasets in library &listlib is(are) &datasetnames;


/*********************************************************************/
options mprint;

%macro listsqlpub;
  options symbolgen;
  proc sql;
    select unique(publisher)
           from books.ytdsales
           order by publisher;
    select unique(publisher)
           into :pub1 - :pub&sqlobs
           from books.ytdsales
           order by publisher;
  quit;

  options nosymbolgen;

  %put Total number of publishers: &sqlobs..;

  %do i=1 %to &sqlobs;
    %put Publisher &i: &&pub&i;
  %end;
%mend listsqlpub;

%listsqlpub


/*********************************************************************/

proc sql;
  select * from dictionary.options
         where group='MACRO';
quit;


/*********************************************************************/
options mindelimiter='#';
proc sql noprint;
  select setting
         into :mysetting
         from dictionary.options
         where optname='MINDELIMITER';
quit;

%put My current MINDELIMITER setting is &mysetting;

/*********************************************************************/
options symbolgen;

%macro print10(dsname);
  proc print data=&dsname(obs=10);
    title "Listing First 10 Observations from &dsnamee";
  run;
%mend print10;

%print10(books.ytdsales)

%print100(books.ytdsales)


/*********************************************************************/

%macro whstmt(getsection,getpub);
  %if &getsection ne or &getpub ne %then %do;
    (where=((
  %end;
  %if &getsection ne %then %do;
    section="&getsection"
    %if &getpub ne %then %do;
      and
    %end;
    %else %do;
      )))
    %end;
  %end;

  %if &getpub ne %then %do;
    publisher="&getpub")))
  %end
%mend whstmt;
data temp;
  set books.ytdsales
        %whstmt(Internet,Technology Smith)
      ;
run;



/*********************************************************************/

%macro markup(publisher,rate1,rate2,rate3);
  %let diffrate=&rate3-&rate1;
  data pubmarkup;
    set books.ytdsales(where=(publisher="&publisher"));
    %if &diffrate ge 5.00 %then %do;
      retain rateplus '+++';
    %end;
    %else %if &diffrate lt 5.00 and &diffrate ge 0.00 %then %do;
      retain rateplus '+';
    %end;
    %else %do;
      retain rateplus '-';
    %end;

    %do i=1 %to 3;
      cost&i=cost* (1+(&&rate&i/100));
    %end;
  run;
%mend markup;

%markup(Technology Smith,2.25,4,7.25)


/*********************************************************************/

%macro markup(publisher,rate1,rate2,rate3);
  %let diffrate=%sysevalf(&rate3-&rate1);
  data pubmarkup;
    set books.ytdsales(where=(publisher="&publisher"));
    %if %sysevalf(&diffrate ge 5.00) %then %do;
      retain rateplus '+++';
    %end;
    %else %if %sysevalf(&diffrate lt 5.00) and %sysevalf(&diffrate ge 
0.00) %then %do;
      retain rateplus '+';
    %end;
    %else %do;
      retain rateplus '-';
    %end;

    %do i=1 %to 3;
      cost&i=cost* (1+(&&rate&i/100));
    %end;
  run;
%mend markup;

%markup(Technology Smith,2.25,4,7.25)


/*********************************************************************/

%macro tables(class_string);
  class datesold &class_string;
  %let varnum=1;
  %let classvar=%scan(&class_string,&varnum);
  %do %until (&classvar=' ');
    tables datesold='Books Sold Quarter' all='Books Sold All Four 
Quarters',
           (&classvar all),
           (cost listprice saleprice)*sum=' '*f=dollar12.2 ;
    %let varnum=%eval(&varnum+1);
    %let classvar=%scan(&class_string,&varnum);
  %end;
%mend tables;

proc tabulate data=books.ytdsales;
  title "Quarterly Book Sales Summaries";
  var cost listprice saleprice;

  format datesold qtr.;
  keylabel all='Total';

  %tables(section publisher)
run;


/*********************************************************************/
%macro tables(class_string);
  class datesold &class_string;
  %let varnum=1;
  %do %until (&classvar=);
    %let classvar=%scan(&class_string,&varnum);
     tables datesold='Books Sold Quarter' all='Books Sold All Four 
Quarters',
            (&classvar all),
            (cost listprice saleprice)*sum=' '*f=dollar12.2 ;
    %let varnum=%eval(&varnum+1);
    %let classvar=%scan(&class_string,&varnum);
  %end;
%mend tables;

proc tabulate data=books.ytdsales;
  title "Quarterly Book Sales Summaries";
  var cost listprice saleprice;

  format datesold qtr.;
  keylabel all='Total';

  %tables(section publisher)
run;


/*********************************************************************/
%macro extfiles(publisher,html=,spreadsheet=);
  data temp;
    set books.ytdsales(where=(publisher="&publisher")
    drop=section saleid saleinit listprice);
  run;
  %if &html=Y %then %do;
    %makehtml
  %end;
  %else %if &spreadsheet=Y %then %do;
    %makexls
  %end;
%mend extfiles;

%macro makehtml;
  ods listing close;
  ods html;

  proc print data=temp;
    title "Publisher: &publisher";
  run;

  ods html close;
  ods listing;
%mend makehtml;

%macro makexls;
  proc export data=temp file="pubreports.xls"
              replace;
              sheet="&publisher";
  run;
%mend makexls;

%extfiles(Eversons Books,html=Y,spreadsheet=Y)


/*********************************************************************/

%macro makehtml;
  ods listing close;
  ods html;

  proc print data=temp;
    title "Publisher: &publisher";
  run;

  ods html close;
  ods listing;
%mend makehtml;

%macro makexls;
  proc export data=temp file="pubreports.xls"
              replace;
              sheet="&publisher";
  run;
%mend makexls;

%macro extfiles(publisher,html=,spreadsheet=);
  data temp;
    set books.ytdsales(where=(publisher="&publisher")
    drop=section saleid saleinit listprice);
  run;

  %if &html=Y %then %do;
    %makehtml
  %end;

  %if &spreadsheet=Y %then %do;
    %makexls
  %end;
%mend extfiles;

%extfiles(Eversons Books,html=Y,spreadsheet=Y)


/*********************************************************************/

%macro projcost(analysisvars);
  proc tabulate data=projcost;
    title "Projected Costs Report";
    class section;
    var &analysisvars;

    tables section all='All Sections',
           &analysisvars*(mean*f=dollar7.2 sum*f=dollar12.2);
  run;
%mend projcost;

data projcost;
  set books.ytdsales;

  array increase{5} increase2008-increase2012 
(1.12,1.08,1.10,1.15,1.18);
  array pcost{5} pcost2008-pcost2012;

  drop i;

  attrib pcost2008 label="Projected Cost 2008" format=dollar10.2
         pcost2009 label="Projected Cost 2009" format=dollar10.2
         pcost2010 label="Projected Cost 2010" format=dollar10.2
         pcost2011 label="Projected Cost 2011" format=dollar10.2
         pcost2012 label="Projected Cost 2012" format=dollar10.2;

  do i=1 to 5;
    pcost{i}=round(cost*increase{i},.01);
  end;
run;

%projcost(cost pcost2008 pcost2010)

/*********************************************************************/
%macro projcost(analysisvars);
  proc tabulate data=projcost;
    title "Projected Costs Report";
    class section;
    var &analysisvars;

    tables section all='All Sections',
           (&analysisvars)*(mean*f=dollar7.2 sum*f=dollar12.2);
  run;
%mend projcost;

data projcost;
  set books.ytdsales;

  array increase{5} increase2008-increase2012 
(1.12,1.08,1.10,1.15,1.18);
  array pcost{5} pcost2008-pcost2012;

  drop i;

  attrib pcost2008 label="Projected Cost 2008" format=dollar10.2
         pcost2009 label="Projected Cost 2009" format=dollar10.2
         pcost2010 label="Projected Cost 2010" format=dollar10.2
         pcost2011 label="Projected Cost 2011" format=dollar10.2
         pcost2012 label="Projected Cost 2012" format=dollar10.2;

  do i=1 to 5;
    pcost{i}=round(cost*increase{i},.01);
  end;
run;

%projcost(cost pcost2008 pcost2010)


/*********************************************************************/

%macro selecttitles(monthsold=,minsaleprice=,publisher=);
  %* All three parameters must be specified.;
  %* Quote the value of PUBLISHER in case it contains special characters 
or mnemonic operators;
  %if &monthsold= or &minsaleprice= or %superq(publisher)= %then %do;
    %put ******************************************************;
    %put * Macro program SELECTTITLES requires you to specify all;
    %put * three parameters. At least one was not specified:;
    %put * MONTHSOLD=&monthsold;
    %put * MINSALEPRICE=&minsaleprice;
    %put * PUBLISHER=&publisher;
    %put * Please correct and resubmit.;
    %put *****************************************************;
    %goto exit;
  %end;

  %* Check if parameters are valid;
  %* MONTHSOLD must be numeric and 1 to 12;
  %if %sysfunc(notdigit(&monthsold)) gt 0 or
          &monthsold lt 1 or &monthsold gt 12 %then %do;
    %put *****************************************************;
    %put ERROR: MONTHSOLD was not specified correctly:
    &monthsold;
    %put Specify MONTHSOLD as an integer from 1 to 12;
    %put *****************************************************;
    %goto exit;
  %end;

  %* MINSALEPRICE must be numeric greater than 0 and if dollar
    signs and commas included, remove them;
  %let minsaleprice=%sysfunc(compress(&minsaleprice,%str(,)$));
  %if %sysfunc(notdigit(%sysfunc(compress(&minsaleprice,.)))) gt 0 %then 
%do;
    %put *****************************************************;
    %put ERROR: MINSALEPRICE was not specified correctly:
    &minsaleprice;
    %put *****************************************************;
    %goto exit;
  %end;

  %* Uppercase value of PUBLISHER and remove multiple blanks. Use 
quoting
     functions since value might contain special characters or mnemonic 
operators;
  %let publisher=%qupcase(%superq(publisher));
  %let publisher=%qcmpres(%superq(publisher));
  proc print data=books.ytdsales(where=(month(datesold)=&monthsold and
                                        saleprice ge &minsaleprice and
                                        upcase(publisher)="&publisher"))
                                        noobs n="Number of Books Sold=";
    title "Titles Sold during Month 
%sysfunc(putn(&monthsold,monname.))";
    title2 "Minimum Sale Price of $&minsaleprice";
    title3 "Publisher &publisher";
  run;

  %exit:
%mend selecttitles;

%selecttitles(monthsold=2,minsaleprice=$50.95,publisher=%nrstr(Doe&Lee 
Ltd.))


/*********************************************************************/
%macro lastmsg;
  %* Check last warning message;
  %put;
  %if %bquote(&syswarningtext) eq %then
           %put No warnings generated so far in this SAS session;
  %else %do;
    %put Last warning message generated in this SAS session:;
    %put &syswarningtext;
  %end;
  %put;

  %* Check last error message;
  %if %bquote(&syserrortext) eq %then
           %put No error messages generated so far in this SAS session;
  %else %do;
    %put Last error message generated in this SAS session:;
    %put &syserrortext;
    %put;
  %end;

  %put;
%mend lastmsg;
ods rtf style=bookstore;


/*********************************************************************/
%macro authorreport(author);
  %* Quote the value of AUTHOR in case it contains special characters or 
mnemonic operators;
  %let author=%qupcase(&author);
  data author;
    set books.ytdsales(where=(upcase(author)="&author"));
  run;
  proc sql noprint;
    select count(booktitle)
           into :nbooks
           from author;
  quit;

  %if &nbooks=0 %then %do;
    %put *****************************************************;
    %put ERROR: Author &author not found in data set BOOKS.YTDSALES;
    %put No report produced.;
    %put *****************************************************;
  %end;
  %else %if &nbooks=1 %then %do;
    proc print data=author label noobs;
      title "Book Sold for Author &author";
      var booktitle datesold cost saleprice;
      format datesold monname.;
    run;
  %end;
  %if &nbooks gt 1 %then %do;
    proc tabulate data=author;
      title "Books Sold for Author &author";
      class section datesold booktitle;
      var cost saleprice;
      tables section*datesold*booktitle all='Total',
             n*f=4. (cost saleprice)*sum='Total'*f=dollar10.2;

      format datesold monname.;
    run;
  %end;
%mend authorreport;

/* This author is not in data set */
%authorreport(%str(Allan, Michael))

/* This author sold one book */
%authorreport(%str(Adams, Cynthia))

/* This author sold more than one book */
%authorreport(%str(Flores, Barbara))

/*********************************************************************/
*----REPORT A;
options pageno=1;

title "Sales Report";
title2 "July 1, 2007 - August 31, 2007";

data temp;
  set books.ytdsales(where=('01jul2007'd le datesold le '31aug2007'd));

  profit=saleprice-cost;
  attrib profit label='Profit' format=dollar10.2;
run;
proc tabulate data=temp;
  var cost listprice saleprice profit;
  tables n*f=6. (cost listprice saleprice 
profit)*sum='Total'*f=dollar11.2;
  keylabel n='Titles Sold';
run;


/*********************************************************************/
*----REPORT B;
options pageno=1;

title "Sales Report";
title2 "January 1, 2007 - March 31, 2007";

data temp;
  set books.ytdsales(where=('01jan2007'd le datesold le '31mar2007'd));

  profit=saleprice-cost;
  attrib profit label='Profit' format=dollar10.2;
run;
proc tabulate data=temp;
  class section;
  var saleprice profit;
  tables section all,
         n*f=6. (saleprice profit)*sum='Total'*f=dollar11.2 / rts=30;
  keylabel all='Total Sales'
           n='Titles Sold';
run;

proc gchart data=temp;
  title3 "Sales for Quarter";
  pie section / type=sum sumvar=saleprice
  coutline=black percent=outside;
  run;

  pie section / type=sum sumvar=profit
  coutline=black percent=outside;
  run;
quit;


/*********************************************************************/
*----REPORT C;
ods listing close;
ods rtf style=gears;

title "Sales Report";
title2 "January 1, 2007 ? November 24, 2007";
data temp;
  set books.ytdsales(where=('01jan2007'd le datesold le '24nov2007'd));

  profit=saleprice-cost;

  attrib profit label='Profit' format=dollar10.2;
run;

proc tabulate data=temp;
  class section publisher;
  var cost profit;
  tables section*(publisher all) all,
         n*f=6. (cost profit)*sum*f=dollar11.2 / rts=30;

  keylabel all='Total Sales'
           n='Titles Sold';
run;

ods rtf close;
ods listing;


/*********************************************************************/
*----REPORT A;
%let repyear=2007;
%let start=01jul&repyear;
%let stop=31aug&repyear;
%let vars=cost listprice saleprice profit;
%let titlestart=%sysfunc(putn("&start"d,worddate.));
%let titlestop=%sysfunc(putn("&stop"d,worddate.));

options pageno=1 symbolgen;
title "Sales Report";
title2 "&titlestart - &titlestop";
data temp;
  set books.ytdsales(where=("&start"d le datesold le "&stop"d));

  profit=saleprice-cost;

  attrib profit label='Profit' format=dollar10.2;
run;
proc tabulate data=temp;
  var &vars;
  tables n*f=6. (&vars)*sum='Total'*f=dollar11.2;
  keylabel n='Titles Sold';
run;


/*********************************************************************/
*----Report B;
%let repyear=2007;
%let start=01jan&repyear;
%let stop=31mar&repyear;
%let classvar=section;
%let vars=saleprice profit;
%let titlestart=%sysfunc(putn("&start"d,worddate.));
%let titlestop=%sysfunc(putn("&stop"d,worddate.));

options pageno=1 symbolgen;

title "Sales Report";
title2 "&titlestart through &titlestop";
data temp;
  set books.ytdsales(where=("&start"d le datesold le "&stop"d));

  profit=saleprice-cost;
  attrib profit label='Profit' format=dollar10.2;
run;

proc tabulate data=temp;
  class &classvar;
  var &vars;
  tables section all, n*f=6. (&vars)*sum='Total'*f=dollar11.2 / rts=30;

  keylabel all='Total Sales'
           n='Titles Sold';
run;

proc gchart data=temp;
  title3 "Sales for Quarter";
    pie &classvar / type=sum sumvar=%scan(&vars,1)
    coutline=black percent=outside;
  run;
    pie &classvar / type=sum sumvar=%scan(&vars,2)
    coutline=black percent=outside;
  run;
quit;

/*********************************************************************/

*----REPORT C;
%let repyear=2007;
%let start=01jan&repyear;
%let stop=&sysdate;
%let classvar=section publisher;
%let vars=cost profit;
%let outputdest=rtf;
%let outputstyle=gears;
%let titlestart=%sysfunc(putn("&start"d,worddate.));
%let titlestop=%sysfunc(putn("&stop"d,worddate.));

options symbolgen;

ods listing close;
ods &outputdest style=&outputstyle;

title "Sales Report";
title2 "&titlestart ? &titlestop";

data temp;
  set books.ytdsales(where=("&start"d le datesold le "&stop"d));

  profit=saleprice-cost;

  attrib profit label='Profit' format=dollar10.2;
run;
proc tabulate data=temp;
  class &classvar;
  var &vars;
  tables %scan(&classvar,1)*( %scan(&classvar,2) all) all,
         n*f=6. (&vars)*sum*f=dollar11.2 / rts=30;

  keylabel all='Total Sales'
           n='Titles Sold';
run;

ods &outputdest close;
ods listing;


/*********************************************************************/
*----REPORT A;
options symbolgen mprint;

%macro reporta(repyear=,start=01JAN,stop=31DEC,
               vars=cost listprice saleprice profit);

  %let start=&start&repyear;
  %let stop=&stop&repyear;
  %let titlestart=%sysfunc(putn("&start"d,worddate.));
  %let titlestop=%sysfunc(putn("&stop"d,worddate.));

  title "Sales Report";
  title2 "&titlestart ? &titlestop";

  data temp;
    set books.ytdsales(where=("&start"d le datesold le "&stop"d));

    profit=saleprice-cost;

    attrib profit label='Profit' format=dollar10.2;
  run;
  proc tabulate data=temp;
    var &vars;
    tables n*f=6. (&vars)*sum='Total'*f=dollar11.2;

    keylabel n='Titles Sold';
  run;
%mend reporta;

%reporta(repyear=2007,start=01jul,stop=31aug)


/*********************************************************************/
options symbolgen mprint;

%macro reportb(repyear=,start=01JAN,stop=31DEC,classvar=,vars=);
  options pageno=1;

  %let start=&start&repyear;
  %let stop=&stop&repyear;
  %let titlestart=%sysfunc(putn("&start"d,worddate.));
  %let titlestop=%sysfunc(putn("&stop"d,worddate.));

  title "Sales Report";
  title2 "&titlestart - &titlestop";

  data temp;
    set books.ytdsales(where=("&start"d le datesold le "&stop"d));

    profit=saleprice-cost;

    attrib profit label='Profit' format=dollar10.2;
  run;

  proc tabulate data=temp;
    title3 "Sales for Quarter";
    class &classvar;
    var &vars;
    tables section all, n*f=6. (&vars)*sum='Total'*f=dollar11.2 / 
rts=30;

    keylabel all='Total Sales'
               n='Titles Sold';
  run;

  proc gchart data=temp;
      title3 "Sales for Quarter";
      pie &classvar / type=sum sumvar=%scan(&vars,1)
      coutline=black percent=outside;
    run;
      pie &classvar / type=sum sumvar=%scan(&vars,2)
      coutline=black percent=outside;
    run;
  quit;
%mend reportb;

%reportb(repyear=2007,stop=31Mar,classvar=section,vars=saleprice profit)


/*********************************************************************/
options symbolgen mprint;

%macro 
reportc(repyear=,start=01JAN,stop=31DEC,classvar=,vars=,outputdest=,styl
e=);
  options pageno=1;

  %let start=&start&repyear;
  %let stop=&stop&repyear;
  %let titlestart=%sysfunc(putn("&start"d,worddate.));
  %let titlestop=%sysfunc(putn("&stop"d,worddate.));

  ods listing close;
  ods &outputdest style=&outputstyle;

  title "Sales Report";
  title2 "&titlestart ? &titlestop";
  data temp;
    set books.ytdsales(where=("&start"d le datesold le "&stop"d));

    profit=saleprice-cost;

    attrib profit label='Profit' format=dollar10.2;
  run;
  proc tabulate data=temp;
    class &classvar;
    var &vars;
    tables %scan(&classvar,1)*( %scan(&classvar,2) all) all,
           n*f=6. (&vars)*sum*f=dollar11.2 / rts=30;

    keylabel all='Total Sales'
             n='Titles Sold';
  run;

  ods &outputdest close;
  ods listing;
%mend reportc;

%reportc(repyear=2007,stop=24NOV,classvar=section publisher,
         vars=cost profit,outputdest=rtf,style=gears)


/*********************************************************************/
options mprint mlogic symbolgen;

%macro report(repyear=,start=01JAN,stop=31DEC,
              classvar=,vars=cost listprice saleprice profit,
              outputdest=listing,style=);
  options pageno=1;

  %*----Check if a value was specified for report year.
        If no value specified,use current year;
  %if &repyear= %then %let repyear=%sysfunc(year(%sysfunc(today())));

  %*----Check if stop date specified. If null, use current date as stop 
date;
  %if &stop= %then %let stop=%substr(&sysdate,1,5);

  %let start=&start&repyear;
  %let stop=&stop&repyear;
  %let titlestart=%sysfunc(putn("&start"d,worddate.));
  %let titlestop=%sysfunc(putn("&stop"d,worddate.));

  %*----Check the output destination and style parameters;
  %*----Close LISTING, open alternate destination if specified;
  %*----Add STYLE if specified for the alternate destination;
  %if %upcase(&outputdest) ne LISTING %then %do;
    ods listing close;
    ods &outputdest
    %if &style ne %then %do;
      style=&style
    %end;
    ;
  %end;

  title "Sales Report";
  title2 "&titlestart - &titlestop";

  data temp;
    set books.ytdsales(where=("&start"d le datesold le "&stop"d));

    profit=saleprice-cost;

    attrib profit label='Profit' format=dollar10.2;
  run;
  proc tabulate data=temp;
  %*----Only submit a CLASS statement if there is a classification 
variable;
    %if &classvar ne %then %do;
      class &classvar;
    %end;
    var &vars;
    tables
    %if &classvar ne %then %do;
      %*---Determine leftmost row dimension variable;
      %let mainclas=%scan(&classvar,1);
      &mainclas
      %if %length(&mainclas) < %length(&classvar) %then %do;
      %*----If more than one classification variable, nest
            remaining classification variables under the first;
      %*----Use the substring function to extract
            classification variables after the first;
      %let pos2=%index(&classvar,%scan(&classvar,2));
      %*----Add the rest of the classification vars;
      * ( %substr(&classvar,&pos2) all)
    %end;
      all,
  %end;
    n*f=6. (&vars)*sum*f=dollar11.2;

   keylabel all='Total Sales'
            n='Titles Sold';
  run;

  %*----Check if date range is for a quarter or year;
  %let strtmdy=%upcase(%substr(&start,1,5));
  %let stopmdy=%upcase(%substr(&stop,1,5));

  %if (&strtmdy=01JAN and &stopmdy=31MAR) or
  (&strtmdy=01APR and &stopmdy=30JUN) or
  (&strtmdy=01JUL and &stopmdy=30SEP) or
  (&strtmdy=01OCT and &stopmdy=31DEC) or
  (&strtmdy=01JAN and &stopmdy=31DEC) %then %do;
    %*----Special titles for Quarter and for Year;
    %if not (&strtmdy eq 01JAN and &stopmdy eq 31DEC) %then %do;
      title3 "Sales for Quarter";
    %end;
    %else %do;
      title3 "&repyear Annual Sales";
    %end;

    proc gchart data=temp;
      %*----For each analysis variable, do a pie chart;
      %let setchrt=1;
      %let chrtvar=%scan(&vars,1);
      %do %while (&chrtvar ne );
          pie &classvar / type=sum sumvar=&chrtvar
                          coutline=black percent=outside;
        run;
        %let setchrt=%eval(&setchrt+1);
        %let chrtvar=%scan(&vars,&setchrt);
      %end;
    quit;
  %end;


  %*-----Close alternate destination if specified;
  %if %upcase(&outputdest) ne LISTING %then %do;
    ods &outputdest close;
    ods listing;
  %end;
%mend report;

*----Chapter 1 Step 4 Report A;
%report(repyear=2007,start=01jul,stop=31aug)

*----Chapter 1 Step 4 Report B;
%report(repyear=2007,stop=31Mar,classvar=section,vars=saleprice profit)

*----Chapter 1 Step 4 Report C;
%report(stop=,classvar=section publisher,vars=cost 
profit,outputdest=rtf,style=gears)
 