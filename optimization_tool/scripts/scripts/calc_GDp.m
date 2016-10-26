%% calc_GDp
% Calculate modified generational distance between pareto front and an approximation
%
function [GD]= calc_GDp(pf, approx, p)
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

GD= 0;

%%

for ipoint= 1:cardA

  ai= repmat(approx(ipoint, :), cardPF, 1);

  % calc distances of point ai to points in PF
  edistances= numerics.math.edist(pf, ai);

  di= min(edistances);    % calc min distance
  
  di= di^p;               % 
  
  GD= GD + di;            % sum over distances
  
end

%%

GD= (GD / cardA)^(1/p);

%%


