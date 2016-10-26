%% setPatternSearchOptions
% Set options for the <matlab:doc('patternsearch') patternsearch>
% Algorithm. 
%
function options= setPatternSearchOptions(varargin)
%% Release: 1.9

%%

error( nargchk(0, 4, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% readout varargin

if nargin >= 1, maxIter=      varargin{1}; else maxIter=      []; end
if nargin >= 2, timelimit=    varargin{2}; else timelimit=    []; end
if nargin >= 3, tolerance=    varargin{3}; else tolerance=    []; end
if nargin >= 4, searchMethod= varargin{4}; else searchMethod= []; end

%%
% check arguments

if ~isempty(maxIter)
  validateattributes(maxIter, {'double'}, ...
                     {'scalar', 'positive', 'integer'}, ...
                     mfilename, 'maxIter', 1);
end

checkArgument(timelimit, 'timelimit', 'double', '2nd');
checkArgument(tolerance, 'tolerance', 'double', '3rd');
checkArgument(searchMethod, 'searchMethod', 'function_handle', '4th', 'on');


%%

if exist('psoptimset', 'file') == 2
  options= psoptimset('PlotFcns', {@psplotbestf , @psplotbestx}, ...
                      ...%'Display', 'iter', ...
                      'UseParallel', 'always');
else
  errordlg('Genetic Algorithm and Direct Search Toolbox not installed!');
  error('Genetic Algorithm and Direct Search Toolbox not installed!');
end

%%

if isa(maxIter, 'double') 
  options= psoptimset(options, 'MaxIter', maxIter);
end

if isa(timelimit, 'double')
  options= psoptimset(options, 'TimeLimit', timelimit);
end

if isa(tolerance, 'double')
  options= psoptimset(options, 'TolFun', tolerance); 
end

if isa(searchMethod, 'function_handle')
  options= psoptimset(options, 'SearchMethod', searchMethod);
end

%%


