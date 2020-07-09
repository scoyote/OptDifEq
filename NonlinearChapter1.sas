/*******************************************************************************/
/****   NonlinearChapter1.sas 												****/
/****	This program covers examples and exercises in The Mathematics Of	****/
/****	Nonlinear Programing - A.L Peressini, F.E. Sullivan and J.J. Uhl Jr.****/
/****	ISBN: 0-387-96614-5 												****/
/*******************************************************************************/
/*  https://documentation.sas.com/?docsetId=ormpug&docsetTarget=ormpug_nlpsolver_examples02.htm&docsetVersion=15.1&locale=en */

%let rc=%sysfunc(dlgcdir("/repositories/OptDifEq/Macros.sas"));
%include "/repositories/OptDifEq/Macros.sas";


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

/****************************************************************************/
/***** Example 1.4.5 													*****/	
/****************************************************************************/
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

proc optmodel;* printlevel=0 ;
	var x >= -5 <= 5 init -5
	   ,y >= -5 <= 5 init 5;
	minimize f = &objective_function   ;
	solve;* with nlp / ms=(maxstarts=100) seed=42042; 
	print x y _nsol_;
quit;
/****************************************************************************/
/***** Example 1.4.5 													*****/	
/****************************************************************************/
%let objective_function = x^2 + y^2 + z^3 - 4*x*y;
proc optmodel;* printlevel=0 ;
	var x >= -5 <= 5 init 0
	   ,y >= -5 <= 5 init 0
	   ,z >= -5 <= 5 init 0;
	minimize f = &objective_function   ;
	solve with nlp;
	print x y z _nsol_;
run;
quit;

/****************************************************************************/
/***** Exercise 1 pp 31													*****/	
/****************************************************************************/
%let objective_function = x^2 + 2*x;
%plotSolution(&objective_function,-2,1,0.1);
proc optmodel;
	var x >= -5 <= 5 init 0;
	minimize f = &objective_function   ;
	solve ;
	print x f _nsol_;
run;
quit;


/****************************************************************************/
/***** Exercise 2 pp 31													*****/	
/****************************************************************************/
%let objective_function = x^2 * exp(x^2);
%plotSolution(&objective_function,-1,1,0.1);
proc optmodel;
	var x >= -1 <= 1 init 0;
	minimize f = &objective_function   ;
	solve ;
	print x f _nsol_;
run;
quit;


/****************************************************************************/
/***** Exercise 3 pp 31													*****/	
/****************************************************************************/
%let objective_function = x^4 + 4*x^3 +6*x^2 + 4*x;
%plotSolution(&objective_function,-1.5,0.5,0.1);
proc optmodel;
	var x >=5 <=2 init -1;
	minimize f = &objective_function   ;
	solve ;
	print x f _nsol_;
run;
quit;

/****************************************************************************/
/***** Exercise 4 pp 31													*****/	
/****************************************************************************/
%let objective_function = x + sin(x);
%plotSolution(&objective_function,-5,5,0.1);
proc optmodel;
	var x >=5 <=5 init -1;
	minimize f = &objective_function   ;
	solve ;
	print x f _nsol_;
run;
quit;


/****************************************************************************/
/***** Exercise 10a pp 31												*****/	
/****************************************************************************/
%let objective_function = x^2 - 4*x +2*y^2 + 7;
%plotSolution3d(&objective_function,lx=-5,hx=5,ly=-5,hy=5,by=0.1,rot=5);
proc optmodel;
	var x init 1
	   ,y init 0;
	minimize f = &objective_function   ;
	solve ;
	print x y f _nsol_;
run;
quit;


/****************************************************************************/
/***** Exercise 10b pp 31												*****/	
/****************************************************************************/
%let objective_function = exp(-(x^2+y^2));
%plotSolution3d(&objective_function,lx=-2,hx=2,ly=-2,hy=2,by=0.1,rot=45);
proc optmodel;
	var x init 1
	   ,y init 0;
	maximize f = &objective_function   ;
	solve ;
	print x y f _nsol_;
run;
quit;










