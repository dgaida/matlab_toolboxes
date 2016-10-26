%% startSMSEMOA
% Prepare and start SMS-EMOA S-Metric Selection Evolutionary Multiobjective
% Optimization Algorithm to minimize the given fitness function. 
%
function [paretoset, varargout]= startSMSEMOA(fitnessfcn, nObj, u0, LB, UB, varargin)
%% Release: 1.3

%%

error( nargchk(5, 8, nargin, 'struct') );
error( nargoutchk(0, 3, nargout, 'struct') );

%%
% check parameters

checkArgument(fitnessfcn, 'fitnessfcn', 'function_handle', '1st');
isN(nObj, 'nObj', 2);

%%

LB= LB(:)';
UB= UB(:)';

if numel(LB) ~= numel(UB)
  error('LB and UB must be of the same size: %i ~= %i!', ...
        numel(LB), numel(UB));
end


%% 
% read out varargin

if nargin >= 6 && ~isempty(varargin{1})
  popSize= varargin{1}; 
  
  isN(popSize, 'popSize', 6);
else
  popSize= []; 
end

if nargin >= 7 && ~isempty(varargin{2})
  maxIter= varargin{2}; 
  
  isN(maxIter, 'maxIter', 7);
else
  maxIter= 4;
end


%%
% set options

if isempty(popSize)
  popSize= setPopSize(UB - LB);
end

options.nPop= popSize;
options.maxEval= maxIter * popSize;

%% 
% writes output files after each outputGen iterations

if nargin >= 8 && ~isempty(varargin{3})
  outputGen= varargin{3}; 
  
  isN(outputGen, 'outputGen', 8);
else
  % then, only the final values are saved in files, if it is inf, 
  % then never save something
  outputGen= options.maxEval + 1;%Inf;
end

options.outputGen= outputGen;


%% 
% open worker pool, parallel computing is not supported yet by SMS-EMOA

[parallel]= setParallelConfiguration('open', 'none', 1);

                 
%% 
% start SMS-EMOA

nvars= size(LB, 2);
    
%% TODO
% init pop u0 not used at the moment. SMS-EMOA expects a file where the
% init pop is saved
% u0 could be saved inside the init_popSMSEMOA.txt file

u0_0= ones(popSize, nvars) * diag( LB(:) ) + ...
           rand(popSize, nvars) * diag( UB(:) - LB(:) );

if isempty(u0)
  u0= u0_0;%(1:popSize,:);
else
  if size(u0, 2) ~= nvars
    error(['The initial population has not the correct size! ', ...
           'There are %i variables, thus the ', ...
           'initial population must have %i columns, but has %i!'], ...
           nvars, nvars, size(u0, 2));
  end

  u0= [u0; u0_0];
  u0= u0(1:popSize,:);
end

%%
% write params in mat file

params= {nvars, LB, UB, zeros(1,nvars), nObj, fitnessfcn};

SMSproblem= @()initializeSMSproblem(params);

%%
% m-file or p-file
if existMPfile('SMSEMOA')
    
  try
    [paretofront, paretoset, out]= SMSEMOA(SMSproblem, options, 'init_popSMSEMOA.txt');
    
    mydate= ['pf_ps_', datestr(clock, 'yy_mm_dd_HH_MM')];
    save(mydate,'paretofront','paretoset');

  catch ME

    warning('SMSEMOA:Error', 'SMS-EMOA failed!');
    disp(ME.message);

    disp(get_stack_trace(ME));

    paretofront= [];
    paretoset= [];
    out= [];
    
  end

else

  errordlg('The SMS-EMOA algorithm is not installed!');
  error('The SMS-EMOA algorithm is not installed!');

end


%%

if nargout >= 2
  varargout{1}= paretofront;
end
if nargout >= 3
  varargout{2}= out;
end

%%
% close worker pool

setParallelConfiguration('close', parallel);


%%


