%% startCMAES
% Prepare and start CMA-ES Covariance Matrix Adaptation Evolution Strategy 
% to minimize the given fitness function. 
%
function [u, varargout]= startCMAES(fitnessfcn, u0, LB, UB, varargin)
%% Release: 1.9

%%

error( nargchk(4, 8, nargin, 'struct') );
error( nargoutchk(0, 6, nargout, 'struct') );

%%
% check parameters

checkArgument(fitnessfcn, 'fitnessfcn', 'function_handle', '1st');
checkArgument(u0, 'u0', 'double', '2nd');
isRn(LB, 'LB', 3);
isRn(UB, 'UB', 4);

%%

LB= LB(:)';
UB= UB(:)';

if numel(LB) ~= numel(UB)
  error('LB and UB must be of the same size: %i ~= %i!', ...
        numel(LB), numel(UB));
end


%% 
% read out varargin

if nargin >= 5 && ~isempty(varargin{1})
  popSize= varargin{1}; 
  
  isN(popSize, 'popSize', 5);
else
  popSize= []; 
end

if nargin >= 6 && ~isempty(varargin{2})
  maxIter= varargin{2}; 
  
  isN(maxIter, 'maxIter', 6);
else
  maxIter= 4;
end

if nargin >= 7 && ~isempty(varargin{3})
  parallel= varargin{3}; 
  
  validatestring(parallel, {'none', 'multicore', 'cluster'}, ...
                 mfilename, 'parallel', 7);
else
  parallel= 'none';
end

if nargin >= 8 && ~isempty(varargin{4})
  nWorker= varargin{4}; 
  
  isN(nWorker, 'nWorker', 8);
else
  nWorker= 2; 
end


%%
% set options

options.LBounds= LB';
options.UBounds= UB';
options.MaxIter= maxIter;
% damit man nachher auch resumen kann, noch nicht ganz sicher ob countiter
% auf 0 zurück gesetzt wird bei nächstem lauf, oder ob ich hier immer eine
% höhere maxIter Zahl einsetzen muss
%options.StopIter= maxIter;
options.TolFun= 1e-20;
options.StopFitness= -Inf;
options.SaveVariables= 'final'; %'on'   % final bedeutet nur ganz am ende, aber nicht nach stop
options.LogModulo= 0;
options.EvalParallel= 'yes';

if isempty(popSize)
  popSize= setPopSize(UB - LB);
end

options.PopSize= popSize;


%% 
% open worker pool

[parallel]= setParallelConfiguration('open', parallel, nWorker);

                 
%% 
% start CMAES

%if isempty(u0)
  nvars= size(LB, 2);

  u0_0= lhSampling(popSize, nvars, LB, UB);
  
%   u0_0= ones(popSize, nvars) * diag( LB(:) ) + ...
%               rand(popSize, nvars) * diag( UB(:) - LB(:) );
%end

if isempty(u0)
  % if matrix is given to CMAES it just takes the mean of it as initial
  % point
  u0= u0_0;%(1:popSize,:);
  
  if exist(fullfile(pwd, 'final_u_CMAES.mat'), 'file')
    
    %%
    % if the file above exists, it indicates that a previous run was
    % already made. then resume optimization from final saved results,
    % saved in variablescmaes.mat. those are saved because of saveVariables
    % option set to final above. so in this configuration the file
    % final_u_CMAES.mat I guess will not be used, just used as indicator. 
    % resume does not work for me, becasue all variables are saved into mat
    % files. because i work with C# objects this leads to an error while
    % loading the file again
    
    %options.Resume= 'no';
    
    %%
    
    uopt= load_file(fullfile(pwd, 'final_u_CMAES.mat'));
    
    if numel(uopt) ~= size(u0,2)
      warning('uopt:dim', ...
        'Rejecting previous optimal individual, because of dimension mismatch: %i ~= %i!', ...
        numel(uopt), size(u0,2));
    else
    
      u0= uopt;    % this a row vector, below a column vector is created out 
                   % of it, as it is needed by CMAES
    end
    
  end
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
% m-file or p-file
if existMPfile('cmaes')
    
  try
    [u, fitness, counteval, exitflag, population, out, bestever]= ...
        cmaes(fitnessfcn, u0', [], options);
  catch ME

    warning('CMAES:Error', 'cmaes failed!');
    disp(ME.message);

    %dbstack
    
    disp(get_stack_trace(ME));

    u= u0(1,:);
    fitness= Inf;
    counteval= 0;
    exitflag= -1;
    population= u0';
    out= [];
    bestever.x= u;
    bestever.f= fitness;

  end

else

  errordlg('The CMA-ES algorithm is not installed!');
  error('The CMA-ES algorithm is not installed!');

end


%%
% do not return last individual but bestever evaluated individual
%u= u(:)';
u= bestever.x(:)';
fitness= bestever.f;

%%

save('final_u_CMAES.mat', 'u');

%% TODO
% save workspace to file, just for testing
save('CMAES_all.mat')

%%

if nargout >= 2
  varargout{1}= fitness;
end
if nargout >= 3
  varargout{2}= counteval;
end
if nargout >= 4
  varargout{3}= exitflag;
end
if nargout >= 5
  varargout{4}= population';
end
if nargout >= 6
  varargout{5}= {out, bestever};
end


%%
% close worker pool

setParallelConfiguration('close', parallel);

%%


