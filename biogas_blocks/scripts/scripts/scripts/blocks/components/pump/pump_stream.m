%% pump_stream
% Pump ADM1 stream between 2 fermenters.
%
function [sys,x0,str,ts]= ...,simStateCompliance]= 
    pump_stream(t,x,u,flag, plant, substrate, fermenter_name_start, ...
          fermenter_name_destiny, volumeflow_type, datasource_type, sensors) 
%% Release: 0.9

switch flag,

  %% 
  % Initialization
  %
  case 0,
      
    if iscell(fermenter_name_destiny)
        fermenter_name_destiny= fermenter_name_destiny{:};
    end

    if iscell(fermenter_name_start)
        fermenter_name_start= fermenter_name_start{:};
    end

    if iscell(volumeflow_type)
        volumeflow_type= volumeflow_type{:};
    end

    if iscell(datasource_type)
        datasource_type= datasource_type{:};
    end

    [sys,x0,str,ts]= ...,simStateCompliance]= ...
        mdlInitializeSizes(fermenter_name_start, ...
               fermenter_name_destiny, volumeflow_type, datasource_type, sensors);

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
      
      if iscell(fermenter_name_destiny)
          fermenter_name_destiny= fermenter_name_destiny{:};
      end
      
      if iscell(fermenter_name_start)
          fermenter_name_start= fermenter_name_start{:};
      end
      
      if iscell(datasource_type)
          datasource_type= datasource_type{:};
      end
      
    sys= mdlOutputs(t,x,u, plant, substrate, ...appendDATA, ...
                    fermenter_name_start, fermenter_name_destiny, ...
                    datasource_type, sensors);

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
function [sys,x0,str,ts,simStateCompliance]= ...
        mdlInitializeSizes(fermenter_name_start, ...
                           fermenter_name_destiny, volumeflow_type, ...
                           datasource_type, sensors)
%
% call simsizes for a sizes structure, fill it in and convert it to a
% sizes array.
%
sizes = simsizes;

sizes.NumContStates  = 0;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 1 + 1 + 1;
sizes.NumInputs      = 2;
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

% Specify the block simStateComliance. The allowed values are:
%    'UnknownSimState', < The default setting; warn and assume
%    DefaultSimState 
%    'DefaultSimState', < Same sim state as a built-in block
%    'HasNoSimState',   < No sim state
%    'DisallowSimState' < Error out when saving or restoring the model sim
%    state 
simStateCompliance = 'UnknownSimState';


%% NEW

flow_name= [fermenter_name_start '_' fermenter_name_destiny];

[q_flow, t_q]= create_volumeflow_from_source(flow_name, ...
                                volumeflow_type, datasource_type);

%%

q_state= [zeros(33, numel(q_flow.(flow_name))); q_flow.(flow_name)];

sensors.measureVecStream(...
    NET.convertArray(t_q.(flow_name), 'System.Double', numel(t_q.(flow_name))), ...
    'Q', ...
    NET.convertArray(q_state, 'System.Double', size(q_state)), ...
    ['Q_', flow_name]);


%%%%%%%%%%%%%



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
function sys=mdlOutputs(t,x,u, plant, substrate, ...
                        fermenter_name_start, fermenter_name_destiny, ...
                        datasource_type, sensors)

%%

%substrate_network= evalinMWS('substrate_network');
%subs_net= NET.convertArray(substrate_network, 'System.Double', size(substrate_network));

%%

if ~strcmp(datasource_type, 'extern')
 
  [P_kWh_d, Q_pump]= biogas.pump.run(t, sensors, u(1), ...
    fermenter_name_start, fermenter_name_destiny, plant);%, substrate, ...
    %subs_net);
       
else
    
  Q_pump= u(2);

  % call biogas.pump.run()
    
end

%%

% die ungepumpte Menge
Qeff= max(u(1) - Q_pump, 0);

% die gepumpte Menge
Qeff_pumped= u(1) - Qeff;

%%
%
% $$\vec{y}(t) := \left( Q_{eff}(t), Q_{eff,pumped}(t), P(t) [kWh/d]
% \right)^T$$
%
sys = [Qeff; Qeff_pumped; P_kWh_d]';



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


