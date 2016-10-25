%% getPathToReleaseNotes
% Returns full path to folder 'rn'
%
function path_rn= getPathToReleaseNotes(toolbox_path)
%% Release: 1.3

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% check arguments

checkArgument(toolbox_path, 'toolbox_path', 'char', '1st');


%%

path_rn= fullfile(getPathToHelpFiles(toolbox_path), 'rn');

%%


