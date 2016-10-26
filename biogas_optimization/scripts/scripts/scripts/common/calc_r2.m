%% calc_r2
% Calc R2
%
function [r2ind]= calc_r2(mypf, fitness_params, ideal)
%% Release: 0.0

%%

dim= size(mypf, 2);

if dim ~= 2
  warning('dim:nottwo', 'Problem dimension is %i and not 2!', dim);
end

weights= 1 ./ dim * ones(dim, 1);
weights(1)= fitness_params.myWeights.w_money;
weights(2)= 1.0;
weights= weights';

% ich skaliere die pf schon mal auf die richtige größenordnung, da die
% unten geladenen gewichte von 0 bis 1 laufen
mypf= weights(ones(size(mypf, 1), 1),:) .* mypf;

ideal= weights .* ideal;    % dann muss ich auch ideal punkt skalieren

% diese gewichte laufen von 0 bis 1
weights= load_file('weights2Dnormal.mat');
% always make sure that weights are sorted in f_1 direction
weights = sortrows(weights,1);

%%
% calculate R2
% ideal must be row vector
% weights must be a row vector, or a matrix. but no. of colmuns must be
% equal to dimension of problem
r2ind= r2(mypf, ideal, weights);

%%


