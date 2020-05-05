%macro plotSolution(obj,low,high,by,sol=_sol,solvar=x);
	data _null_; set _sol; call symput("solution",compress(round(x,0.1))); run;
	data _graph;
		do x = &low to &high by &by;
			y = &objective_function;
			output;
		end;
	run;
	ods graphics /reset=all height=2in width=3in;
	proc sgplot data=_graph;
		series x = x y = y /smoothconnect;
		inset ("f(x) = &objective_function minimized at x=" = "&solution");
	run;
%mend plotSolution;


%macro plotSolution3D(obj,lx=-1,hx=1,ly=-1,hy=1,zl=-3,zh=3,by=0.01,sol=_sol,solvar=x,rot=25);
	%let obj = %qsysfunc(compress(%sysfunc(tranwrd("&obj",%str(^),%str(**))),"%"));
	data _graph;
		do x = &lx to &hx by &by;
			do y = &ly to &hy by &by;
				z=&obj ;
				output;
			end;
		end;
	run;
	title "&obj";
	proc sgplot data=_graph aspect=1;
	proc g3d data=_graph;
	   plot y*x=z / grid
	                rotate=&rot
	                xticknum=5
	                yticknum=5
	                zticknum=5
	                zmin=&zl
	                zmax=&zh;
	run;
	quit;

/* 	proc datasets library=work; delete _graph; quit; */
%mend plotSolution3D;

