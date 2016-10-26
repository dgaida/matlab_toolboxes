%% startFMinCon
% Prepare and start <matlab:doc('fmincon') fmincon> to minimize objective
% function
%
function [u, varargout]= startFMinCon(ObjectiveFunction, u0, varargin)
%% Release: 1.7

%%

error( nargchk(2, 14, nargin, 'struct') );
error( nargoutchk(0, 4, nargout, 'struct') );

%%
% check parameters

checkArgument(ObjectiveFunction, 'ObjectiveFunction', 'function_handle', '1st');

%% 
% read out varargin

if nargin >= 3, 
  LB= varargin{1}; 
  
  checkArgument(LB, 'LB', 'double', '3rd');
else
  LB= [];
end

if nargin >= 4, 
  UB= varargin{2}; 
  
  checkArgument(UB, 'UB', 'double', '4th');
else
  UB= []; 
end

if numel(LB) ~= numel(UB)
  error('LB and UB must be of the same size: %i ~= %i!', ...
        numel(LB), numel(UB));
end

%%
% params are checked in setFMinOptions
if nargin >= 5, noGenerations= varargin{3}; else noGenerations= []; end
if nargin >= 6, timelimit= varargin{4}; else timelimit= []; end
if nargin >= 7, tolerance= varargin{5}; else tolerance= []; end

if nargin >= 8, A= varargin{6}; else A= []; end
if nargin >= 9, b= varargin{7}; else b= []; end
if nargin >= 10, Aeq= varargin{8}; else Aeq= []; end
if nargin >= 11, beq= varargin{9}; else beq= []; end

checkArgument(A, 'A', 'double', '8th');
isRn(b, 'b', 9);
checkArgument(Aeq, 'Aeq', 'double', '10th');
isRn(beq, 'beq', 11);

if nargin >= 12 && ~isempty(varargin{10}),
  parallel= varargin{10};
  
  validatestring(parallel, {'none', 'multicore', 'cluster'}, ...
                 mfilename, 'parallel', 12);
else
  parallel= 'none'; 
end

if nargin >= 13 && ~isempty(varargin{11}), 
  nWorker= varargin{11}; 
  
  isN(nWorker, 'nWorker', 13);
else
  nWorker= 2;
end

% param is checked in setFMinOptions
if nargin >= 14, OutputFcn= varargin{12}; else OutputFcn= []; end



%%
% set options

options= setFMinOptions(noGenerations, timelimit, tolerance, OutputFcn);


%% 
% open worker pool

[parallel]= setParallelConfiguration('open', parallel, nWorker);

                 
%% 
% start GA

if exist('fmincon', 'file') == 2
    
  [u, fitness, exitflag, output]= ...
    fmincon(ObjectiveFunction, u0, A, b, Aeq, beq, LB, UB, [], options);

else
  errordlg('Optimization Toolbox not installed!');
  error('Optimization Toolbox not installed!');
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
% close worker pool

setParallelConfiguration('close', parallel);


%%


