/*
Imports the raw Excel spreadsheet into SAS. 
NOTE: Before executing please open spreadsheet and remove the first, second and forth tabs. 
*/

FILENAME REFFILE '/folders/myfolders/MIS450/fiscal-year-2019.xlsx';

PROC IMPORT DATAFILE=REFFILE
	DBMS=XLSX
	OUT=WORK.IMPORT;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.IMPORT; RUN;

/*
Creates Summary Statistics for the Compenstation Rate variable four hourly employees only. 
*/

proc means data=WORK.IMPORT (where=(COMP_FREQUENCY_CODE='H')) chartype mean std min max n vardef=df;
	var COMPENSATION_RATE;
run;

/*
Scatter Plot using the Compensation Rate Variable for hourly employees only. 
*/

proc sgplot data=WORK.IMPORT (where=(COMP_FREQUENCY_CODE='H'));
	scatter x=COMPENSATION_RATE y=AGENCY_NAME /;
	xaxis grid;
	yaxis grid;
run;
