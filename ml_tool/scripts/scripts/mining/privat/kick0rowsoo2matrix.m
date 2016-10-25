%% kick0rowsoo2matrix
% Kick zero-rows out of square matrix, always returning a square matrix
%
function matrix= kick0rowsoo2matrix(matrix)
%% Release: 1.9

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

validateattributes(matrix, {'double'}, {'2d', 'nonempty', ...
                   'size', [size(matrix, 1), size(matrix, 1)]}, ...
                   mfilename, 'matrix', 1);

%% 
% is it possible, that this runs more than one iteration? give an example!
% yes it is:
%
% [0 0 0]
% [1 0 0]
% [1 2 3]
%
% deleting the first row gives and afterwards deleting the 1st column
%
% [0 0]
% [2 3]
%
% now the first row and column have to be deleted again, therefore the
% while loop is needed
%

% if the sum over a row is 0, thus there was no test data for this class
while( any( sum( matrix, 2 ) == 0 ) )

  indice= sum( matrix, 2 ) ~= 0;

  % kick out this class, which was not evaluated by the given vectors,
  % respectively keep all other classes
  matrix= matrix( indice, : ); % kick out the row
  matrix= matrix( :, indice ); % kick out the column

end

%%



%%


