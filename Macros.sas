%macro plotSolution(obj,low,high,by);
	%let obj = %qsysfunc(compress(%sysfunc(tranwrd("&obj",%str(^),%str(**))),"%"));
	data _graph;
		do x = &low to &high by &by;
			y = &obj;
			output;
		end;
	run;
	ods graphics /reset=all height=2in width=3in;
	proc sgplot data=_graph;
		series x = x y = y /smoothconnect;
	run;
%mend plotSolution;

/*Comment*/
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

%macro animate(obj,lx=-1,hx=1,ly=-1,hy=1,zl=-3,zh=3,by=0.01,sol=_sol,solvar=x,rot=25);
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
	goptions reset=all;
	options printerpath	= svg 
		animate			= start 
		animduration	= 0.1
		svgfadein		= 0 
		svgfadeout		= 0 
		noanimoverlay 
		nodate nonumber; 
	ods printer file="AnimatedFunction.svg";
/* 	%do i=1 %to %sysevalf(360/&rot); */
/* 		%let rotate=%sysevalf(&i * &rot); */

		proc g3d data=_graph;
		   plot y*x=z / grid
		                rotate=0 to 360 by &rot
		                tilt= 75
		                xticknum=5
		                yticknum=5
		                zticknum=5
		                zmin=&zl
		                zmax=&zh;
		run;
		quit;
/* 	%end; */
	options animation=stop;
	ods printer close;
/* 	proc datasets library=work; delete _graph; quit; */
%mend animate;







