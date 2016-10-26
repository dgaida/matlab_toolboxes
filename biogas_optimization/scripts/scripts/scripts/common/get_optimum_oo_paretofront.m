%% get_optimum_oo_paretofront
% Get optimal individual out of paretofront
%
function [u, fitness, index, scalar_min_fitness]= ...
  get_optimum_oo_paretofront(paretofront, paretoset, fitness_params)
%% Release: 1.3

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 4, nargout, 'struct') );

%%
% check arguments

isRnm(paretofront, 'paretofront', 1);
isRnm(paretoset, 'paretoset', 2);

is_fitness_params(fitness_params, 3);

%% TODO
% was ist bei 3 und mehreren zielen?

% alte Idee mit gewichtungsfaktoren

dim= size(paretofront, 2);

if dim ~= 2
  warning('dim:nottwo', 'Problem dimension is %i and not 2!', dim);
end

weights= 1 ./ dim * ones(dim, 1);
weights(1)= fitness_params.myWeights.w_money;
weights(2)= 1.0;

[scalar_min_fitness, index]= min(paretofront * weights);  % median_index

%%
% es soll die zeile aus der paretofront genommen werden, deren summe v.
% indizes je spalte minimal ist, geg. eine sortierte paretofront je
% spalte. d.h. eine lösung die in allen spalten den ersten rang belegt
% wird immer bevorzugt. 

% das ist leider eine schlechte Lösung, da pareto optimale punkte immer
% den gleichen summenwert haben. bsp.:
%
% 1 3
% 2 2
% 3 1
%
% bei drei pareto optimalen punkten, damit wird immer der oberste punkt
% genommen. 

%     [index, paretofront, paretoset]= ...
%       get_optimal_row_of_matrix(paretofront, paretoset);

%%

u= paretoset(index, :);   % optimal individual
fitness= paretofront(index, :);   % corresponding fitness vector

%%


