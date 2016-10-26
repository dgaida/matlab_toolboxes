% computes the R2 indicator value for a set of points and an ideal point I
% used is the unary R2 indicator
% \sum_{w in weights} \min_{p in points} max_i w_i * |f_i(p) - I_i| 
%
% Authors: Tobias Wagner, Institute of Machining Technology, TU Dortmund
%          Dimo Brockhoff, INRIA Lille - Nord Europe, France
% License: GPLv2
% Last Revision: 2012-10-31

function value = r2(points, ideal, weights)
% check input
[n d] = size(points);
[m dm] = size(ideal);
if (d < 1 ) || (d ~= dm)
    error('dimensions of point matrix and ideal point must be equal and > 1');
end;

ideals = repmat(ideal, n, 1);
normalizedPoints = points - ideals;

N = size(weights, 1);
minUtilityPoints = zeros(N,1);
currWeights = zeros(n, d);
% for each weight, compute the minimal weighted Tchebycheff value
for i = 1:N
    currWeights = repmat(weights(i,:), n, 1);
    currWeights = currWeights .* normalizedPoints;
    utilityPoints = max(currWeights, [], 2);
    minUtilityPoints(i) = min(utilityPoints);
end;
value = sum(minUtilityPoints)/N;


function kary = int2kary(x, basek, digits)
val = digits-1;
kary = zeros(1, digits);
i = 1;
while x
    if x >= basek.^val
        kary(i) = kary(i)+1;
	    x = x - basek.^val;
    else
        val = val-1;
	    i = i+1;
    end;
end;

function value = weightedSum(weights, objectives, ideal, nadir)
d = length(nadir);
value = ones(size(objectives,1),1);
for i = 1:d
    value = value - weights(i).*( (objectives(:,i) - ideal(i)) ./ ...
        (nadir(i) - ideal(i)) );
end;

function value = regularTchebycheff(weights, objectives, ideal, nadir)
d = length(nadir);
all = zeros(size(objectives));
for i = 1:d
    all(:,d) = weights(i).*( (objectives(:,i) - ideal(i)) ./ ...
        (nadir(i) - ideal(i)) );
end;
value = ones(size(objectives, 1), 1) - max(all, [], 2);

function value = augmentedTchebycheff(weights, objectives, ideal, ...
    nadir, rho)
value = regularTchebycheff(weights, objectives, ideal, nadir) ...
    + rho.*weightedSum(weights, objectives, ideal, nadir);