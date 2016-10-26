%% createADMstreamMix
% Create the 'daily hydrograph' for a biogas plant.
%
function [sys,x0,str,ts]= ...,simStateCompliance] = ...
  createADMstreamMix(t,x,u,flag, volumeflow_type, substrate_network, ...
                            substrate, sensors, plant, datasource_type)
%% Release: 1.0

switch flag,

  %% 
  % Initialization
  %
  case 0,
      
%     if iscell(substrate_name)
%         substrate_name= substrate_name{:};
%     end

    % when substrate_name is a char, this is much faster then checking
    % using iscell! If substrate_name is a cell, then command above is
    % minimal faster then this here, but not really. So in total this is
    % a lot faster!
    %substrate_name= char(substrate_name);

    volumeflow_type= char(volumeflow_type);
    datasource_type= char(datasource_type);
    
    [sys,x0,str,ts]= ...,simStateCompliance]= ...
         mdlInitializeSizes(volumeflow_type, substrate, plant, ...
                            datasource_type, sensors);

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
      
    %substrate_name= char(substrate_name);
    datasource_type= char(datasource_type);
      
    sys=mdlOutputs(t,x,u, substrate_network, plant, substrate, sensors, datasource_type);

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
    mdlInitializeSizes(volumeflow_type, substrate, plant, datasource_type, sensors)
%
% call simsizes for a sizes structure, fill it in and convert it to a
% sizes array.
%
sizes = simsizes;

sizes.NumContStates  = 0;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = plant.getNumDigestersD() * biogas.ADMstate.dim_stream;
% dilution rates for each digester, or -1 for each digester
sizes.NumInputs      = plant.getNumDigestersD();   % TODO wenn datasource_type == extern, dann
% == anzahl der substrate
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


%%

for isubstrate= 1:substrate.getNumSubstratesD()
  
  %%
  
  substrate_name= char( substrate.getID(isubstrate) );

  %%
  
  if isempty(substrate_name)
    warning('createdailyhydrograph_mat:mdlInitializeSizes', 'substrate_name is empty!');
    return;
  end

  %%

  try
    [q_substrate, t_q]= ...
           create_volumeflow_from_source(substrate_name, volumeflow_type, ...
                                         datasource_type);
  catch ME
    disp(ME.message)
    rethrow(ME);
  end

  %%

  sensors= write_volumeflow_in_sensors(sensors, t_q.(substrate_name), ...
                            q_substrate.(substrate_name), substrate_name);
  
  %%



  %% TODO
  % hole alle veränderlichen substrateigenshaften aus dateien und speichere
  % die streams in plant_model. unten in outputs werden diese dann für die
  % aktuelle zeit in substrate gespeichert.

  % try
  %     
  %     plant_model.set_CSB_NH4_substrate(substrate_name, volumeflow_type, datasource_type);
  %     
  % catch ME
  %    
  %     
  %     
  % end

  try
    [params_substrate, t_q]= ...
           create_substrateparams_from_source(substrate_name, volumeflow_type, ...
                                              datasource_type);
  catch ME
    disp(ME.message)
    rethrow(ME);
  end

  %%

  if ~isempty(params_substrate)

    try
      sensors.measureVecStream( ... 
        NET.convertArray( t_q.(substrate_name), 'System.Double', ...
                          numel(t_q.(substrate_name))), ...
        ['substrateparams_', substrate_name], ...
        NET.convertArray( params_substrate.(substrate_name)', 'System.Double', ...
                          size(params_substrate.(substrate_name)') ) );
    catch ME
      disp(ME.message)
      rethrow(ME);
    end

  end
  
end


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
function sys=mdlOutputs(t,x,u, substrate_network, plant, substrate, sensors, datasource_type)

%%

mysubsnet= NET.convertArray(substrate_network, 'System.Double', size(substrate_network));

try
  %% TODO
  % extern modus implementieren
  if ~strcmp(datasource_type, 'extern')

    %Qin= getCurrentVolumeFlow(t, substrate_name);
    %Qin= sensors.getMeasurementAt('Q', ['Q_', substrate_name], t);
    
    % dilution rate for each digester, vector with as many rows as there
    % are digesters. if not needed, then set to -1. 
    unet= NET.convertArray(u, 'System.Double');

    y_adm1xpN= biogas.ADMstate.calc_measureADMstreamMix(t, substrate, plant, ...
      mysubsnet, sensors, unet);
    
  else
    
    %% TODO
    Qin= u;   % u should be an array
    
    Qin= NET.convertArray(Qin, 'System.Double', size(Qin));
    
    %% TODO: calc_measureADMstreamMix nutzen, vorher in c# implementieren
    y_adm1xpN= biogas.ADMstate.calcADMstreamMix(t, substrate, plant, mysubsnet, sensors, Qin);
    
  end
catch ME
  disp(ME.message);
  rethrow(ME);
end

%%

% if numel(Qin) ~= 1 || imag(Qin) ~= 0 || isnan(Qin)
%   warning('Qin:dimensionError', 'Qin has %i elements!', numel(Qin));
%   disp(Qin);
%   disp(substrate_name);
%   disp(t);
% end

y_adm1xpN= double(y_adm1xpN)';

%% TODO
% TEST

% if ~(Qin > 0)
%   disp(Qin);
% end


%%
%
sys = y_adm1xpN;


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


