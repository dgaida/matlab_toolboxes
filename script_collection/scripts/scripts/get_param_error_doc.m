%% Syntax
%       value= get_param_error(param)
%       value= get_param_error(param, block)
%
%% Description
% |value= get_param_error(param)| gets given |param| of <matlab:doc('gcb')
% gcb> and returns it as |value|. If returned |value| is empty an error is
% thrown. 
%
%%
% @param |param| : char with the name of the variable
%
%%
% @param |block| : the block from which the parameter should be returned.
% Default: <matlab:doc('gcb') gcb>. 
%
%%
% @return |value| : the value of the variable
%
%% Example
%
% # Create a new Simulink model. 

try
  % create a new Simulink system
  new_system('test');
  
  % set variable of block
  disp(get_param_error('MaskValues'));
  
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
  disp(get_param_error('UserDataPersistent'));
catch ME
  disp(ME.message);
end

%%
% # This example throws a warning
% 

try
  disp(get_param_error('MaskValues'));
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
% <a href="matlab:doc get_param">
% matlab/get_param</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/checkargument">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc error">
% matlab/error</a>
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
% <a href="matlab:doc script_collection/set_param_tc">
% script_collection/set_param_tc</a>
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
% # check appearance of documentation and check links (hasVariable and
% getVariable do not exist)
% # improve documentation
%
%% <<AuthorTag_DG/>>

    
  