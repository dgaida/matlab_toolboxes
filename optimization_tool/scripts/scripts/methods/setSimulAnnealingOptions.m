%% setSimulAnnealingOptions
% Set options for the <matlab:doc('simulannealbnd') simulannealbnd>
% Algorithm. 
%
function options= setSimulAnnealingOptions(varargin)
%% Release: 1.9

%%

error( nargchk(0, 3, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% readout varargin

if nargin >= 1, maxIter=   varargin{1}; else maxIter=   []; end
if nargin >= 2, timelimit= varargin{2}; else timelimit= []; end
if nargin >= 3, tolerance= varargin{3}; else tolerance= []; end

%%
% check arguments

if ~isempty(maxIter)
  validateattributes(maxIter, {'double'}, ...
                     {'scalar', 'positive', 'integer'}, ...
                     mfilename, 'maxIter', 1);
end

checkArgument(timelimit, 'timelimit', 'double', '2nd');
checkArgument(tolerance, 'tolerance', 'double', '3rd');


%%
if exist('saoptimset', 'file') == 2

  options= saoptimset('PlotFcns', {@saplotbestf , @saplotbestx}, ..., ...
                       ...%'Display', 'iter', ...
                      'ObjectiveLimit', -Inf);

else
  errordlg('Genetic Algorithm and Direct Search Toolbox not installed!');
  error('Genetic Algorithm and Direct Search Toolbox not installed!');
end

%%

if isa(maxIter, 'double') 
  options= saoptimset(options, 'MaxIter', maxIter);
end

if isa(timelimit, 'double')
  options= saoptimset(options, 'TimeLimit', timelimit);
end

if isa(tolerance, 'double')
  options= saoptimset(options, 'TolFun', tolerance); 
end

%%


