%% Syntax
%       isopen= getIsMatlabPoolOpen()
%
%% Description
% |isopen= getIsMatlabPoolOpen()| checks if <matlab:doc('matlabpool')
% matlabpool> is open. 
%
%%
% @return |isopen| : double scalar
%
% * 1, if matlabpool is open
% * 0, else
%
%% Example
% 

isopen= getIsMatlabPoolOpen();
disp(isopen)

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc matlabpool">
% matlab/matlabpool</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('fitnessfindoptimalequilibrium')">
% fitnessFindOptimalEquilibrium</a>
% </html>
% ,
% <html>
% <a href="setparallelconfiguration.html">
% setParallelConfiguration</a>
% </html>
%
%% See Also
%
% <html>
% <a href="startcmaes.html">
% startCMAES</a>
% </html>
% ,
% <html>
% <a href="startisres.html">
% startISRES</a>
% </html>
%
%% TODOs
% # see TODO in file
%
%% <<AuthorTag_DG/>>


