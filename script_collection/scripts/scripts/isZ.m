%% isZ
% Check whether given argument is an integer ...,-3,-2,-1,0,1,2,3,... 
%
function isZ(argument, argument_name, argument_number, varargin)
%% Release: 1.9

%%

global IS_DEBUG;

if isempty(IS_DEBUG) || ~IS_DEBUG
  return;
end

%%

error( nargchk(3, 5, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

if nargin >= 4 && ~isempty(varargin{1}), 
  lb= varargin{1}; 
  
  isZ(lb, 'lb', 4);
else
  lb= [];
end

if nargin >= 5 && ~isempty(varargin{2}), 
  ub= varargin{2}; 
  
  isZ(ub, 'ub', 5);
else
  ub= [];
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

if isempty(lb) && isempty(ub)
  validateattributes(argument, {'double'}, ...
                     {'scalar', 'integer', 'real'}, ...
                     mfilename, argument_name, argument_number);
else
  if isempty(lb)
    validateattributes(argument, {'double'}, ...
                       {'scalar', 'integer', 'real', '<=', ub}, ...
                       mfilename, argument_name, argument_number);
  elseif isempty(ub)
    validateattributes(argument, {'double'}, ...
                       {'scalar', 'integer', 'real', '>=', lb}, ...
                       mfilename, argument_name, argument_number);
  else
    validateattributes(argument, {'double'}, ...
                       {'scalar', 'integer', 'real', '>=', lb, '<=', ub}, ...
                       mfilename, argument_name, argument_number);
  end
end

%%


