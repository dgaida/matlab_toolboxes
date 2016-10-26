%% numerics.conSetOfPoints.getPointsInFullDimension
% Get the description of a dataset, living in the subspace $null(A_{eq})$,
% in the full, unconstrained space.
%
function x= getPointsInFullDimension(obj, p)
%% Release: 1.9

%%

error( nargchk(2, 2, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
%

checkArgument(p, 'p', 'double', '1st');

%%
% $$V:= null(A_{eq})$$
%
V= obj.V;

%%

nRows= size(p, 1);

%%

Aeq= obj.Aeq;
beq= obj.beq;

%%

Cinv= obj.Cinv;
d= obj.d;

%%
% check input parameter

dim= size(p, 2);

if dim ~= size(Cinv, 2)
  
  error('Size mismatch between Cinv and dim. %i ~= %i', dim, size(Cinv, 2));
  
end

%%
% see getScalingTransformation
%
% $$\vec{x} = C^{-1} \cdot \vec{x}_{sc} + \vec{d}$$
%
p= ( Cinv * p' + repmat(d, 1, nRows) )';


%%

if ~isempty(V) && ~isempty(Aeq)
    
  if obj.nRows ~= 0 && obj.conDim ~= size(p, 2)
      error(['The given points p have not the dimension of the constrained', ...
             ' space of obj! %i ~= %i'], size(p, 2), obj.conDim);
  end

  if isempty(beq)
      error('The vector b_eq is empty!');
  end

  %%
  % $$x_p := A_{eq} \backslash \vec{b}_{eq}$$
  %
  xp= Aeq\beq;

  %%

  alpha= p';

  if size(V,2) ~= size(alpha, 1)
      error('size(V,2) ~= size(alpha, 1) : %i ~= %i', ...
             size(V,2), size(alpha, 1));
  end

  %%
  % $$\vec{x}_h= V \cdot \vec{\alpha}$$
  %
  xh= V * alpha;

  %%
  % $$\vec{x} := \vec{x}_h + \vec{x}_p$$
  %
  x= ( xh + repmat(xp, 1, nRows) )';

else

  % the space is not constrained
  x= p;

end

%%


