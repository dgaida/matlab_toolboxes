%-------------------------------------------------------------------------
function offspring = generate_offspring(population, ...
    nObj, nVar, rngMin, rngMax, problemCall, ranks, ...
    variable_crossover_prob, variable_crossover_dist, ...
    variable_mutation_prob, variable_mutation_dist, variable_swap_prob, ...
    useDE, DE_CombinedCR, DE_F, DE_CR)
% function child  = generate_offspring(population, ...
%    nObj, nVar, rngMin, rngMax, problemCall, ranks, ...
%    variable_crossover_prob, variable_crossover_dist, ...
%    variable_mutation_prob, variable_mutation_dist, variable_swap_prob, ...
%    useDE, DE_CombinedCR, DE_F, DE_CR)
%
% population - all possible parents
% nObj - number of objective functions
% nVar - number of decision varaiables
% rngMin - a vector of lower limit for the corresponding decsion variables
% rngMax - a vector of upper limit for the corresponding decsion variables
% problemCall - problem string
% ranks - ranks of the population
% variable_crossover_prob - probability for crossover
% variable_crossover_dist - distribution index for crossover
% variable_mutation_prob - probability for mutation
% variable_mutation_dist - distribution index for mutation
% variable_swap_prob - probability for swapping variables after crossover
% useDE - use differential evolution instead of SBX & PM (true/false)
% DE_CombinedCR - Crossover in blocks or bits
% DE_F - difference weight for differential evolution
% DE_CR - crossover probability for DE
%
% The genetic operation is performed only on the decision variables, that
% are the first V elements in the chromosome vector.

nPop = size(population,1);
% Pre-Allocation
parent = zeros(4,nVar);
offspring = zeros(1,nVar+nObj);
if useDE
    % use differential evolution
    % we need four different parents
    mypermutation = randperm(nPop);
    parent(1,:) = population(mypermutation(1),1:nVar);
    parent(2,:) = population(mypermutation(2),1:nVar);
    switch nPop
        case 2
            parent(3,:) = population(mypermutation(1),1:nVar);
            parent(4,:) = population(mypermutation(2),1:nVar);
        case 3
            parent(3,:) = population(mypermutation(3),1:nVar);
            parent(4,:) = population(mypermutation(1),1:nVar);
        otherwise
            parent(3,:) = population(mypermutation(3),1:nVar);
            parent(4,:) = population(mypermutation(4),1:nVar);
    end;
    % build help_child
    child_1 = parent(2,:) + DE_F.*(parent(3,:)-parent(4,:));
    %combine child_1 & parent_1
    l_index = ceil(nVar*rand(1));
    if l_index == 0
        l_index = 1;
    end
    if DE_CombinedCR
        l_index_add = 0;
        while (rand(1) < DE_CR) && (l_index_add < nVar-1)
            l_index_add = l_index_add + 1;
        end;
        if l_index+l_index_add > nVar
            r_index = l_index+l_index_add-nVar;
            for j=1:nVar
                if (j<=r_index) || (j>=l_index)
                    offspring(j)=child_1(j);
                else
                    offspring(j)=parent(1,j);
                end
            end
        else
            r_index = l_index+l_index_add;
            for j=1:nVar
                if (j>=l_index)&&(j<=r_index)
                    offspring(j)=child_1(j);
                else
                    offspring(j)=parent(1,j);
                end
            end
        end
    else
        for j=1:nVar
            if (j == l_index) || (rand(1) < DE_CR)
                offspring(j)=child_1(j);
            else
                offspring(j)=parent(1,j);
            end
        end;
    end;
else
    % use SBX & PM
    % Initialize the parents for SBX
    % two binary tournaments
    randomindices = ceil(rand(1,4)*nPop);
    randomindices(randomindices==0)=1;
    parent(1,:) = population(randomindices(1),1:nVar);
    parent(2,:) = population(randomindices(2),1:nVar);
    parent(3,:) = population(randomindices(3),1:nVar);
    parent(4,:) = population(randomindices(4),1:nVar);
    if ranks(randomindices(1)) < ranks(randomindices(2))
        parent_1 = parent(1,:);
    elseif ranks(randomindices(1)) > ranks(randomindices(2))
        parent_1 = parent(2,:);
    elseif rand(1) > 0.5
        parent_1 = parent(1,:);
    else
        parent_1 = parent(2,:);
    end
    if ranks(randomindices(3)) < ranks(randomindices(4))
        parent_2 = parent(3,:);
    elseif ranks(randomindices(3)) > ranks(randomindices(4))
        parent_2 = parent(4,:);
    elseif rand(1) > 0.5
        parent_2 = parent(3,:);
    else
        parent_2 = parent(4,:);
    end
    % Perform crossover for each decision variable.
    child_1 = zeros(1,nVar);
    child_2 = zeros(1,nVar);
    for j = 1 : nVar
        if rand(1) < variable_crossover_prob
            % SBX (Simulated Binary Crossover)
            u = rand(1);
            if u <= 0.5
                bq = (2*u)^(1/(variable_crossover_dist+1));
            else
                bq = (1/(2*(1 - u)))^(1/(variable_crossover_dist+1));
            end
            % Generate the jth element of first child
            child_1(j) = ...
                0.5*(((1 + bq)*parent_1(j)) + (1 - bq)*parent_2(j));
            % Generate the jth element of second child
            child_2(j) = ...
                0.5*(((1 - bq)*parent_1(j)) + (1 + bq)*parent_2(j));
        else
            child_1(j) = parent_1(j);
            child_2(j) = parent_2(j);
        end
        if rand(1) < variable_swap_prob
            swap = child_1(j);
            child_1(j) = child_2(j);
            child_2(j) = swap;
        end;
    end
    if rand(1) < 0.5
        offspring(1:nVar) = child_1;
    else
        offspring(1:nVar) = child_2;
    end;
    
    % perform mutation. Mutation is based on polynomial mutation.
    % Perform mutation on each element of the selected parent.
    deltaMax = rngMax - rngMin;
    for j = 1 : nVar
        if rand(1) < variable_mutation_prob
            r = rand(1);
            if r < 0.5
                delta = (2*r)^(1/(variable_mutation_dist+1)) - 1;
            else
                delta = 1 - (2*(1 - r))^(1/(variable_mutation_dist+1));
            end
            % Generate the corresponding child element.
            offspring(j) = offspring(j) + delta.*deltaMax(j);
        end
    end
end
% Make sure that the generated element is within the decision space.
offspring(1:nVar) = min([rngMax; offspring(1:nVar)]);
offspring(1:nVar) = max([rngMin; offspring(1:nVar)]);
% Evaluate the objective functions
offspring(nVar + 1: nVar + nObj) = feval(problemCall, offspring(1:nVar));
end

%%


