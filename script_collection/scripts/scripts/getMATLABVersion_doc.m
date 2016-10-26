%% Syntax
%       matlab_ver= getMATLABVersion()
%       
%% Description
% |matlab_ver= getMATLABVersion()| returns the MATLAB version as a 3 digits
% long number. Version 7.8 is returned as 708, version 7.11 as 711. This
% function is used to determine if current MATLAB version is newer then a
% given one, by just comparing using relations: <, >, ...
%
%%
% @return |matlab_ver| : MATLAB version as a 3 digits long number
% 
%% Example
%
% # Get your MATLAB version:

fprintf('My MATLAB version: %i.\n', getMATLABVersion())

%%
% # You can also use this MATLAB function, the effect is pretty much the
% same: 

verLessThan('matlab', '7.0.1')

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc ver">
% matlab/ver</a>
% </html>
% ,
% <html>
% <a href="matlab:doc fix">
% matlab/fix</a>
% </html>
%
% and is called by:
%
% <html>
% many functions
% </html>
%
%% See Also
%
% <html>
% <a href="matlab:doc verlessthan">
% matlab/verLessThan</a>
% </html>
% ,
% <html>
% <a href="matlab:doc version">
% matlab/version</a>
% </html>
%
%% TODOs
% # Add documentation in script file.
%
%% <<AuthorTag_DG/>>


