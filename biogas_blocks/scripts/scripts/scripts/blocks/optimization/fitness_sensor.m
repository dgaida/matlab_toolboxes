%% fitness_sensor
% Measure fitness of a simulation
%
function [sys,x0,str,ts]= ...,simStateCompliance] = 
    fitness_sensor(t,x,u,flag, sensors, plant, substrate, fitness_params)
%% Release: 1.3

switch flag,

  %% 
  % Initialization
  %
  case 0,
    
    %%
    % check arguments
    
    is_sensors(sensors, 5);
    is_plant(plant, 6);
    is_substrate(substrate, 7);
    is_fitness_params(fitness_params, 8);
    
    [sys,x0,str,ts]= ...,simStateCompliance]=
          mdlInitializeSizes(sensors, plant, fitness_params);

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
     
    sys=mdlOutputs(t, sensors, plant, substrate, fitness_params);

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
function [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes(sensors, plant, fitness_params)
%
% call simsizes for a sizes structure, fill it in and convert it to a
% sizes array.
%
sizes = simsizes;

%path2xml= get_path2xml_configfile(char(plant.id), 'fitness_params_%s.xml');
%fitness_params2= biooptim.fitness_params(path2xml);

sizes.NumContStates  = 0;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = double(fitness_params.nObjectives);   % number of objectives;
sizes.NumInputs      = 1;
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
%    'UnknownSimState', < The default setting; warn and assume DefaultSimState
%    'DefaultSimState', < Same sim state as a built-in block
%    'HasNoSimState',   < No sim state
%    'DisallowSimState' < Error out when saving or restoring the model sim state
simStateCompliance = 'UnknownSimState';


%%

for iel= 1:fitness_params.mySetpoints.Count

  myset= fitness_params.mySetpoints.get(iel - 1);

  if ~strcmp(char(myset.s_operator), '')
    % collection of sensors, all chps, all digesters, ...
    sensor_id= sprintf('%s_%i', char(myset.sensor_id), myset.index);
  else % one sensor
    sensor_id= sprintf('%s_%s_%i', char(myset.sensor_id), char(myset.location), myset.index);
  end
  
  %%
  % reference values
  ref_vals= load_file(sprintf('ref_%s.mat', sensor_id));
    
  %%
  
  try
    sensors.addSensor(biogas.ref_sensor(sensor_id));
    
    sensors.measureVecStream( ... 
      NET.convertArray( ref_vals(1,:), 'System.Double', ...
                        numel(ref_vals(1,:)) ), ...
      sprintf('ref_%s', sensor_id), ...
      NET.convertArray( ref_vals(2,:), 'System.Double', ...
                        size(ref_vals(2,:)) ) );
  catch ME
    disp(ME.message)
    rethrow(ME);
  end
  
end

%%

%%
% reference values for sold energy, should be there, when we control
% methane setpoint, because then not all produced energy can be sold
% das ist eher für direktvermarktung, wo eine bestimmte menge an energie
% nur abgenommen wird. und zwar die hier angegebene. wird in C# abgefragt
% ob dieser sensor exisitiert (objectives.cs)
% wenn der sensor nicht existiert wird angenommen, dass die gesamte
% produzierte energie verkauft wird.

if exist('ref_energy_sold.mat', 'file')
  
  %%
  
  ref_vals= load_file('ref_energy_sold.mat');

  %%

  try
    sensors.addSensor(biogas.ref_sensor('energy_sold'));

    sensors.measureVecStream( ... 
      NET.convertArray( ref_vals(1,:), 'System.Double', ...
                        numel(ref_vals(1,:)) ), ...
      'ref_energy_sold', ...
      NET.convertArray( ref_vals(2,:), 'System.Double', ...
                        size(ref_vals(2,:)) ) );
  catch ME
    disp(ME.message)
    rethrow(ME);
  end
  
  %%
  
end



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
function sys=mdlOutputs(t, sensors, plant, substrate, fitness_params)

%%

fitness_function= str2func(char(fitness_params.fitness_function));

%%

if (t == 0) || ( t >= sensors.getCurrentTime('fitness') + double(sensors.sampling_time) )

  try
    
    %%
    % letzte parameter 0 wird nicht genutzt
    sensors.measure_optim_params(t, plant, fitness_params, substrate, 0);
    
    %%
    % ich bestimme fitness nach obigem aufruf, da fitness von allen
    % kleineren fitness sensoren abhängt, sonst würde fitness werte der
    % letzten iteration genommen
    % wenn das nicht interessiert, könnte fitness auch vorher gemessen
    % werden und dann als letzten parameter übergeben werden, dann spart
    % man sich das measure hier unten
    
    fitness= feval( fitness_function, plant, ...
                    substrate, fitness_params );
                  
    % kann passieren, wenn Simulation fehl schlägt, gibt NaN zurück und
    % nicht 2dim NaN
    if numel(fitness) ~= fitness_params.nObjectives
      fitness= repmat(fitness, fitness_params.nObjectives, 1);
    end
    
    sensors.measure(t, 'fitness', fitness);   
    
    %%
    
  catch ME
    disp(ME.message);
    disp(['Error in: ', fullfile(ME.stack(1,1).file, ME.stack(1,1).name), ...
         ': line: ', num2str(ME.stack(1,1).line)]);
    disp(ME.stack);
    
    disp(get_stack_trace(ME));
    
    rethrow(ME);
  end

else

  if (fitness_params.nObjectives == 1)
    fitness= sensors.getCurrentMeasurementD('fitness');
  else
    fitness_vec= sensors.getCurrentMeasurementVector('fitness');
    
    fitness= zeros(fitness_params.nObjectives, 1);
    %double(fitness_vec);%zeros(fitness_params.nObjectives, 1);
    
    for ival= 1:fitness_params.nObjectives
      fitness(ival)= fitness_vec.Get(ival - 1).Value;
    end
  end
  
end


%%
% for multiobjective optimization make a column vector
sys = fitness(:);


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


