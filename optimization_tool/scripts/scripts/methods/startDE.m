%% startDE
% Prepare and start Differential Evolution to minimize the given fitness
% function. 
%
function [u, varargout]= startDE(fitnessfcn, nvars, varargin)
%% Release: 1.9

%%

error( nargchk(2, 9, nargin, 'struct') );
error( nargoutchk(0, 4, nargout, 'struct') );

%%
% check parameters

checkArgument(fitnessfcn, 'fitnessfcn', 'function_handle', '1st');

validateattributes(nvars, {'double'}, ...
                   {'scalar', 'positive', 'integer'}, ...
                   mfilename, 'nvars', 2);

%% 
% read out varargin

if nargin >= 3, LB= varargin{1}; else LB= []; end
if nargin >= 4, UB= varargin{2}; else UB= []; end

checkArgument(LB, 'LB', 'double', '3rd');
checkArgument(UB, 'UB', 'double', '4th');

if numel(LB) ~= numel(UB)
  error('LB and UB must be of the same size: %i ~= %i!', ...
        numel(LB), numel(UB));
end

%%
%

if nargin >= 5, u0= varargin{3}; else u0= []; end

checkArgument(u0, 'u0', 'double', '5th');

if nargin >= 6 && ~isempty(varargin{4}), 
  popSize= varargin{4}; 
  
  validateattributes(popSize, {'double'}, ...
                     {'scalar', 'positive', 'integer'}, ...
                     mfilename, 'popSize', 6);
else
  popSize= 30;
end

%%
%

if nargin >= 7 && ~isempty(varargin{5}), 
  noGenerations= varargin{5}; 
  
  validateattributes(noGenerations, {'double'}, ...
                     {'scalar', 'positive', 'integer'}, ...
                     mfilename, 'noGenerations', 7);
else
  noGenerations= 20; 
end

%%
%

if nargin >= 8 && ~isempty(varargin{6}), 
  parallel= varargin{6}; 
  
  validatestring(parallel, {'none', 'multicore', 'cluster'}, ...
                 mfilename, 'parallel', 8);
else
  parallel= 'none';
end

    
%%
%

if nargin >= 9 && ~isempty(varargin{7}), 
  nWorker= varargin{7}; 
  
  validateattributes(nWorker, {'double'}, {'scalar', 'positive', 'integer'}, ...
                     mfilename, 'nWorker', 9);
else
  nWorker= 2; 
end


%%

LB= LB(:)';
UB= UB(:)';


%%
% set options

S_struct.I_NP         = popSize;
S_struct.F_weight     = 0.85;
S_struct.F_CR         = 0.5;%0.8
S_struct.I_D          = nvars;
S_struct.FVr_minbound = LB;
S_struct.FVr_maxbound = UB;
S_struct.I_bnd_constr = 1;
S_struct.I_itermax    = noGenerations;
S_struct.F_VTR        = -Inf;%0;
S_struct.I_strategy   = 3;
S_struct.I_refresh    = 1;
S_struct.I_plotting   = 0;


%% 
% open worker pool

[parallel]= setParallelConfiguration('open', parallel, nWorker);


%%
% start DE
% m-file or p-file
if existMPfile('deopt')
    [u, S_y, I_nf, population]= deopt(fitnessfcn, S_struct, u0);
else
    error('The DE Toolbox is not installed!');
end


%%

fitness= S_y.FVr_oa;

if nargout >= 2
  varargout{1}= fitness;
end

if nargout >= 3
  varargout{2}= I_nf;
end

if nargout >= 4
  varargout{3}= population;
end


%%
% close worker pool

setParallelConfiguration('close', parallel);

%%


