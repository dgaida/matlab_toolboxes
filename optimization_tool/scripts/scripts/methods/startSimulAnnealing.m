%% startSimulAnnealing
% Prepare and start <matlab:doc('simulannealbnd') simulated annealing>
% algorithm to minimize given objective function. 
%
function [u, varargout]= startSimulAnnealing(ObjectiveFunction, u0, varargin)
%% Release: 1.8

%%

error( nargchk(2, 7, nargin, 'struct') );
error( nargoutchk(0, 4, nargout, 'struct') );

%% 
% read out varargin

if nargin >= 3, LB=        varargin{1}; else LB=        []; end
if nargin >= 4, UB=        varargin{2}; else UB=        []; end

%%
% params are checked in setSimulAnnealingOptions
if nargin >= 5, maxIter=   varargin{3}; else maxIter=   []; end
if nargin >= 6, timelimit= varargin{4}; else timelimit= []; end
if nargin >= 7, tolerance= varargin{5}; else tolerance= []; end

%%
% check params

checkArgument(ObjectiveFunction, 'ObjectiveFunction', 'function_handle', '1st');
checkArgument(u0, 'u0', 'double', '2nd');
checkArgument(LB, 'LB', 'double', '3rd');
checkArgument(UB, 'UB', 'double', '4th');

%%

LB= LB(:)';
UB= UB(:)';

if numel(LB) ~= numel(UB)
  error('LB and UB must be of the same size: %i ~= %i!', ...
        numel(LB), numel(UB));
end


%%
% set options

options= setSimulAnnealingOptions(maxIter, timelimit, tolerance);
        
%%
%

if isempty(u0)
  u0= LB + (UB - LB) ./ 2;
end


%% 
% start Simulated Annealing

if exist('simulannealbnd', 'file') == 2
  [u,fitness,exitflag,output]= simulannealbnd(ObjectiveFunction, u0, ...
                                              LB, UB, options);
else
  errordlg('Genetic Algorithm and Direct Search Toolbox not installed!');
  error('Genetic Algorithm and Direct Search Toolbox not installed!');
end

%%

if nargout >= 2
  varargout{1}= fitness;
end
if nargout >= 3
  varargout{2}= exitflag;
end
if nargout >= 4
  varargout{3}= output;
end

%%


