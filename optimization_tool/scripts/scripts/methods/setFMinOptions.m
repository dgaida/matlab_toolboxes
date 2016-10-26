%% setFMinOptions
% Set options for the <matlab:doc('fmincon') fmincon> Algorithm.
%
function options= setFMinOptions(varargin)
%% Release: 1.9

%%

error( nargchk(0, 4, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% readout varargin

if nargin >= 1, noGenerations= varargin{1}; else noGenerations= []; end
if nargin >= 2, timelimit=     varargin{2}; else timelimit=     []; end
if nargin >= 3, tolerance=     varargin{3}; else tolerance=     []; end
if nargin >= 4, OutputFcn=     varargin{4}; else OutputFcn=     []; end

%%
% check arguments

if ~isempty(noGenerations)
  isN(noGenerations, 'noGenerations', 1);
end

checkArgument(timelimit, 'timelimit', 'double', '2nd');
checkArgument(tolerance, 'tolerance', 'double', '3rd');
checkArgument(OutputFcn, 'OutputFcn', 'function_handle', '4th', 'on');


%%

if exist('optimset', 'file') == 2
  options= optimset('PlotFcns', {@optimplotx}, ...
                    'Display', 'iter', ...
                    'UseParallel', 'always', ...
                    'ObjectiveLimit', -Inf, ...
                    'Algorithm', 'interior-point');
else
  errordlg('Optimization Toolbox not installed!');
  error('Optimization Toolbox not installed!');
end

%%
% parameters with value [] indicate to use the default value for that
% parameter when options is passed to the optimization function 

if isa(noGenerations, 'double')
  % unterschied zu MaxIter möglich. je iter könnten mehrer fun evals
  % gemacht werden. ich will aber fun evals begrenzen
  options= optimset(options, 'MaxFunEvals', noGenerations);
end

if isa(timelimit, 'double')
  options= optimset(options, 'MaxTime', timelimit);
end

if isa(tolerance, 'double')
  options= optimset(options, 'TolFun', tolerance); 
end

if isa(OutputFcn, 'function_handle')
  options= optimset(options, 'OutputFcn', OutputFcn); 
end

% Warum sollte das?
%options= optimset(options, 'MaxFunEvals', 5);

%%


