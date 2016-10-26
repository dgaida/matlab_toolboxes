%% setGAOptions
% Set options for the <matlab:doc('ga') ga> Algorithm.
%
function options= setGAOptions(varargin)
%% Release: 1.9

%%

error( nargchk(0, 6, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% readout varargin

if nargin >= 1, u0=            varargin{1}; else u0=            []; end
if nargin >= 2, popSize=       varargin{2}; else popSize=       []; end
if nargin >= 3, noGenerations= varargin{3}; else noGenerations= []; end
if nargin >= 4, timelimit=     varargin{4}; else timelimit=     []; end
if nargin >= 5, tolerance=     varargin{5}; else tolerance=     []; end
if nargin >= 6, OutputFcn=     varargin{6}; else OutputFcn=     []; end


%%
% check arguments

checkArgument(u0, 'u0', 'double', '1st');

if ~isempty(popSize)
  validateattributes(popSize, {'double'}, {'scalar', 'positive', 'integer'}, ...
                     mfilename, 'popSize', 2);
end

if ~isempty(noGenerations)
  validateattributes(noGenerations, {'double'}, {'scalar', 'positive', 'integer'}, ...
                     mfilename, 'noGenerations', 3);
end

checkArgument(timelimit, 'timelimit', 'double', '4th');
checkArgument(tolerance, 'tolerance', 'double', '5th');
checkArgument(OutputFcn, 'OutputFcn', 'function_handle', '6th', 'on');


%%

if exist('gaoptimset', 'file') == 2
  options= gaoptimset('PlotFcns', {@gaplotbestf , @gaplotbestindiv}, ...
                      'Display', 'iter', ...
                      'UseParallel', 'always', ...
                      'FitnessLimit', -Inf);%, ...
                      %'HybridFcn', @fmincon);
else
  errordlg('Genetic Algorithm and Direct Search Toolbox not installed!');
  error('Genetic Algorithm and Direct Search Toolbox not installed!');
end

%%
% parameters with value [] indicate to use the default value for that
% parameter when options is passed to the optimization function 

if isa(u0, 'double')
  options= gaoptimset(options, 'InitialPopulation', u0); 
end

if isa(popSize, 'double')
  options= gaoptimset(options, 'PopulationSize', popSize); 
end

if isa(noGenerations, 'double')
  options= gaoptimset(options, 'Generations', noGenerations);
end

if isa(timelimit, 'double')
  options= gaoptimset(options, 'TimeLimit', timelimit);
end

if isa(tolerance, 'double')
  options= gaoptimset(options, 'TolFun', tolerance); 
end

if isa(OutputFcn, 'function_handle')
  options= gaoptimset(options, 'OutputFcns', OutputFcn); 
end

%%


