%% startGA_PatternSearch
% Prepare and start genetic algorithm and pattern search to minimize
% objective function
%
function [u, varargout]= ...
    startGA_PatternSearch(ObjectiveFunction, lenIndividual, varargin)
%% Release: 1.4

%%

error( nargchk(2, 15, nargin, 'struct') );
error( nargoutchk(0, 6, nargout, 'struct') );

%%
% check parameters

checkArgument(ObjectiveFunction, 'ObjectiveFunction', 'function_handle', '1st');

validateattributes(lenIndividual, {'double'}, {'scalar', 'positive', 'integer'}, ...
                   mfilename, 'lenIndividual', 2);

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
% are already checked in setGAOptions
if nargin >= 5, u0= varargin{3}; else u0= []; end
if nargin >= 6, popSize= varargin{4}; else popSize= []; end
if nargin >= 7, noGenerations= varargin{5}; else noGenerations= []; end
if nargin >= 8, timelimit= varargin{6}; else timelimit= []; end
if nargin >= 9, tolerance= varargin{7}; else tolerance= []; end

%%

if nargin >= 10, A= varargin{8}; else A= []; end
if nargin >= 11, b= varargin{9}; else b= []; end
if nargin >= 12, Aeq= varargin{10}; else Aeq= []; end
if nargin >= 13, beq= varargin{11}; else beq= []; end

checkArgument(A, 'A', 'double', '10th');
checkArgument(b, 'b', 'double', '11th');
checkArgument(Aeq, 'Aeq', 'double', '12th');
checkArgument(beq, 'beq', 'double', '13th');

if nargin >= 14 && ~isempty(varargin{12}),
  parallel= varargin{12};

  validatestring(parallel, {'none', 'multicore', 'cluster'}, ...
               mfilename, 'parallel', 14);
else
  parallel= 'none'; 
end

if nargin >= 15 && ~isempty(varargin{13}), 
  nWorker= varargin{13}; 

  validateattributes(nWorker, {'double'}, ...
                   {'scalar', 'positive', 'integer'}, ...
                   mfilename, 'nWorker', 15);
else
  nWorker= 2;
end


%%
% set options

Generations_GA= 20;

options_ga= setGAOptions(u0, popSize, Generations_GA, timelimit, tolerance);


%%
% set options

options_ps= setPatternSearchOptions(200, timelimit, tolerance, []);
              
                       
%% 
% open worker pool

[parallel]= setParallelConfiguration('open', parallel, nWorker);


%%

tot_generations= noGenerations / Generations_GA;

%%

if exist('ga', 'file') ~= 2 || exist('patternsearch', 'file') ~= 2
  errordlg('Genetic Algorithm and Direct Search Toolbox not installed!');
  error('Genetic Algorithm and Direct Search Toolbox not installed!');
end

%%

for iGeneration= 1:tot_generations

  %% 
  % start GA
  [u, fitness, exitflag, output, population, scores]= ...
          ga(ObjectiveFunction, lenIndividual, A, b, Aeq, beq, LB, UB, ...
                          [], options_ga);

  if exitflag == -2
    break;
  end

  pop_sort= sortrows([scores, population], 1);

  [pop_unique, m]= unique(pop_sort(1:50,:), 'rows');

  population= pop_sort(:,2:end);

  best_pop= pop_unique(1:min(1,size(pop_unique,1)),2:end);

  last_index= 1;

  for iIndividual= 1:size(best_pop,1)

    %% 
    % start PatternSearch

    u0= best_pop(iIndividual,:);

    [u,fitness,exitflag,output]= ...
        patternsearch(ObjectiveFunction, u0, A, b, Aeq, beq, LB, UB, ...
                      [], options_ps);

    population(last_index:m(iIndividual), :)= ...
                    repmat(u, m(iIndividual) - last_index + 1, []);

    last_index= m(iIndividual) + 1;

  end

  if ~isempty(population)
    options_ga= gaoptimset(options_ga, 'InitialPopulation', population);
  end

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
if nargout >= 5
  varargout{4}= population;
end
if nargout >= 6
  varargout{5}= scores;
end


%%
% close worker pool

setParallelConfiguration('close', parallel);


%%


