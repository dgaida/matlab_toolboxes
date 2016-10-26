%% Syntax
%       set_param_tc(param, value)
%       set_param_tc(param, value, block)
%
%% Description
% |set_param_tc(param, value)| sets given |param| of <matlab:doc('gcb')
% gcb> to |value|. The call is surrounded by a try catch. On an error first
% a warning, then the error is thrown. 
%
%%
% @param |param| : char with the name of the variable
%
%%
% @param |value| : the value of the variable to be set
%
%%
% @param |block| : the block for which the parameter should be set.
% Default: <matlab:doc('gcb') gcb>. 
%
%% Example
%
% # Create a new Simulink model. 

variable= 1;

try
  % create a new Simulink system
  new_system('test');
  
  % set variable of block
  set_param_tc('MaskValues', variable);
  
  % close the model again without saving
  close_system('test', 0);
catch ME
  disp(ME.message);
  
  % close the model again without saving
  close_system('test', 0);
end

%%
% # This example throws a warning
% 

try
  set_param_tc('UserDataPersistent', 'on')
catch ME
  disp(ME.message);
end

%%
% # This example throws a warning
% 

try
  set_param_tc('MaskValues', [1 2 3; 4 5 6])
catch ME
  disp(ME.message);
end

%%
% # This example throws a warning
% 

try
  set_param_tc('MaskValues', 1);
catch ME
  disp(ME.message);
end

%%
% # This example throws a warning
% 

try
  set_param_tc('MaskValues', [{'on'}, {'off'}]);
catch ME
  disp(ME.message);
end


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc gcb">
% matlab/gcb</a>
% </html>
% ,
% <html>
% <a href="matlab:doc set_param">
% matlab/set_param</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/checkargument">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc try">
% matlab/try</a>
% </html>
%
% and is called by:
%
% <html>
% a lot of functions
% </html>
%
%% See Also
% 
% <html>
% <a href="assigninmws.html">
% assigninMWS</a>
% </html>
% ,
% <html>
% <a href="matlab:doc simulink/hasvariable">
% matlab/hasVariable</a>
% </html>
% ,
% <html>
% <a href="matlab:doc simulink/getvariable">
% matlab/getVariable</a>
% </html>
%
%% TODOs
% # create documentation for script file
% # check appearance of documentation and check links
% # improve documentation
%
%% <<AuthorTag_DG/>>

    
  