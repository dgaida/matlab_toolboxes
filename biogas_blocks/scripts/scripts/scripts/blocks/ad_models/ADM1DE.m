%% ADM1DE
% Implementation of the Anaerobic Digestion Model No. 1 (ADM1) as DE system
%
function [sys,x0,str,ts]= ...,simStateCompliance]= 
          ADM1DE(t,x,u,flag, sensors, plant, substrate, substrate_network, ...
          plant_network, fermenter_id, initstate_type, ...
          datasource_type, savestate, onoff)
%% Release: 1.0

switch flag,

  %% 
  % Initialization
  %
  case 0,
           
    %% TODO check how long these calls take, char() should be faster
    %if iscell(fermenter_id)
        fermenter_id= char(fermenter_id);%{:};
    %end
    
    %% 
    % check arguments
    
    is_sensors(sensors, 5);
    is_plant(plant, 6);
    is_substrate(substrate, 7);
    is_substrate_network(substrate_network, 8, substrate, plant);
    is_plant_network(plant_network, 9, plant);
    
    is0or1(onoff, 14);
    
    %%
    % clear sensors object
    % this is needed, because in calc_xdot this is used to detect, whether
    % we are at the start of the simulation or not. if sensors is empty,
    % then we are at the start of the simulation. this is needed, such that
    % adm1 params are set to correct values at start of simulation also if
    % we do not start at time 0 but any other time
    
    % is done in simBiogasPlant
    %sensors.deleteDataFromAllSensors();
    
    %% TODO
    % why is this not done in init_biogas_plant_mdl.m???
    
    % after that sensors should be empty
    
    %%
    % set heating on/off
    
    digester= plant.getDigesterByID(fermenter_id);
    
    digester.set_params_of('status', onoff);

    %%
    
    if iscell(initstate_type)
        initstate_type= initstate_type{:};
    end

    if iscell(datasource_type)
        datasource_type= datasource_type{:};
    end

    [sys,x0,str,ts]= ...,simStateCompliance]= ...
        mdlInitializeSizes(plant, fermenter_id, initstate_type, ...
                           datasource_type);

  %% 
  % Derivatives
  %
  case 1,
      
    fermenter_id= char(fermenter_id);

    sys=mdlDerivatives(t,x,u, plant, substrate, substrate_network, ...
      sensors, fermenter_id);%, deltatime);

  %% 
  % Update
  %
  case 2,
    sys=mdlUpdate(t,x,u);

  %% 
  % Outputs
  %
  case 3,
            
    fermenter_id= char(fermenter_id);

    sys=mdlOutputs(t,x,u, sensors, fermenter_id, plant, ...
                   substrate, substrate_network, plant_network);

  %% 
  % GetTimeOfNextVarHit
  %
  case 4,
    sys=mdlGetTimeOfNextVarHit(t,x,u);

  %% 
  % Terminate
  %
  case 9,
      
    fermenter_id= char(fermenter_id);

    if iscell(initstate_type)
        initstate_type= initstate_type{:};
    end

    if iscell(datasource_type)
        datasource_type= datasource_type{:};
    end

    sys=mdlTerminate(t,x,u, plant, fermenter_id, datasource_type, ...
                     initstate_type, savestate);

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
    mdlInitializeSizes(plant, fermenter_id, initstate_type, datasource_type)

% call simsizes for a sizes structure, fill it in and convert it to a
% sizes array.
%
sizes = simsizes;

sizes.NumContStates  = biogas.ADMstate.dim_state;
sizes.NumDiscStates  = 0;
% output the 1st 33 states, Qout (1), Qgas (3), initial variables (64)
sizes.NumOutputs     = biogas.ADMstate.dim_stream + biogas.BioGas.n_gases;% + 64;
sizes.NumInputs      = biogas.ADMstate.dim_stream;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;   % at least one sample time is needed

sys = simsizes(sizes);

%%

accesstofile= get_accesstofile_from_datasource_type(datasource_type);

%%

initstate= get_initstate_from(char(plant.id), accesstofile);

if isempty(initstate)
  error('Error loading initstate for ADM1 model!');
end

%%

x0= initstate.fermenter.(fermenter_id).(initstate_type);

if x0(biogas.ADMstate.pos_pTOTAL, 1) == 0
  % initialize pTOTAL always with 1.0
  x0(biogas.ADMstate.pos_pTOTAL, 1)= 1.0;
end

%%
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



%% 
% mdlDerivatives
%
% Return the derivatives for the continuous states.
%
function sys=mdlDerivatives(t,x,u, plant, substrate, substrate_network, ...
                            sensors, fermenter_id)

%%

%sys= calcADM1Deriv(t, x, u, fermenter_id, plant, substrate, substrate_network, sensors);

% x(19)= max(x(19),0);       % Xfa
% x(21)= max(x(21),0);       % Xpro
% x(22)= max(x(22),0);       % Xac
% x(32)= max(x(32),0);       % Shco3
% x(33)= max(x(33),0);       % Snh3


x_net= NET.convertArray(x, 'System.Double', numel(x));
u_net= NET.convertArray(u, 'System.Double', numel(u));
sub_net= NET.convertArray(substrate_network, 'System.Double', size(substrate_network));

try
  sys= biogas.ADMstate.calc_xdot(t, x_net, u_net, fermenter_id, plant, ...
                               substrate, sub_net, sensors);
catch ME
  rethrow(ME);
end

sys= double(sys)';

%% 
% constraint
%
% wenn x == 0, dann setze xdot auf null, allerdings nur für die betreffende
% Zustandsvektorkomponente.
%
%sys= sys - ( ( x <= 0 ) & ( sys < 0 ) ) .* sys; 



      
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
function sys=mdlOutputs(t,x,u, sensors, fermenter_id, plant, ...
                   substrate, substrate_network, plant_network)

%%
%

u_net= NET.convertArray(u, 'System.Double', numel(u));
x_net= NET.convertArray(x, 'System.Double', numel(x));

mysubsnet= NET.convertArray(substrate_network, 'System.Double', size(substrate_network));
myplannet= NET.convertArray(plant_network, 'System.Double', size(plant_network));

%%

sys= biogas.ADMstate.getADM1output(t, x_net, u_net, fermenter_id, ...
          sensors, plant, substrate, mysubsnet, myplannet);
        
sys= double(sys)';



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
function sys=mdlTerminate(t,x,u, plant, fermenter_id, datasource_type, ...
                          initstate_type, savestate)

%%
% save state? 1 == yes, elso no
if savestate == 1
    
  %%
  
  accesstofile= get_accesstofile_from_datasource_type(datasource_type);

  %%

  initstate= get_initstate_from(char(plant.id), accesstofile);

  %%
  
  if strcmp(initstate_type, 'default')

    % don't overwrite the default state
    initstate.fermenter.(fermenter_id).('user')= x;

  else

    initstate.fermenter.(fermenter_id).(initstate_type)= x;

  end
  
  %%
  
  save_initstate_to(initstate, char(plant.id), accesstofile);

end

sys = [];

%%


