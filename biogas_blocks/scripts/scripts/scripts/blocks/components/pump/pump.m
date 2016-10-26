%% pump
% Calculate the power used to pump the substrate mix.
%
function [sys,x0,str,ts]= ...,simStateCompliance] = 
    pump(t,x,u,flag, ...
          plant, substrate, appendDATA, fermenter_id, h_friction)
%% Release: 0.9

switch flag,

  %% 
  % Initialization
  %
  case 0,
      
      [sys,x0,str,ts]= ...,simStateCompliance]=
          mdlInitializeSizes();

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
      
      if iscell(fermenter_id)
          fermenter_id= fermenter_id{:};
      end
      
    sys=mdlOutputs(t,x,u, plant, substrate, appendDATA, ...
                    fermenter_id, h_friction);

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
function [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes()
%
% call simsizes for a sizes structure, fill it in and convert it to a
% sizes array.

sizes = simsizes;

sizes.NumContStates  = 0;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 1;
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
function sys=mdlOutputs(t,x,u, plant, substrate, appendDATA, ...
                        fermenter_id, h_friction)

%global energy;

%%
% constant of gravitation g [m/s^2]
%
g= plant.g.Value;
%%
% the length that the pump has to lift the substrate against the
% gravitation force of the earth [m] 
%
% if isfield(plant.fermenter, fermenter_id)
%     h_lift= plant.fermenter.(fermenter_id).inflow.pump.liftingheight;
% else
%     error('%s is not a field of plant.fermenter!', fermenter_id);
% end
%% TODO
h_lift= 1;

%%
% degree of efficiency of the pump [100 \%]
%
%eta= plant.fermenter.(fermenter_id).inflow.pump.eta;
%% TODO
eta= 0.5;

if eta <= 0 || eta > 1
    error('eta must be > 0 and <= 1, but is %.2f', eta);
end

%%
% Reibungskoeffizient \mu
mu= 0.2; 

% calculate the mean density of the substrate mix
% [g/m^3]
% u(2) ist in [kg/m^3]
density= 1000 * u(2);

%%
% $$P(t) [kWh/d]= u(t) \cdot \left( h_{lift} + h_{friction} \cdot \mu
% \right) \cdot \rho \cdot g /  
% \eta \cdot \frac{1}{3600 \cdot 1000 \cdot 1000}$$
%
% $$\left[ \frac{kWh}{d} \right] = \left[ \frac{kW \cdot 3600 s}{d} \right]
% = \left[ \frac{kNm \cdot 3600}{d} \right]
% = \left[ \frac{k \cdot kg \cdot m^2 \cdot 3600}{d \cdot s^2} \right] =
% \left[  
% \frac{m^3}{d} \cdot m \cdot \frac{g}{m^3} \cdot  
% \frac{m}{s^2} \cdot \frac{k \cdot k}{1000 \cdot 1000} \right]$$
%
P_kWh_d= u(1) / 3600 .* (h_lift + h_friction * mu) * density / 1000 * ...
                                                     g / eta / 1000;

        
%% TODO
% do not use plant_model anymore!!!

%% TODO
% diese pumpe misst zwischen substratzufuhr und fermenter. ab sofort müsste
% diese offiziell unter pumpen angelegt werden und dann hat die pumpe ein
% start und ein ziel, sowie pump_stream. Unterschied ist nur, dass diese
% pumpe hier in den strom geschaltet wird und pump_stream eine
% stromstrennung macht

% try
%     plant_model= evalin('base', [bdroot, '_data']);
% catch ME
%     rethrow(ME);
% end
% 
% plant_model.setPumpedEnergyvalue( fermenter_id, t, deltatime, ...
%                                   P_kWh_d, appendDATA );
                                                 
                                                
%%
%
% $$\vec{y}(t) := \left( P(t) [kWh/d]
% \right)^T$$
%
sys = [P_kWh_d]';



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


