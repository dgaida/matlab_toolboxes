%% checkDimensionOfVariable
% Check if the given variable has the correct size.
%
function correct= checkDimensionOfVariable(variable, dimension, varargin)
%% Release: 2.9

%%
%

error( nargchk(2, 3, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

if nargin >= 3 && ~isempty(varargin{1})
  varname= varargin{1};
  
  checkArgument(varname, 'varname', 'char', '3rd');
else
  varname= '';
end


%%
% check parameters

checkArgument(dimension, 'dimension', 'double', '2nd');

if min(size(dimension)) ~= 1
  error(['The 2nd parameter dimension is not a vector, ', ...
         'it''s smallest dimension is %i!'], min(size(dimension)));
end


%%

correct= 0;

% transpose if necessary
dimension= reshape(dimension, 1, numel(dimension));

%%
% are the parameters consistent
if numel(dimension) ~= ndims(variable)

  error(['Your dimension vector has not the same dimension (%i) as ', ...
         'your variable, which is %i dimensional.'], ...
         numel(dimension), ndims(variable));

end

%%

% Prüfung gibt einen boolean Vektor zurück, wenn max == 1, dann ist
% mindestens eine Dimension falsch
if max( size(variable) ~= dimension )

  if ndims(variable) == 2

    fprintf(['The given variable ''', varname, ''' has not the correct size. ', ...
           'Its size is %i-by-%i, but has to be %i-by-%i. \n', ...
           'The error could be due to a path problem. \n', ...
           'To check this, call <a href="matlab:doc(''which'')">which</a> followed by the to ', ...
           'be loaded filename to see where the file is load from. ', ...
           'In case the variable is load from a file at all.\n'], ...
            size(variable, 1), size(variable, 2), ...
                 dimension(1), dimension(2));

    error(['The given variable ''', varname, ''' has not the correct size. ', ...
           'Its size is %i-by-%i, but has to be %i-by-%i. ', ...
           'The error could be due to a path problem. ', ...
           'To check this, call <a href="matlab:doc(''which'')">which</a> followed by the to ', ...
           'be loaded filename to see where the file is load from. ', ...
           'In case the variable is load from a file at all.'], ...
            size(variable, 1), size(variable, 2), ...
                 dimension(1), dimension(2));

  else

    fprintf(['The given variable ''', varname, ''' has not the correct size. ', ...
           'It has %i number of elements, but should have %i. \n', ...
           'The error could be due to a path problem. \n', ...
           'To check this, call <a href="matlab:doc(''which'')">which</a> followed by the to ', ...
           'be loaded filename to see where the file is load from.\n'], ...
            numel(variable), prod(dimension));

    %% 
    % until now the exact error message is only implemented for 2
    % dim variables, but it an be easily extended to more
    % dimensions.
    error(['The given variable ''', varname, ''' has not the correct size. ', ...
           'It has %i number of elements, but should have %i. ', ...
           'The error could be due to a path problem. ', ...
           'To check this, call <a href="matlab:doc(''which'')">which</a> followed by the to ', ...
           'be loaded filename to see where the file is load from.'], ...
            numel(variable), prod(dimension));

  end

else

  correct= 1;

end

%%
    

