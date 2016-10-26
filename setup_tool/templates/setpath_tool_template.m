%% setpath_<<toolbox_id/>>
% Set or remove the path to the _<<toolbox_name/>>_ (<<toolbox_id/>>)
% Toolbox. 
%
function setpath_<<toolbox_id/>>(tool_path, varargin)
%% Release: 1.7

%%

error( nargchk(1, 4, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

setpath_tool(tool_path, varargin{:});


%%


