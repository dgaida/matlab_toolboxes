%% kickNaNsoo2matrix
% Kick NaNs out of square matrix, always returning a square matrix
%
function matrix= kickNaNsoo2matrix(matrix)
%% Release: 1.9

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

validateattributes(matrix, {'double'}, {'2d', 'nonempty', ...
                   'size', [size(matrix, 1), size(matrix, 1)]}, ...
                   mfilename, 'matrix', 1);
                 
%%

indice= all(~isnan( matrix ), 2);

% kick out this class, which was not evaluated by the given vectors,
% respectively keep all other classes
matrix= matrix( indice, : ); % kick out the row
matrix= matrix( :, indice ); % kick out the column

%%



%%


