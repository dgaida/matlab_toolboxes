%% startPatternSearch
% Prepare and start <matlab:doc('patternsearch') patternsearch> algorithm
% for optimal biogas plant control. 
%
function [u, varargout]= startPatternSearch(ObjectiveFunction, u0, varargin)
%% Release: 1.8

%%

error( nargchk(2, 14, nargin, 'struct') );
error( nargoutchk(0, 4, nargout, 'struct') );

%% 
% read out varargin

if nargin >= 3, LB= varargin{1}; else LB= []; end
if nargin >= 4, UB= varargin{2}; else UB= []; end

%%
% params are checked in setPatternSearchOptions
if nargin >= 5, maxIter= varargin{3}; else maxIter= []; end
if nargin >= 6, timelimit= varargin{4}; else timelimit= []; end
if nargin >= 7, tolerance= varargin{5}; else tolerance= []; end

%%

if nargin >= 8, A= varargin{6}; else A= []; end
if nargin >= 9, b= varargin{7}; else b= []; end
if nargin >= 10, Aeq= varargin{8}; else Aeq= []; end
if nargin >= 11, beq= varargin{9}; else beq= []; end

if nargin >= 12 && ~isempty(varargin{10})
  parallel= varargin{10}; 
  
  validatestring(parallel, {'none', 'multicore', 'cluster'}, ...
                 mfilename, 'parallel', 12);
else
  parallel= 'none';
end

if nargin >= 13 && ~isempty(varargin{11}), 
  nWorker= varargin{11}; 
  
  validateattributes(nWorker, {'double'}, ...
                     {'scalar', 'positive', 'integer'}, ...
                     mfilename, 'nWorker', 13);
else
  nWorker= 2;
end

if nargin >= 14, searchMethod= varargin{12}; else searchMethod= []; end


%%
% check parameters

checkArgument(ObjectiveFunction, 'ObjectiveFunction', 'function_handle', '1st');
checkArgument(u0, 'u0', 'double', '2nd');
checkArgument(LB, 'LB', 'double', '3rd');
checkArgument(UB, 'UB', 'double', '4th');

checkArgument(A, 'A', 'double', '8th');
checkArgument(b, 'b', 'double', '9th');
checkArgument(Aeq, 'Aeq', 'double', '10th');
checkArgument(beq, 'beq', 'double', '11th');


%%

LB= LB(:)';
UB= UB(:)';

if numel(LB) ~= numel(UB)
  error('LB and UB must be of the same size: %i ~= %i!', ...
        numel(LB), numel(UB));
end


%%
% set options

options= setPatternSearchOptions(...
                  maxIter, timelimit, tolerance, searchMethod);


%% 
% open worker pool

[parallel]= setParallelConfiguration('open', parallel, nWorker);

                 
%%
%

if isempty(u0)
  u0= LB + (UB - LB) ./ 2;
end


%% 
% start PatternSearch

if exist('patternsearch', 'file') == 2
  [u,fitness,exitflag,output]= ...
    patternsearch(ObjectiveFunction, u0, A, b, Aeq, beq, ...
                  LB, UB, [], options);
else
  errordlg('Genetic Algorithm and Direct Search Toolbox not installed!');
  error('Genetic Algorithm and Direct Search Toolbox not installed!');
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


