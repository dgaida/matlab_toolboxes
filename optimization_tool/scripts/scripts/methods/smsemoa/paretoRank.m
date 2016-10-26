function ranks = paretoRank(objectives)
%paretoRank calculates pareto-ranks for all elements of objectives
nPop = size(objectives,1);
ranks = zeros(nPop,1);
% init select-vector filled with logical ones
popInd = true(nPop,1);
nPV = 1;
while any(popInd)
    %get next paretofront
    frontInd = popInd;
    % paretofront returns those of objectives which are pareto optimal
    frontInd(popInd) = paretofront(objectives(popInd,:));
    % they get rank 1
    ranks(frontInd) = nPV;
    % remove ones of next paretofront from select-vector
    popInd = xor(popInd,frontInd); % preto optimal points are removed from set
    % for the next iteration without pareto optimal points, lets see which
    % are pareto optimal now, they have rank 2, then 3, ...
    nPV = nPV+1;
end;