%%-------------------------------------------------------------------------
%%-------------------------------------------------------------------------
function f = initialize_variables(nPop, nObj, nVar,...
    min_range, max_range, problemCall, initPop)
% function f = initialize_variables(nPop, nObj, nVar, min_range, max_range,
% problemCall)
% This function initializes the chromosomes. Each chromosome has the
% following at this stage
%       * set of decision variables
%       * objective function values
% where,
% nPop - Population size
% nObj - Number of objective functions
% nVar - Number of decision variables
% min_range - A vector of decimal values which indicates the minimum value
%             for each decision variable.
% max_range - Vector of maximum possible values for decision variables.
% initPop - file with initial population, if empty a random initialization is performed

f = inf(nPop+1,nVar+nObj); %preallocation
if exist(initPop, 'file')
    % load variables from file
    temp = load(initPop);
    if size(temp,1) ~= nPop || size(temp,2) ~= nVar
        %error('data in file initPop has to be of size nPop');
        % D. Gaida, 17.09.
        warning('initPop:format', 'data in file initPop has to be of size nPop');
        
        % do the same as if file were not there, copied fom line 45-46
        f(:,1:nVar) = repmat(min_range,nPop+1,1) + ...
          repmat((max_range - min_range),nPop+1,1).*rand(nPop+1, nVar);
    else
        f(1:nPop,1:nVar) = temp;
    end;
    if all(min(f(1:nPop,1:nVar))>=0) & all(max(f(1:nPop,1:nVar))<=1)
        % normalized designs have to be transformed
        f(1:nPop,1:nVar) = repmat(min_range,nPop,1) + ...
            repmat((max_range - min_range),nPop,1).*f(1:nPop,1:nVar);
    end;
    f(nPop+1,1:nVar) = min_range + (max_range - min_range).*0.5;
else
    % Initialize the decision variables based on the minimum and maximum
    % possible values. nVar is the number of decision variable. A random
    % number is picked between the minimum and maximum possible values for
    % the each decision variable.
    f(:,1:nVar) = repmat(min_range,nPop+1,1) + ...
        repmat((max_range - min_range),nPop+1,1).*rand(nPop+1, nVar);
end;

% Evaluate each chromosome:
for i = 1 : nPop
    % For ease of computation and handling data the chromosome also has the
    % value of the objective function concatenated at the end.
    f(i,nVar+1:nVar+nObj) = feval(problemCall, f(i,1:nVar));
end;
end

%%


