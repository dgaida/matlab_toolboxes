%% getNumSteps_Tc
% Calculates number of possible steps of feed over the control horizon
%
function num_steps= getNumSteps_Tc(control_horizon, delta)
%% Release: 1.4

%%

narginchk(2, 2);
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% check arguments

isN(control_horizon, 'control_horizon', 1);
isR(delta, 'delta', 2, '+');

%%

if control_horizon < delta
  warning('numSteps:iszero', 'control_horizon < delta: %i < %.2f', control_horizon, delta);
end

%%
% Round toward zero
num_steps= fix(control_horizon / delta);

%%


