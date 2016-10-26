%% hydraulic_delay
% Implements an hydraulic delay as Simulink Model. 
%
function [sys,x0,str,ts]= ...,simStateCompliance]= ...
                            hydraulic_delay(t,x,u,flag, varargin)
%% Release: 1.1

%%
% read varargin

if nargin >= 5, DEBUG= varargin{1}; else DEBUG= []; end;
if nargin >= 6, plant= varargin{2}; else plant= []; end;
if nargin >= 7
    fermenter_name_start= char(varargin{3}); 
else
    fermenter_name_start= []; 
end
if nargin >= 8
    fermenter_name_destiny= char(varargin{4}); 
else
    fermenter_name_destiny= []; 
end
if nargin >= 9
    initstate_type= char(varargin{5}); 
else
    initstate_type= 'default'; 
end
if nargin >= 10
    datasource_type= char(varargin{6});
else
    datasource_type= []; 
end
if nargin >= 11, savestate= varargin{7}; else savestate= 0; end;
if nargin >= 12, time_constant= varargin{8}; else time_constant= 0.1; end;
if nargin >= 13, V_min= varargin{9}; else V_min= 100; end;


%%

switch flag,
    
  %% 
  % Initialization
  %
  case 0,
    [sys,x0,str,ts]= ...,simStateCompliance]=
        mdlInitializeSizes(plant, ...
            initstate_type, datasource_type, ...
            fermenter_name_start, fermenter_name_destiny, V_min);

  %% 
  % Derivatives
  %
  case 1,
    sys=mdlDerivatives(t,x,u, time_constant, V_min);

  %% 
  % Update
  %
  case 2,
    sys=mdlUpdate(t,x,u);

  %% 
  % Outputs
  %
  case 3,
    sys=mdlOutputs(t,x,u, DEBUG, time_constant, V_min);

  %% 
  % GetTimeOfNextVarHit
  %
  case 4,
    sys=mdlGetTimeOfNextVarHit(t,x,u);

  %% 
  % Terminate
  %
  case 9,
    sys=mdlTerminate(t,x,u, plant, fermenter_name_start, ...
            fermenter_name_destiny, datasource_type, ...
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
function [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes(plant, ...
          initstate_type, datasource_type, fermenter_name_start, ...
          fermenter_name_destiny, V_min)
%
% call simsizes for a sizes structure, fill it in and convert it to a
% sizes array.

sizes = simsizes;

sizes.NumContStates  = biogas.ADMstate.dim_stream;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = biogas.ADMstate.dim_stream;
sizes.NumInputs      = biogas.ADMstate.dim_stream;
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 1;   % at least one sample time is needed

sys = simsizes(sizes);

%
% initialize the initial conditions
%
%x0  = [];

%%

accesstofile= get_accesstofile_from_datasource_type(datasource_type);

%%

initstate= get_initstate_from(char(plant.id), accesstofile);

if isempty(initstate)
  error('Error loading initstate for hydraulic_delay model!');
end

%%

if ~isempty(datasource_type)
    x0= initstate.hydraulic_delay.([fermenter_name_start, '_', ...
                    fermenter_name_destiny]).(initstate_type);
else
    x0= biogas.ADMstate.getDefaultADMstate(biogas.ADMstate.dim_stream);
end

if strcmp(initstate_type, 'random') || strcmp(initstate_type, 'default')
    % Das Becken ist gefüllt
    x0(biogas.ADMstate.pos_Q, 1)= V_min;
end

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
%ts  = [0 1]; das geht bei dem block nicht: 
% must have a continuous sample time since there are continuous states

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
function sys=mdlDerivatives(t,x,u, time_constant, V_min)

qin= u(biogas.ADMstate.pos_Q, 1);
V=   x(biogas.ADMstate.pos_Q, 1);

%%
% Ablauf
%
% Laut Simba Doku 'PDF Tutorial S. ?' wird $q_{out}(t)$ berechnet über
%
% $$q_out(t)= \frac{V(t) - V_{min}}{A_{BB}} \cdot B_{BB} \cdot K_{AB}$$
%
% wobei die Konstanten zusammen gefasst werden können und der Einheit nach
% eine Zeit bilden: 
%
% $$time\_constant = \frac{ A_{BB} }{ B_{BB} \cdot K_{AB} }$$
%
if time_constant ~= 0
    qout= max(( V - V_min ) / time_constant, 0);
else
    error(['Trying to divide by time_constant, which is 0. ', ...
           'The time constant must be greater 0.']);
end

%%
% ideal durchmischter Tank, bei dem 2. Ausdruck müsste eigentlich qout
% anstatt qin stehen, aber da angenommen wird, dass das Becken immer
% randvoll ist, macht das dann keinen Unterschied mehr, bei nicht vollem
% Becken natürlich schon (habe es so wie simba gemacht...)
%
% eigentlich korrekte Formel:
%
% $$S'(t)= \frac{q_{in}(t)}{V(t)} \cdot S_{in}(t) - \frac{q_{out}(t)}{V(t)}
% \cdot S(t)$$ 
%
% Simba:
%
% $$S'(t)= \frac{q_{in}(t)}{V(t)} \cdot S_{in}(t) - \frac{q_{in}(t)}{V(t)}
% \cdot S(t)$$
%
if V ~= 0
    sys(1:biogas.ADMstate.dim_stream - 1, 1)= ...
      qin / V .* u(1:biogas.ADMstate.dim_stream - 1,1) - ...
      qin / V .* x(1:biogas.ADMstate.dim_stream - 1,1);
else
    error(['Trying to divide by V, which is 0. ', ...
           'The volume must be greater 0.']);
end

%% 
% Volumenänderung
%
% $$V'(t) = q_{in}(t) - q_{out}(t)$$
%
sys(biogas.ADMstate.pos_Q, 1)= qin - qout;



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
function sys=mdlOutputs(t,x,u, DEBUG, time_constant, V_min)

%%
%

V= x(biogas.ADMstate.pos_Q, 1);

% Ablauf

if time_constant ~= 0
    qout= max(( V - V_min ) / time_constant, 0);
else
    error(['Trying to divide by time_constant, which is 0. ', ...
           'The time constant must be greater 0.']);
end

%%
%
% $$\vec{y}(t) := \left( Konzentrationen, q_{out}(t)
% \right)^T$$
%
sys = [ x(1:biogas.ADMstate.dim_stream - 1, 1); qout ]';



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
function sys=mdlTerminate(t,x,u, plant, fermenter_name_start, ...
                          fermenter_name_destiny, ...
                          datasource_type, initstate_type, savestate)

% save the state? 1 == yes, elso no
if savestate == 1
    
  %%
  
  accesstofile= get_accesstofile_from_datasource_type(datasource_type);

  %%
  
  initstate= get_initstate_from(char(plant.id), accesstofile);

  %%
  
  if strcmp(initstate_type, 'default')

      % don't overwrite the default state
      initstate.hydraulic_delay.([fermenter_name_start, '_', ...
          fermenter_name_destiny]).('user')= x;

  else

      initstate.hydraulic_delay.([fermenter_name_start, '_', ... 
          fermenter_name_destiny]).(initstate_type)= x;

  end

  %%
  
  save_initstate_to(initstate, char(plant.id), accesstofile);

  %%

end

sys = [];

%%


