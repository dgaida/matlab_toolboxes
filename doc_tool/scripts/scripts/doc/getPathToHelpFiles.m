%% getPathToHelpFiles
% Returns the full path to the folder 'help_mfiles'
%
function path_help= getPathToHelpFiles(toolbox_path)
%% Release: 1.3

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% check arguments

checkArgument(toolbox_path, 'toolbox_path', 'char', '1st');


%%

path_help= fullfile(toolbox_path, 'scripts', 'scripts', 'help_mfiles');

%%


