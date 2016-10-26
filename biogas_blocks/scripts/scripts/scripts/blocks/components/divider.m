%% divider
% Divide the ADM1 stream in |n_outputs| ADM1 streams.
%
function [sys,x0,str,ts]= ...,simStateCompliance]= 
                  divider(t,x,u,flag, n_outputs, splitVector)
%% Release: 1.3

switch flag,

  %% 
  % Initialization
  %
  case 0,
      
      [sys,x0,str,ts]= ...,simStateCompliance]=
          mdlInitializeSizes(n_outputs);

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
      
    sys=mdlOutputs(t,x,u, n_outputs, splitVector);

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
function [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes(n_outputs)
%
% call simsizes for a sizes structure, fill it in and convert it to a
% sizes array.

sizes = simsizes;

sizes.NumContStates  = 0;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = n_outputs * biogas.ADMstate.dim_stream;
sizes.NumInputs      = biogas.ADMstate.dim_stream;
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
% mdlDerivatives
%
% Return the derivatives for the continuous states.
%
function sys= mdlDerivatives(t,x,u)

sys = [];


%% 
% mdlUpdate
%
% Handle discrete state updates, sample time hits, and major time step
% requirements.
%
function sys= mdlUpdate(t,x,u)

sys = [];


%%
% mdlOutputs
%
% Return the block outputs.
%
function sys= mdlOutputs(t,x,u, n_outputs, splitVector)

%% TODO
% in c# implementieren

splitVector= reshape(splitVector, max(size(splitVector)), 1 );

if size(splitVector,1) ~= n_outputs
 error('size(splitVector,1) ~= n_outputs : %i ~= %i', ...
        size(splitVector,1), n_outputs); 
end

if (sum(splitVector) ~= 0)
  splitVector= splitVector ./ sum(splitVector);
else
  error('The 1-norm of the stream split Vector is zero. It has to be > 0.');
end

% Vector (n_outputs, 1)
q_splitted= u(biogas.ADMstate.pos_Q) .* splitVector;

stream(1:n_outputs * biogas.ADMstate.dim_stream, 1)= 0;

for istream= 1:n_outputs

  stream(1 + (istream - 1) * biogas.ADMstate.dim_stream: ...
              istream      * biogas.ADMstate.dim_stream, 1) = ...
                        [u(1:biogas.ADMstate.dim_stream - 1); q_splitted(istream,1)];
        
end

sys= stream;


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


