%% startPSO
% Prepare and start particle swarm optimization to minimize given
% ObjectiveFunction 
%
function [u, fitness, varargout]= startPSO(ObjectiveFunction, lenIndividual, varargin)
%% Release: 1.4

%%

error( nargchk(2, 11, nargin, 'struct') );
error( nargoutchk(0, 4, nargout, 'struct') );

%%
% check parameters

if ~isa(ObjectiveFunction, 'function_handle')
    ObjectiveFunction= @(x)default_function;
    warning('startPSO:objFunction', 'Set ObjectiveFunction to default_function!');
end


%% 
% read out varargin

if nargin >= 3, LB= varargin{1}; else LB= []; end
if nargin >= 4, UB= varargin{2}; else UB= []; end
if nargin >= 5, u0= varargin{3}; else u0= []; end

if nargin >= 6 && ~isempty(varargin{4}), 
  popSize= varargin{4}; 
else
  popSize= 30; 
end

if nargin >= 7, noGenerations= varargin{5}; else noGenerations= []; end
%% TODO
% timelimit not used yet
if nargin >= 8, timelimit= varargin{6}; else timelimit= []; end
% lowest error gradient tolerance
if nargin >= 9, tolerance= varargin{7}; else tolerance= []; end

if nargin >= 10 && ~isempty(varargin{8}), 
  parallel= varargin{8};
  
  validatestring(parallel, {'none', 'multicore', 'cluster'}, ...
                 mfilename, 'parallel', 10);
else
  parallel= 'none';
end

if nargin >= 11 && ~isempty(varargin{9}), 
  nWorker= varargin{9}; 
  
  isN(nWorker, 'nWorker', 11);
else
  nWorker= 2;
end

%%

checkArgument(LB, 'LB', 'double', '3rd');
checkArgument(UB, 'UB', 'double', '4th');
checkArgument(u0, 'u0', 'double', '5th');

isN(popSize, 'popSize', 6);

if ~isempty(noGenerations)
  isN(noGenerations, 'noGenerations', 7);
end

if ~isempty(timelimit)
  isR(timelimit, 'timelimit', 8);
end

if ~isempty(tolerance)
  isR(tolerance, 'tolerance', 9);
end

%%

LB= LB(:)';
UB= UB(:)';

if numel(LB) ~= numel(UB)
  error('LB and UB must be of the same size: %i ~= %i!', ...
        numel(LB), numel(UB));
end

%%
% set options

%alternative 1
plotfcn = 'goplotpso';
shw     = 1;   % how often to update display

%parameter determines if minimum (0) or maximum (1) is searched
minmax=0;

%max velocity divisor: 2 is a good choice
mvden = 2;

%parameter for the number of particles
ps    = popSize;

%parameter for different pso models:
%0) Common PSO - with inertia
%1) Trelea model 1
%2) Trelea model 2
%3) Clerc Type 1" - with constriction

modl  = 0;

%parameter for the searched errorgoal
errgoal=NaN;


varrange= [LB' UB'];

mv=( varrange(:,2) - varrange(:,1) ) ./ mvden;

% These two parameters are important! the first one has to something to do
% with the communication between the particles. each particle talks to ac
% further particles?
ac      = [2.1,2.1];% acceleration constants, only used for modl=0
% satisfaction of each particle in its solution in the beginning is high
% such that it stays at its position 0.9 and at the end its low 0.6 such
% that the particle follows the swarm
Iwt     = [0.9,0.6];  % intertia weights, only used for modl=0

% iterations it takes to go from Iwt(1) to Iwt(2), only for modl=0
wt_end  = 100; 
errgraditer=100; % max # of epochs without error change >= errgrad
% if=1 then can input particle starting positions, if= 0 then all random
%PSOseed = 0;    
PSOseed = 1;
% starting particle positions (first 20 at zero, just for an example)
if isempty(u0)
  PSOseedValue = lhSampling(ps, numel(LB), LB, UB); %zeros(ps-10, 1);
else
  PSOseedValue= u0;
end

psoparams=...
  [shw noGenerations ps ac(1) ac(2) Iwt(1) Iwt(2) ...
  wt_end tolerance errgraditer errgoal modl PSOseed];


%% 
% open worker pool

[parallel]= setParallelConfiguration('open', parallel, nWorker);


%%
% start PSO
% m-file or p-file
if existMPfile('pso_Trelea_vectorized')
    % vectorized version
  [optOut,te,tr]=pso_Trelea_vectorized(ObjectiveFunction, ...
    lenIndividual, mv, varrange, minmax, psoparams, plotfcn, PSOseedValue);
else
  error('PSO Toolbox not installed!');
end

%%

u= optOut(1:lenIndividual,1)';
fitness= optOut(end,1);

if nargout >= 3
  varargout{1}= te;
end

if nargout >= 4
  varargout{2}= tr;
end


%%
% close worker pool

setParallelConfiguration('close', parallel);

%%



%%
%
%
function fitness= default_function(u)

  fitness= 0;
    
%%


