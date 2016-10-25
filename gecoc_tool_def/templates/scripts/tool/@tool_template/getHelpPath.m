%% <<toolbox_id/>>/getHelpPath
% Get path to the folder in which the help of the Toolbox is located
%
function help_path= getHelpPath()
%% Release: 1.9

%%

error( nargchk(0, 0, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

help_path= fullfile(<<toolbox_id/>>.getToolboxPath(), 'help', '<<toolbox_id/>>');


%%


