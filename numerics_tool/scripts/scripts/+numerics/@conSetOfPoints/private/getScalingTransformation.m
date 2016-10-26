%% numerics.conSetOfPoints.private.getScalingTransformation
% Get a linear transformation to scale LB and UB between 0 and 10
%
function [LB, UB, A, b, C, Cinv, d]= ...
                        getScalingTransformation(LB, UB, varargin)
%% Release: 1.9

%%

error( nargchk(2, 4, nargin, 'struct') );
error( nargoutchk(7, 7, nargout, 'struct') );

%%
%

if nargin >= 3,
  A= varargin{1};
  
  checkArgument(A, 'A', 'double', '3rd');
  
  error( nargchk(4, 4, nargin, 'struct') );
else
  A= [];
end

if nargin >= 4,
  b= varargin{2};
  
  checkArgument(b, 'b', 'double', '4th');
else
  b= [];
end

%%
% check params

checkArgument(LB, 'LB', 'double', '1st');
checkArgument(UB, 'UB', 'double', '2nd');


%%
% $$\vec{x}_{sc} := C \cdot \left( \vec{x} - \vec{d} \right)$$
%
% If $\vec{x} \in \left[LB, UB \right]$ then it shall be $\vec{x}_{sc} \in
% [0, 10]$. 
%
% To achieve this:

if ~isempty(LB)

  UB= UB(:);
  LB= LB(:);

  if numel(LB) ~= numel(UB)
    error(['The parameters LB and UB do not have the ', ...
           'same dimension. %i ~= %i!'], numel(LB), numel(UB));
  end

  %%
  % $C := diag \left( \frac{10}{UB(i) - LB(i)} \right)$
  %
  % $C := diag \left( \matrix{ \frac{10}{UB(1) - LB(1)} &  & 0 \cr &
  % \ddots & \cr 0 & 
  % & \frac{10}{UB(n) - LB(n)} } \right)$ 
  %
  C= diag( 10 ./ ( UB - LB ) );

  %%
  % $C^{-1}$, since $C$ is diagonal, the inverse is just the inverse of
  % the diagonal elements of $C$
  %
  Cinv= diag( ( UB - LB ) ./ 10 );

  %%
  % $\vec{d} := LB$
  %
  d= LB;

%     if ~isempty(Aeq)
%         Aeq= Aeq * Cinv;
%         beq= beq - Aeq * d;
%     end

  %%
  % 
  %
  if ~isempty(A)

    A_copy= A;

    %%
    % $A \cdot \vec{x} \leq \vec{b}$
    %
    % $A \cdot \left( C^{-1} \cdot \vec{x}_{sc} + \vec{d} \right) \leq
    % \vec{b}$ 
    %
    % $A \cdot C^{-1} \cdot \vec{x}_{sc} + A \cdot \vec{d} \leq
    % \vec{b}$ 
    %
    % $A \cdot C^{-1} \cdot \vec{x}_{sc} \leq
    % \vec{b} - A \cdot \vec{d}$ 
    %
    A= A * Cinv;

    %%
    %

    if numel(b) ~= size(A_copy, 1)
      error(['Dimension mismatch between b and A_copy. ', ...
             '%i ~= %i!'], numel(b), size(A_copy, 1));
    end

    %%
    %
    %
    b= b - A_copy * d;

  end

  %%
  % $UB= C \cdot ( UB - \vec{d} )$
  %
  % $LB= C \cdot ( LB - \vec{d} )$
  %
  UB= ( C * ( UB - LB ) )';
  LB= ( C * ( LB - LB ) )';

else

  C= [];
  Cinv= [];
  d= [];

end

%%


