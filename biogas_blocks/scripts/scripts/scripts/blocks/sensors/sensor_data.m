%% sensor_data
% Get data out of the sensors object
%
function [sys,x0,str,ts]= ...,simStateCompliance]= 
                          sensor_data(t, x, u, flag, varargin)
%% Release: 1.0

%%
      
switch flag,

  %% 
  % Initialization
  %
  case 0,
    
    if nargin >= 10

      sensors=       varargin{1};   
      processvalue=  varargin{2};       % process value as char, sensor_id
      id_in_array=   varargin{3};       % id in sensor array, often ''
      index=         varargin{4};       % index in sensor
      noisy=         logical(varargin{5});       % true or false
      substrate=     varargin{6};
      
      %% TODO
      %
      % in gui liste hinzufügen, welche get_sensorlist anzeigt
      % mit 
      % dim= sensors.get_param_of_i(sel_value, 'dimension');
      % eine liste mit 0,1,...,dim-1 anzeigen, funktioniert vermutlich nicht
      % so einfach
      
      
      % only check arguments during initialization, because during
      % simulation it lasts too long
      is_sensors(sensors, 5);
      checkArgument(processvalue, 'processvalue', 'char', 6);
      checkArgument(id_in_array, 'id_in_array', 'char', 7);
      isN0(index, 'index', 8);
      checkArgument(noisy, 'noisy', 'logical', 9);
      is_substrate(substrate, 10);
      
    end
    
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
    sys=mdlOutputs(t,x,u, varargin{:});

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
% Return the sizes, initial conditions, and sample times for the
% S-function. 
%
function [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes()
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
sizes.NumOutputs     = 1;
sizes.NumInputs      = 1;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;   % at least one sample time is needed

sys = simsizes(sizes);

% initialize the initial conditions
x0  = [];

% str is always an empty matrix
str = [];

% initialize the array of sample times
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

sys= [];


%% 
% mdlUpdate
%
% Handle discrete state updates, sample time hits, and major time step
% requirements.
%
function sys=mdlUpdate(t,x,u)

sys= [];


%% 
% mdlOutputs
%
% Return the block outputs.
%
function sys=mdlOutputs(t,x,u, varargin)

%%
% read out varargin

value= 0;

if nargin >= 9

  % contains sensors, which are implemented in the model of the biogas
  % plant
  sensors=       varargin{1};   
  processvalue=  varargin{2};       % process value as char
  id_in_array=   varargin{3};       % id in array
  index=         varargin{4};       % index in sensor
  noisy=         logical(varargin{5});       % true or false
  substrate=     varargin{6};
  
  % then id_in_array is an operator
  if strcmp(id_in_array, 'mean') || strcmp(id_in_array, 'sum')
    value= sensors.getArrayMeasurementDAt(substrate, processvalue, ...
                                          id_in_array, t, index, noisy);
  else
    value= sensors.getMeasurementDAt(processvalue, id_in_array, t, index, noisy);
  end
  
elseif nargin ~= 3
  error('You may not call this function with %i arguments.', nargin);
end

%%
%
sys= value;


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


