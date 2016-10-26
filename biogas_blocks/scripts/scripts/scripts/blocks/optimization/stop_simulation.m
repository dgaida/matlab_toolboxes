%% stop_simulation
% Stop simulation
%
function [sys,x0,str,ts,simStateCompliance] = stop_simulation(t,x,u,flag, ...
          sensors, deltatime)
%% Release: 0.9

switch flag,

  %% 
  % Initialization
  %
  case 0,
      
      [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes();

  %% 
  % Derivatives
  %
  case 1,
    sys=mdlDerivatives();

  %% 
  % Update
  %
  case 2,
    sys=mdlUpdate();

  %% 
  % Outputs
  %
  case 3,
      
    sys=mdlOutputs(t,x,u, sensors, deltatime);

  %% 
  % GetTimeOfNextVarHit
  %
  case 4,
    sys=mdlGetTimeOfNextVarHit(t);

  %% 
  % Terminate
  %
  case 9,
      
    sys=mdlTerminate();

  %% 
  % Unexpected flags
  %
  otherwise
    DAStudio.error('Simulink:blocks:unhandledFlag', num2str(flag));

end


%% 
% mdlInitializeSizes
%
% Return the sizes, initial conditions, and sample times for the S-function.
%
function [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes()
%
% call simsizes for a sizes structure, fill it in and convert it to a
% sizes array.
%
sizes = simsizes;

sizes.NumContStates  = 0;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 1;
sizes.NumInputs      = 1;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;   % at least one sample time is needed

sys = simsizes(sizes);

tic;

%
% initialize the initial conditions
%
x0  = [];

%
% str is always an empty matrix
%
str = [];

%
% initialize the array of sample times
%
ts  = [0 0];

% Specify the block simStateComliance. The allowed values are:
%    'UnknownSimState', < The default setting; warn and assume DefaultSimState
%    'DefaultSimState', < Same sim state as a built-in block
%    'HasNoSimState',   < No sim state
%    'DisallowSimState' < Error out when saving or restoring the model sim state
simStateCompliance = 'UnknownSimState';


%% 
% mdlDerivatives
%
% Return the derivatives for the continuous states.
%
function sys=mdlDerivatives()

sys = [];


%% 
% mdlUpdate
%
% Handle discrete state updates, sample time hits, and major time step
% requirements.
%
function sys=mdlUpdate()

sys = [];


%% mdlOutputs
%
% Return the block outputs.
%
function sys=mdlOutputs(t,x,u, sensors, deltatime)

%% TODO
% 
% add convergence criterion
% wenn sich der zustandsvektor in den letzten simulationsschritten nicht
% mehr ändert, dann stop (letzte 50 Tage vielleicht)
%
% evtl. auch hinzufügen, dass nur maximal 500 Tage simuliert werden kann?
%
% add sensors and make decision depend on measurements
%

% toc > time in seconds
if (t > u)

  set_param(bdroot, 'SimulationCommand', 'stop');
    
end

sys= 0;


%% 
% mdlGetTimeOfNextVarHit
%
% Return the time of the next hit for this block.  Note that the result is
% absolute time.  Note that this function is only used when you specify a
% variable discrete-time sample time [-2 0] in the sample time array in
% mdlInitializeSizes.
%
function sys=mdlGetTimeOfNextVarHit(t)

sampleTime = 1;    %  Example, set the next hit to be one second later.
sys = t + sampleTime;


%% 
% mdlTerminate
%
% Perform any end of simulation tasks.
%
function sys=mdlTerminate()

sys = [];


%%


