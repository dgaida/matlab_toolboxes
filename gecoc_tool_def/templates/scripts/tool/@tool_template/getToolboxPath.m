%% <<toolbox_id/>>/getToolboxPath
% Get entry path of the Toolbox
%
function toolbox_path= getToolboxPath()
%% Release: 1.9

%%

error( nargchk(0, 0, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

toolbox_path= fileparts(which('install_<<toolbox_id/>>.m'));

%%

if isempty(toolbox_path)
  toolbox_path= fileparts(which('install_<<toolbox_id/>>.p'));
end

%%


