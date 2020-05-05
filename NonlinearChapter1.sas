/*******************************************************************************/
/****   NonlinearChapter1.sas 												****/
/****	This program covers examples and exercises in The Mathematics Of	****/
/****	Nonlinear Programing - A.L Peressini, F.E. Sullivan and J.J. Uhl Jr.****/
/****	ISBN: 0-387-96614-5 												****/
/*******************************************************************************/
/*  https://documentation.sas.com/?docsetId=ormpug&docsetTarget=ormpug_nlpsolver_examples02.htm&docsetVersion=15.1&locale=en */

%let rc=%sysfunc(dlgcdir("/home/sas/repositories/OptDifEq"));
%include "Macros.sas";


/* Peressini et al pp.3 ex 1.1.6 */ 
%let objective_function = 3*x**4 - 4*x**3 + 1;
proc optmodel;
	var x >= -1.0 <= 1.50 init 0.5;
	minimize f = &objective_function;
	solve with nlp;
	print x;
quit;
%plotSolution(&objective_function,-0.5,1.5,0.01);




/***** Peressini et al pp.12 ex 1.2.7 *****/ 
%let objective_function = x[1]**2 - x[2]**2 + 4*x[3]**2 - 2*x[1]*x[2] + 4*x[2]*x[3];
proc optmodel;
	var x{1..3} >= -100 <= 100 init 1;
	minimize f = &objective_function;
	solve with nlp;
	print x.status;
	print x;
quit;

/***** Example 1.4.5 *****/
%let objective_function = x^4 - 4*x*y + y^4;
%plotSolution3D(&objective_function,lx=-2,hx=2,ly=-2,hy=2,by=0.1,rot=10);

proc optmodel printlevel=0 ;
	var x init -2, y init 1;
	num xsol{i in 1..3} init 0;
	num ysol{i in 1..3} init 0;
	num   fb{i in 1..3} init 0;
	number st, i;
	i = 0;
	minimize f = &objective_function   ;
	do st=-2,0,2 ;
		x=st;
		y=st;
		solve with nlp; 
		i=i+1;
		xsol[i]=x;
		ysol[i]=y;
		fb[i]=f;
	end;
	print xsol ysol fb;
quit;


























