%% Preliminaries
% # This function depends on the Parallel Computing and/or MATLAB
% Distributed Computing Server Toolbox, so these toolboxes have to be
% installed first. The Distributed Computing Server Toolbox is only needed
% for the parameter |parallel| == 'cluster'.
%
%% Syntax
%       setParallelConfiguration(action)
%       setParallelConfiguration(action, parallel)
%       setParallelConfiguration(action, parallel, nWorker)
%       [parallel]= setParallelConfiguration(...)
%       [parallel, nWorker]= setParallelConfiguration(...)
%
%% Description
% |setParallelConfiguration(action)| opens respectively closes the environment
% for parallel computation. The environment in this default configuration
% is a multicore computer with 2 cores.
%
%%
% @param |action| : char
%
% * 'open' : opens the environmment for parallel computation
% * 'close' : closes the environmment for parallel computation
%
%%
% |setParallelConfiguration(action, parallel)| lets you define how the work
% should be distributed. 
%
%%
% @param |parallel| : Distribute the work to a bunch of computers or
% processors to solve the to be solved problem in parallel. char (default:
% 'multicore') 
%
% * 'none'          : use one single processor, no parallel computing. For
% this option this function has no effect
% * 'multicore'     : parallel computing using a multicore processor on one
% PC with the Parallel Computing Toolbox.
% * 'cluster'       : using Parallel Computing Toolbox functions and MATLAB
% Distributed Computing Server on a computer cluster, such that a number of
% computers can work on the problem. Not implemeted yet!
%
%%
% |setParallelConfiguration(action, parallel, nWorker)| lets you define the
% number of workers to run in parallel
% 
%%
% @param |nWorker|    : number of workers to run in parallel : 
% 2 for a dual core, 4 for a quadcore, when using with 'multicore', else
% number of computers (workers) in the cluster. The standard value is 2,
% when using parallel computing, else 1.
%
%%
% [parallel]= setParallelConfiguration(...)
%
% If opening the parallel computing environment fails, then the returned
% parameter |parallel| is reset to 'none'.
%
%%
% [parallel, nWorker]= setParallelConfiguration(...) 
%
% The returned parameter |nWorker| is set to 1, if the parameter |parallel|
% is or changes to 'none'. 
%
%% Example
% 

setParallelConfiguration('open', 'multicore', 2);

parfor i= 1:100
  % do something in parallel
  sin(i);
end

setParallelConfiguration('close');

%% TODO
% since at the moment this function does not close the pool, do it manually
% here
matlabpool close;



%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc matlabpool">
% matlab/matlabpool</a>
% </html>
% ,
% <html>
% <a href="getismatlabpoolopen.html">
% getIsMatlabPoolOpen</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('validateattributes')">
% matlab/validateattributes</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('validatestring')">
% matlab/validatestring</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('pctrunonall')">
% matlab/pctRunOnAll</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('biogas_control/startsarsa_lambda')">
% biogas_control/startSARSA_lambda</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_control/nonlinearmpc')">
% biogas_control/nonlinearMPC</a>
% </html>
% ,
% <html>
% <a href="startcmaes.html">
% startCMAES</a>
% </html>
% ,
% <html>
% <a href="startde.html">
% startDE</a>
% </html>
% ,
% <html>
% <a href="startfmincon.html">
% startFMinCon</a>
% </html>
% ,
% <html>
% <a href="startga.html">
% startGA</a>
% </html>
% ,
% <html>
% <a href="startga_patternsearch.html">
% startGA_PatternSearch</a>
% </html>
% ,
% <html>
% <a href="startisres.html">
% startISRES</a>
% </html>
% ,
% <html>
% <a href="startpso.html">
% startPSO</a>
% </html>
% ,
% <html>
% <a href="startpatternsearch.html">
% startPatternSearch</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('startstateestimation')">
% startStateEstimation</a>
% </html>
%
%% See Also
%
%
%% TODOs
% # matlabpool wird momentan nicht geschlossen, wegen NMPC implementierung,
% damit methoden selbst den pool nicht schlieﬂen, sondern nmpc am ende
% selbst
% # the option 'cluster' is not implemented yet
%
%% <<AuthorTag_DG/>>


