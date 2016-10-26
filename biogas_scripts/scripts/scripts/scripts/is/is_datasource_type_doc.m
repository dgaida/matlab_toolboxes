%% Syntax
%       is_datasource_type(argument, argument_number)
%
%% Description
% |is_datasource_type(argument, argument_number)| checks if the given
% |argument| is a datasource type, defined by datasourcetypes.mat. The
% |argument| is the |argument_number| th argument of the calling function. 
%
%%
% @param |argument| : The argument that will be checked. Should be a char
% with a datasource type, usually: 'extern', 'file', 'workspace',
% 'modelworkspace'. 
%
%%
% @param |argument_number| : integer with the argument number in the
% calling function. 
%
%% Example
% 
% This call is ok

is_datasource_type('file', 4)

%%
% The next call throws an error

try
  is_datasource_type('test', 1)
catch ME
  disp(ME.message)
end

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc script_collection/isn">
% script_collection/isN</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/load_file">
% biogas_scripts/load_file</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/validatestring">
% matlab/validatestring</a>
% </html>
%
% and is called by:
%
% (all functions)
%
%% See Also
% 
% <html>
% <a href="matlab:doc biogas_scripts/is_volumeflow_type">
% biogas_scripts/is_volumeflow_type</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/is_initstate_type">
% biogas_scripts/is_initstate_type</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/is_substrate">
% biogas_scripts/is_substrate</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/is_plant">
% biogas_scripts/is_plant</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/is_sensors">
% biogas_scripts/is_sensors</a>
% </html>
% ,
% <html>
% <a href="matlab:doc validateattributes">
% matlab/validateattributes</a>
% </html>
%
%% TODOs
% # create documentation of script file
% # check appearance of documentation
%
%% <<AuthorTag_DG/>>


