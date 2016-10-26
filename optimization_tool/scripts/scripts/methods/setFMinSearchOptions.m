%% setFMinSearchOptions
% Set options for the <matlab:doc('fminsearch') fminsearch> Algorithm.
%
function options= setFMinSearchOptions(varargin)
%% Release: 0.7

%%

error( nargchk(0, 3, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% readout varargin

if nargin >= 1, noGenerations= varargin{1}; else noGenerations= []; end
if nargin >= 3, tolerance=     varargin{3}; else tolerance=     []; end
if nargin >= 4, OutputFcn=     varargin{4}; else OutputFcn=     []; end

%%
% check arguments

if ~isempty(noGenerations)
  isN(noGenerations, 'noGenerations', 1);
end

checkArgument(tolerance, 'tolerance', 'double', '2nd');
checkArgument(OutputFcn, 'OutputFcn', 'function_handle', '3rd', 'on');


%%

if exist('optimset', 'file') == 2
  options= optimset('PlotFcns', {@optimplotx}, ...
                    'Display', 'iter');
else
  errordlg('Optimization Toolbox not installed!');
  error('Optimization Toolbox not installed!');
end

%%
% parameters with value [] indicate to use the default value for that
% parameter when options is passed to the optimization function 

if isa(noGenerations, 'double')
  % nicht MaxIter setzen, da je iter mehrere function evals gemacht werden.
  % in etwa 2 bei fminsearch
  options= optimset(options, 'MaxFunEvals', noGenerations);
end

if isa(tolerance, 'double')
  options= optimset(options, 'TolFun', tolerance); 
end

if isa(OutputFcn, 'function_handle')
  options= optimset(options, 'OutputFcn', OutputFcn); 
end

%%


