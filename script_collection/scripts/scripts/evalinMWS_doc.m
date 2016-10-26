%% Syntax
%       value= evalinMWS(variable)
%       value= evalinMWS(variable, throw_error)
%
%% Description
% |value= evalinMWS(variable)| evaluates the variable |variable| in the 
% <matlab:doc('simulink/modelworkspace') model workspace> of the current
% load Simulink model 
% (<matlab:doc('bdroot') top-level Simulink system>) and returns its value 
% to |value|. If |variable| could not be evaluated in the model's workspace,
% then a warning and an error is thrown, such that it is recommended to
% call the function in a <matlab:doc('try') try/catch> block, 
% see the example below. If the model has no model workspace, 
% e.g. a <matlab:docsearch('Working,with,Block,Libraries') block
% library>, then no warning and no <matlab:doc('error') error> is thrown,
% see the function argument |throw_error|.
%
%%
% @param |variable| : char with the name of the variable
%
%%
% @return |value| : the value of the variable in the model workspace
%
%%
% |value= evalinMWS(variable, throw_error)| throws an additional warning
% and error, if the model has no model workspace, if |throw_error| == 1.
%
%%
% @param |throw_error| : 
%
% * 0 : no additional warning and error is thrown (default)
% * 1 : an additional warning and error is thrown, if the model has no
% model workspace 
%
%% Example
%
% # Create a new Simulink model and try to evalin myVariable in model
% workspace of new system -> will return an error. Then assign the variable
% myVariable to the model workspace of the new model. The 2nd evalinMWS
% call will return the value. 

variable= 1;

try
  % create a new Simulink system
  new_system('test');
  
  try
    % as myVariable does not exist in model workspace of current system,
    % will throw an error
    evalinMWS('myVariable')
  catch ME
    disp('At the moment the variable myVariable does not exist in the model workspace!')
    disp(ME.message)
  end
  
  % set variable in model workspace
  assigninMWS('myVariable', variable);
  
  disp('Now the variable myVariable does exist in the model workspace!')
  
  % this time no error will be thrown
  evalinMWS('myVariable')
  
  % close the model again without saving
  close_system('test', 0);
catch ME
  disp(ME.message);
end

%%
% # This example throws an error if the currently load model has no model
% workspace. If no model is load at all, then no error is thrown. 
% 

try
 evalinMWS('myVariable')
catch ME
 disp(ME.message);
end

%%
% # This example always throws an error if the currently load model has no model
% workspace or if no model is load at all. 
% 

try
 value= evalinMWS('myVariable', 1);
catch ME
 disp(ME.message);
end

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc bdroot">
% matlab/bdroot</a>
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
% <a href="matlab:doc script_collection/is0or1">
% script_collection/is0or1</a>
% </html>
% ,
% <html>
% <a href="matlab:doc validateattributes">
% matlab/validateattributes</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/evalin">
% matlab/evalin</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc biogas_control/nmpc_simbiogasplantextended">
% biogas_control/NMPC_simBiogasPlantExtended</a>
% </html>
% ,
% <html>
% a lot further functions ... 
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
%
%% <<AuthorTag_DG/>>

    
  