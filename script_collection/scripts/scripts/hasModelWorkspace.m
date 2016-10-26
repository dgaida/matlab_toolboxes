%% hasModelWorkspace
% Returns 1, if the given Simulink window has a modelworkspace, else 0.
%
function hasMWS= hasModelWorkspace(simulink_window)
%% Release: 2.9

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

global IS_DEBUG;

%%
%

if IS_DEBUG
  checkArgument(simulink_window, 'simulink_window', 'char', '1st');
end

%%
%

if ~isempty(simulink_window)
  try
    hws= get_param(simulink_window, 'modelworkspace');
  catch ME
    disp(ME.message);
    hws= [];
  end
else
  hws= [];
end


%%

if ~isempty(hws)
  hasMWS= 1;
else
  hasMWS= 0;
end

%%


