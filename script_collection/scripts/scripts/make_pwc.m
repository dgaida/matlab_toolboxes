%% make_pwc
% Make a piecewise constant signal
%
function [time_pwc, data_pwc]= make_pwc(deltatime, v_data)
%% Release: 1.4

%%

error( nargchk(2, 2, nargin, 'struct') );
error( nargoutchk(2, 2, nargout, 'struct') );

%%
% check arguments

isR(deltatime, 'deltatime', 1, '+');
isRn(v_data, 'v_data', 2);

%%

v_data= v_data(:);

%%
% create equidistant grid
time_grid= (0:deltatime:size(v_data,1)*deltatime)';

%%
% letzter fluss wird noch mal angehängt, damit simulink ab
% letztem fluss konstant weiter simuliert, sonst abnahme auf 0
v_data= [v_data; v_data(end)];

%%
% create grid for intermediate points to get a pwc signal
time_grid_2= (deltatime - deltatime/20:deltatime:...
              (size(v_data,1) - 1)*deltatime)';
time_grid= [[0; time_grid_2], time_grid]';

time_grid= time_grid(:);

%%

v_data= [v_data, v_data]';
v_data= v_data(:);

%%
% throw away the first 0
time_pwc= time_grid(2:end);

% throw away the last duplicate
data_pwc= v_data(1:end - 1);

%%



%%


