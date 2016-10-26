%% chps
% Distribute biogas to biogas chp (combined heat and power) plants and burn
% it there. 
%
function [sys,x0,str,ts]= ...,simStateCompliance] = 
    chps(t,x,u,flag, sensors, plant, gas2bhkwsplittype)
%% Release: 1.2

%%

switch flag,

  %% 
  % Initialization
  %
  case 0,
    
    %% 
    % check arguments in initialization
  
    is_sensors(sensors, 5);
    is_plant(plant, 6);
    
    [sys,x0,str,ts]= ...,simStateCompliance]=
        mdlInitializeSizes(plant);

  %% 
  % Derivatives
  %
  case 1,
    sys=mdlDerivatives(t,x,u);

  %% 
  % Update
  %
  case 2,
    sys=mdlUpdate(t,x,u);

  %% 
  % Outputs
  %
  case 3,      
      
    gas2bhkwsplittype= char(gas2bhkwsplittype);
      
    sys= mdlOutputs(t,x,u, sensors, plant, gas2bhkwsplittype);

  %% 
  % GetTimeOfNextVarHit
  %
  case 4,
    sys=mdlGetTimeOfNextVarHit(t,x,u);

  %% 
  % Terminate
  %
  case 9,
    sys=mdlTerminate(t,x,u);

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
function [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes(plant)
%
% call simsizes for a sizes structure, fill it in and convert it to a
% sizes array.
%
% Note that in this example, the values are hard coded.  This is not a
% recommended practice as the characteristics of the block are typically
% defined by the S-function parameters.
%
sizes = simsizes;

sizes.NumContStates  = 0;
sizes.NumDiscStates  = 0;
% power for each chp and biogas excess
sizes.NumOutputs     = plant.getNumCHPsD() + 1;
sizes.NumInputs      = plant.getNumDigestersD() * biogas.BioGas.n_gases;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;   % at least one sample time is needed

sys = simsizes(sizes);

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
%% 
% s. doc sfuntmpl
% Continuous, but fixed in minor step sample time. das heisst, dass in
% jedem Simulationsschritt auch dieser Block aufgerufen wird, bei [0 0]
% werden sensor blöcke nur mit der max. schrittweite aufgerufen, welche in
% init_biogas_plant_mdl.m angegeben wird.
%% TODO
% Funktioniert nicht so wie erwartet, da völlig andere Ergebnisse heraus
% kommen, evtl. verändert man damit die sample time?
% versteh ich nicht
%ts  = [0 1];

% Specify the block simStateComliance. The allowed values are:
%    'UnknownSimState', < The default setting; warn and assume
%    DefaultSimState 
%    'DefaultSimState', < Same sim state as a built-in block
%    'HasNoSimState',   < No sim state
%    'DisallowSimState' < Error out when saving or restoring the model sim
%    state 
simStateCompliance = 'UnknownSimState';


%% 
% mdlDerivatives
%
% Return the derivatives for the continuous states.
%
function sys=mdlDerivatives(t,x,u)

sys = [];


%% 
% mdlUpdate
%
% Handle discrete state updates, sample time hits, and major time step
% requirements.
%
function sys=mdlUpdate(t,x,u)

sys = [];


%% 
% mdlOutputs
%
% Return the block outputs.
%
function sys=mdlOutputs(t,x,u, sensors, plant, gas2bhkwsplittype)

%%

try
  biogas_vec= biogas.chps.run(t, NET.convertArray(u, 'System.Double', numel(u)), ...
            sensors, plant, gas2bhkwsplittype);
catch ME
  rethrow(ME);
end

biogas_vec= double(biogas_vec)';  

sys= biogas_vec;


%% 
% mdlGetTimeOfNextVarHit
%
% Return the time of the next hit for this block.  Note that the result is
% absolute time.  Note that this function is only used when you specify a
% variable discrete-time sample time [-2 0] in the sample time array in
% mdlInitializeSizes.
%
function sys=mdlGetTimeOfNextVarHit(t,x,u)

sampleTime = 1;    %  Example, set the next hit to be one second later.
sys = t + sampleTime;


%% 
% mdlTerminate
%
% Perform any end of simulation tasks.
%
function sys=mdlTerminate(t,x,u)

sys = [];


%%


