%% numerics.conSetOfPoints.getPointsInConstrainedDimension
% Get points in constrained dimension
%
function p= getPointsInConstrainedDimension(obj, x)
%% Release: 1.6

%%

error( nargchk(2, 2, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
%

checkArgument(x, 'x', 'double', '1st');

%%
% $$V:= null(A_{eq})$$
%
V= obj.V;

%%

nRows= size(x, 1);

%%

Aeq= obj.Aeq;
beq= obj.beq;

%%

C= obj.C;
d= obj.d;


%%

if ~isempty(V) && ~isempty(Aeq)
    
  if isempty(beq)
      error('The vector b_eq is empty!');
  end

  %%
  % $$x_p := A_{eq} \backslash \vec{b}_{eq}$$
  %
  xp= Aeq\beq;

  %%

  %alpha= p';

%     if size(V,2) ~= size(alpha, 1)
%         error('size(V,2) ~= size(alpha, 1) : %i ~= %i', ...
%                size(V,2), size(alpha, 1));
%     end

  %%


  %xh= V * alpha;

  %%
  % $$p = \left( V^T \cdot V \right)^{-1} \cdot V^T \cdot \left( x^T -
  % A_{eq} \backslash \vec{b}_{eq} \right)$$ 
  %
  % = 
  %
  % $$p = V \backslash \left( x^T -
  % A_{eq} \backslash \vec{b}_{eq} \right)$$
  %
  p= V \ ( x' - repmat(xp, 1, nRows) );

else

  p= x';

end

%%
% $$p= C \cdot \left( V \backslash \left( x^T -
% A_{eq} \backslash \vec{b}_{eq} \right) - d \right) $$
%
p= ( C * ( p - repmat(d, 1, nRows) ) )';

%%

if obj.nRows ~= 0 && obj.conDim ~= size(p, 2)
    error(['The given points p have not the dimension of the constrained', ...
           ' space of obj! %i ~= %i'], size(p, 2), obj.conDim);
end

%%


