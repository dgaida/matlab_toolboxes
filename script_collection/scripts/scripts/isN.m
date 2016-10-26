%% isN
% Check whether given argument is a natural number 1,2,3,... 
%
function isN(argument, argument_name, argument_number)
%% Release: 1.9

%%

global IS_DEBUG;

if isempty(IS_DEBUG) || ~IS_DEBUG
  return;
end

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

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

validateattributes(argument, {'double'}, ...
                   {'scalar', 'positive', 'integer', 'real'}, ...
                   mfilename, argument_name, argument_number);

%%


