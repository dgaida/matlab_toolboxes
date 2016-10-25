%% findOptimalKrigingModel
% Find optimal Kriging Model by searching optimal theta
%
function [model_opt, theta_opt, fitness, varargout]= ...
          findOptimalKrigingModel(method, inputs, outputs, varargin)
%% Release: 1.5

%%
%

error( nargchk(3, 10, nargin, 'struct') );
error( nargoutchk(0, nargout, nargout, 'struct') );


%%

dim= size(inputs, 2);


%%
%

regMethod= 'poly0';

corrMethod= 'gaussian';

%%
%

if nargin >= 4 && ~isempty(varargin{1})
  validSet_index= varargin{1};
else
  % default 5-fold cross validation
  % Attention: data is splitted randomly between training and validation data 
  validSet_index= randi(5, size(outputs, 1), 1);
end

if nargin >= 5 && ~isempty(varargin{2})
  LB= varargin{2};
else
  LB= 1e-3 .* ones(1, dim);
end

if nargin >= 6 && ~isempty(varargin{3})
  UB= varargin{3};
else
  UB= 20 .* ones(1, dim);
end

if nargin >= 7 && ~isempty(varargin{4}), 
  parallel= varargin{4}; 
else
  parallel= 'none';
end

if nargin >= 8 && ~isempty(varargin{5}), 
  nWorker= varargin{5}; 
else 
  nWorker= 2; 
end

if nargin >= 9 && ~isempty(varargin{6}), 
  pop_size= varargin{6}; 
else
  pop_size= 7;%15;%5; 
end

if nargin >= 10 && ~isempty(varargin{7}), 
  nGenerations= varargin{7}; 
else
  nGenerations= 3;%15;%5;
end


%%
% check if the parameters have valid values

validateattributes(inputs,  {'double'}, {'2d', 'nonempty'}, mfilename, 'input data',  2);
validateattributes(outputs, {'double'}, {'2d', 'nonempty'}, mfilename, 'output data', 3);

if size(inputs, 1) ~= size(outputs, 1)
  error('inputs and outputs must have the same number of samples: %i ~= %i!', ...
        size(inputs, 1), size(outputs, 1));
end

if ischar(method) || iscell(method)
  method= char(method);
else
  checkArgument(method, 'method', 'char', '1st');
end

checkArgument(validSet_index, 'validSet_index', 'double', '4th');

if numel(validSet_index) ~= size(inputs, 1)
  error('validSet_index must have same number of elements as inputs has rows: %i ~= %i', ...
        numel(validSet_index), size(inputs, 1));
end

validateattributes(LB,  {'double'}, {'2d'}, mfilename, 'LB',  5);
validateattributes(UB,  {'double'}, {'2d'}, mfilename, 'UB',  6);

if numel(LB) ~= numel(UB)
  error('LB and UB must have same number of elements: %i ~= %i!', ...
        numel(LB), numel(UB));
end

validatestring(parallel, {'none', 'multicore', 'cluster'}, mfilename, 'parallel', 7);

isN(nWorker, 'number of worker', 8);
isN(pop_size, 'size of population', 9);
isN(nGenerations, 'number of generations', 10);

% no parallel computing?
if strcmp(parallel, 'none')
  nWorker= 1;
end

%% 
% check if parameter combinations are chosen for which there is not yet an
% implementation -> Implement them and erase the queries here...!

%if (~strcmp(parallel, 'none') && strcmp(method, 'PSO'))
%    error('The parallel code for the PSO method is not yet implemented.');
%end

if strcmp(parallel, 'cluster')
    error('The parallel code for the cluster is not yet implemented/tested.');
end


%%
% define the fitness function
        
ObjectiveFunction= ...
    @(u)fitness_kriging(inputs, outputs, validSet_index, ...
                        regMethod, corrMethod, u, ...
                        LB, UB);

                          
%% 
% start optimization method
                   
tic

%

switch (method)

  %%

  case 'PSO'

      [u, fitness, varargout]= startPSO(ObjectiveFunction, dim, ...
                                   LB, ...
                                   UB, [], pop_size, ...
                                   nGenerations, 60*60*14, 1e-99, ...
                                   parallel, nWorker);

  %%

  case 'CMAES'          

      [u, varargout]= startCMAES(ObjectiveFunction, ...
                                   [], LB, UB, pop_size, ...
                                   nGenerations, parallel, nWorker);                             

  %%
  
  otherwise
    error('Unknown method: %s!', method);
  
end

%%

theta_opt= u;

[fitness, theta_dummy, model_opt]= ...
     fitness_kriging(inputs, outputs, validSet_index, ...
                     regMethod, corrMethod, theta_opt, LB, UB);
             

%%



%%
%

toc

%%


