%% calc_IGDp
% Calculate modified inverted generational distance between pareto front and an approximation
%
function [IGD]= calc_IGDp(pf, approx, p)
%% Release: 0.9

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% check arguments

isRnm(pf, 'pf', 1);
isRnm(approx, 'approx', 2);
isN(p, 'p', 3);

%%
%

cardA= size(approx, 1);   % number of elements in approximation set
cardPF= size(pf, 1);   % number of elements in pareto front

IGD= 0;

%%

for ipoint= 1:cardPF

  pfi= repmat(pf(ipoint, :), cardA, 1);

  % calc distances of pareto point pfi to points in approx
  edistances= numerics.math.edist(approx, pfi);

  di= min(edistances);    % calc min distance
  
  di= di^p;               % 
  
  IGD= IGD + di;          % sum over distances
  
end

%%

IGD= (IGD / cardPF)^(1/p);

%%


