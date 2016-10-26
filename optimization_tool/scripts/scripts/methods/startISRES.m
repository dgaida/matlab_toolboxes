%% startISRES
% Prepare and start ISRES "Improved" Evolution Strategy using Stochastic
% Ranking to minimize given fitnessfcn. 
%
function [u, varargout]= startISRES(fitnessfcn, LB, UB, varargin)
%% Release: 1.8

%%

error( nargchk(3, 8, nargin, 'struct') );
error( nargoutchk(0, 4, nargout, 'struct') );

%%
% check parameters

checkArgument(fitnessfcn, 'fitnessfcn', 'function_handle', '1st');

checkArgument(LB, 'LB', 'double', '2nd');
checkArgument(UB, 'UB', 'double', '3rd');

%% 
% read out varargin

if nargin >= 4, u0= varargin{1}; else u0= []; end

if nargin >= 5 && ~isempty(varargin{2})
  popSize= varargin{2};
  
  validateattributes(popSize, {'double'}, ...
                     {'scalar', 'positive', 'integer'}, ...
                     mfilename, 'popSize', 5);
else
  popSize= 7;
end

if nargin >= 6 && ~isempty(varargin{3})
  noGenerations= varargin{3};
  
  validateattributes(noGenerations, {'double'}, ...
                     {'scalar', 'positive', 'integer'}, ...
                     mfilename, 'noGenerations', 6);
else
  noGenerations= 4;
end

if nargin >= 7 && ~isempty(varargin{4}),
  parallel= varargin{4}; 
  
  validatestring(parallel, {'none', 'multicore', 'cluster'}, ...
                 mfilename, 'parallel', 7);
else
  parallel= 'none'; 
end

if nargin >= 8 && ~isempty(varargin{5}),
  nWorker= varargin{5}; 
  
  validateattributes(nWorker, {'double'}, {'scalar', 'positive', 'integer'}, ...
                     mfilename, 'nWorker', 8);
else
  nWorker= 2; 
end

%%

checkArgument(u0, 'u0', 'double', '4th');


%%
%

LB= LB(:)';
UB= UB(:)';

if numel(LB) ~= numel(UB)
  error('LB and UB must be of the same size: %i ~= %i!', ...
        numel(LB), numel(UB));
end


%%
% set options

mu= 1;
pf= 0.45;
varphi= 1;


%% 
% open worker pool

[parallel]= setParallelConfiguration('open', parallel, nWorker);

                 
%% 
% start ISRES
% m-file or p-file
if existMPfile('isres')
  [u, fitness, Gm, population]= ...
        isres(fitnessfcn, 'min', [LB;UB], popSize, noGenerations, ...
              mu, pf, varphi, u0);
else
  errordlg('The ISRES method is not installed!');
  error('The ISRES method is not installed!');
end

%%

if nargout >= 2
  varargout{1}= fitness(Gm,1);
end
if nargout >= 3
  varargout{2}= Gm;
end
if nargout >= 4
  varargout{3}= population;
end


%%
% close worker pool

setParallelConfiguration('close', parallel);

%%


