%% is_onoff
% Check whether given argument is 'on' or 'off'. 
%
function is_onoff(argument, argument_name, argument_number)
%% Release: 1.4

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

validatestring(argument, {'on', 'off'}, mfilename, argument_name, argument_number);

%%


