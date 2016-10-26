%% isRnm
% Check whether given argument is a real 2d matrix
%
function isRnm(argument, argument_name, argument_number, varargin)
%% Release: 1.5

%%

global IS_DEBUG;

if isempty(IS_DEBUG) || ~IS_DEBUG
  return;
end

%%

error( nargchk(3, 4, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

if nargin >= 4 && ~isempty(varargin{1}), 
  plusminus= varargin{1}; 
  
  validatestring(plusminus, {'+', '-'}, mfilename, 'plusminus', 4);
else
  plusminus= [];
end

%%
% check arguments

if ~ischar(argument_name)
  error(['The 2nd argument argument_name must be a ', ...
         '<a href="matlab:doc(''char'')">char</a>, but is a ', ...
         '<a href="matlab:doc(''%s'')">%s</a>!'], ...
         class(argument_name), class(argument_name));
end

validateattributes(argument_number, {'double'}, ...
                   {'scalar', 'positive', 'integer'}, ...
                   mfilename, 'argument_number', 3);

%%

if isempty(plusminus)
  validateattributes(argument, {'double'}, {'2d', 'nonempty', 'real'}, ...
                     mfilename, argument_name, argument_number);
else
  if strcmp(plusminus, '+')
    validateattributes(argument, {'double'}, {'2d', 'nonempty', 'real', 'nonnegative'}, ...
                     mfilename, argument_name, argument_number);
  elseif strcmp(plusminus, '-')
    validateattributes(argument, {'double'}, {'2d', 'nonempty', 'real', '<=', 0}, ...
                     mfilename, argument_name, argument_number);
  end
end

%%


