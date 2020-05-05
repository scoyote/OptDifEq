
 
 
/*  https://documentation.sas.com/?docsetId=ormpug&docsetTarget=ormpug_nlpsolver_examples02.htm&docsetVersion=15.1&locale=en */
%let rc=%sysfunc(dlgcdir("/home/sas/repositories/OptDifEq"));
%include "Macros.sas";

ods output PrintTable=_sol;


/* Peressini et al pp.3 ex 1.1.6 */ 
%let objective_function = 3*x**4 - 4*x**3 + 1;
proc optmodel;
	var x >= -1.0 <= 1.50 init 0.5;
	minimize f = &objective_function;
	solve with nlp;
	print x;
quit;
%plotSolution(&objective_function,-0.5,1.5,0.01);




/* Peressini et al pp.12 ex 1.2.7 */ 
%let objective_function = x[1]**2 - x[2]**2 + 4*x[3]**2 - 2*x[1]*x[2] + 4*x[2]*x[3];
proc optmodel;
	var x{1..3} >= -100 <= 100 init 1;
	minimize f = &objective_function;
	solve with nlp;
	print x.status;
	print x;
quit;

/* Example 1.4.5 */
%let objective_function = x[1]^4 - 4*x[1]*x[2] + x[2]^4;
ods trace on;
proc optmodel;
	var x{i in 1..2} >=-2.0 <=2.0 init -2;
	minimize f = &objective_function;
	solve with nlp /  seed=21 ms=(bndrange=1 maxstarts=300 printlevel=3) ;
	print x.msinit x ;
quit;
ods trace off;

/* this function has three minimizers (-1,-1), (0,0) and (1,1). You can find all three by changing




