%% install_<<toolbox_id/>>
% Install the '<<toolbox_name/>>' (<<toolbox_id/>>) Toolbox.
%
function success= install_<<toolbox_id/>>(varargin)
%% Release: 1.7

%%

error( nargchk(0, 1, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

if nargin >= 1 && ~isempty(varargin{1})
  silent= varargin{1};
  
  validateattributes(silent, {'double'}, {'scalar', 'nonnegative', 'integer', '<=', 1}, ...
                     mfilename, 'silent', 1);
else
  silent= 0;
end

%%

tool_id= '<<toolbox_id/>>';

%%

function_name= fullfile(pwd, mfilename);

if ~(( exist(function_name, 'file') == 2 ) || ( exist(function_name, 'file') == 6 ))
  error('The folder containing this function must be the <a href="matlab:doc(''pwd'')">pwd</a>!');
end

%%

success= install_tool(getNameOfToolbox(tool_id), tool_id, silent);

%%


