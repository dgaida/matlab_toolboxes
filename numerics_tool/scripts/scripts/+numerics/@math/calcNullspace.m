%% calcNullspace
% Calculate the <matlab:doc('null') null-space> of a matrix.
%
function [V]= calcNullspace(A)
%% Release: 1.9

  %%
  
  error( nargchk(1, 1, nargin, 'struct') );
  error( nargoutchk(0, 1, nargout, 'struct') );

  %%
  
  checkArgument(A, 'A', 'double', '1st');

  %%
  % $$V := \left[ \vec{v}_1, \dots, \vec{v}_z \right] \in R^{n \times
  % z}$$ 
  %
  % The set of orthonormal vectors
  %
  % $$\left\{ \vec{v}_1, \dots, \vec{v}_z \right\}$$
  %
  % $$\vec{v}_i \in R^n, i= 1, \dots, z$$
  %
  % span up the, by the constraints $A_{eq} \cdot \vec{x} =
  % \vec{b}_{eq}$,
  % reduced space containing the vectors $\vec{\alpha} \in R^z$.
  % 
  V= null(A);


  %%

  if ~isempty(V)
    V= rearrangeV(V);
  end

end



%%
%
%
function V= rearrangeV(V)
      
  %%
  % try to rearrange the columns of the matrix such that it mostly look
  % like an eye matrix.

  % go through each column and search for the max abs value 
  %
  % [1 1 5]    [1 1 5]    [5 1 1]
  % [2 0 1] -> [0 2 1] -> [1 2 0]
  % [0 1 0]    [1 0 0]    [0 0 1]
  %
  for icol= 1:size(V, 2)

    Vtemp= V;

    [maxval, maxrow]= max( abs( V(:, icol) ) );

    % if maxrow == i, then put it in the ith column, just rearranging columns
    % this is done to get the highest absolute values on the main diagonal
    V(:, min(maxrow, size(V,2)))= Vtemp(:, icol);
    V(:, icol)= Vtemp(:, min(maxrow, size(V,2)));

  end

  %%
  % rearrange just, such that a previous column has no absolute bigger value
  % in a row with a smaller index (from the top) then a following column.
  % 
  % to get something like an upper triangular matrix with the highest
  % values in the top left corner

  row_bound= 1;

  % [5 1 1]    [5 1 1]
  % [1 2 0] -> [1 2 0]
  % [0 0 1]    [0 0 1]
  %
  for icol= 1:size(V,2)

    Vtemp= V;

    [maxval, maxrow]= max(abs(V(:,icol)));

    if ( maxrow < row_bound ) && all( V(1:maxrow, icol - 1) < V(1:maxrow, icol) )
      
      V(:, icol)=     Vtemp(:, icol - 1);
      V(:, icol - 1)= Vtemp(:, icol);

    end

    row_bound= maxrow;

  end

  %%
  % if the max. element is negative, approx. -1, then multiply the column
  % with -1, to get the sign of the eye matrix
  %
  for icol= 1:size(V,2)

    [maxval, maxrow]= max(abs(V(:,icol)));

    if V(maxrow,icol) < 0
        V(:,icol)= -V(:,icol);
    end

  end

  %%
    
end

%%


