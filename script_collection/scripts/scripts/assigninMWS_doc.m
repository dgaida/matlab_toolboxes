%% Syntax
%       mybdroot= assigninMWS(variable_name, variable)
%       assigninMWS(variable_name, variable, throw_error)
%       assigninMWS(variable_name, variable, throw_error, silent)
%
%% Description
% |mybdroot= assigninMWS(variable_name, variable)| assigns |variable| to the
% <matlab:doc('simulink/modelworkspace') model workspace> of the current
% load Simulink model (<matlab:doc('bdroot') top-level Simulink system>) 
% naming the variable |variable_name|. If |variable| could not be assigned
% to the model's workspace, then a warning and an error is thrown, such
% that it is recommended to call the function in a <matlab:doc('try')
% try/catch> block, see the example below. If the model has no model
% workspace, e.g. a <matlab:docsearch('Working,with,Block,Libraries') block
% library>, or no model is load at all then no warning and no
% <matlab:doc('error') error> is thrown, see the function argument
% |throw_error|. 
%
%%
% @param |variable_name| : char with the name of the variable under which it 
% is assigned in the model's workspace
%
%%
% @param |variable| : the to be assigned variable of an arbitrary class
%
%%
% @return |mybdroot| : returns <matlab:doc('matlab/bdroot') bdroot>, called
% inside the function. If it is empty, then no model is load at all. 
%
%%
% |assigninMWS(variable_name, variable, throw_error)| throws an additional
% warning and error, when the model has no model workspace, if throw_error
% == 1. 
%
%%
% @param |throw_error| : 
%
% * 0 : no additional warning and error is thrown (default, see above)
% * 1 : an additional warning and error is thrown, if the model has no
% model workspace 
%
%%
% @param |silent| : 
%
% * 0 : <matlab:doc('script_collection/dispmessage')
% script_collection/dispMessage> is called when variable was successfully
% set into modelworkspace, displaying a message
% * 1 : no message is displayed
%
%% Example
%
% # Create a new Simulink model and then assign the variable myVariable to
% the model workspace of this model. 

variable= 1;

try
  % create a new Simulink system
  new_system('test');
  
  mybdroot= assigninMWS('myVariable', variable);
  
  if isempty(mybdroot)
    disp('No model is load!');
  else
    fprintf('%s was successfully assigned to model workspace of %s!\n', ...
            'myVariable', mybdroot);
  end
  
  % close the model again without saving
  close_system('test', 0);
catch ME
  disp(ME.message);
end

%%
% # This example throws a warning and error if the currently load model has
% no model workspace. If no model is load at all, then no warning and no
% error is thrown. 
% 

try
  mybdroot= assigninMWS('myVariable', variable);
  
  if isempty(mybdroot)
    disp('No model is load!');
  else
    fprintf('%s was successfully assigned to model workspace of %s!\n', ...
            'myVariable', mybdroot);
  end
catch ME
  disp(ME.message);
end

%%
% # This example always throws a warning and error if the currently load
% model has no model workspace or if no model is load at all. 
% 

try
  assigninMWS('myVariable', variable, 1);
catch ME
  disp(ME.message);
end

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc matlab/assignin">
% matlab/assignin</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/bdroot">
% matlab/bdroot</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/get_param">
% matlab/get_param</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/checkargument">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/dispmessage">
% script_collection/dispMessage</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/is0or1">
% script_collection/is0or1</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/error_time">
% script_collection/error_time</a>
% </html>
% ,
% <html>
% <a href="matlab:doc script_collection/warning_time">
% script_collection/warning_time</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/validateattributes">
% matlab/validateattributes</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc assign_initstate_inmws">
% assign_initstate_inMWS</a>
% </html>
% ,
% <html>
% <a href="matlab:doc createvolumeflowfile">
% createvolumeflowfile</a>
% </html>
% ,
% <html>
% <a href="matlab:doc setnetworkfluxinworkspace">
% setNetworkFluxInWorkspace</a>
% </html>
% 
%% See Also
% 
% <html>
% <a href="evalinmws.html">
% script_collection/evalinMWS</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/new_system">
% matlab/new_system</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/close_system">
% matlab/close_system</a>
% </html>
% ,
% <html>
% <a href="matlab:docsearch('Working with Block Libraries')">
% Working with Block Libraries</a>
% </html>
%
%% TODOs
% # create documentation for script file
%
%% <<AuthorTag_DG/>>


