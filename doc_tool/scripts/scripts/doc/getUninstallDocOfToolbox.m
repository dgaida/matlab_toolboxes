%% getUninstallDocOfToolbox
% Returns the documentation to uninstall a toolbox, as is visualized in html
% help file
%
function uninstallDoc= getUninstallDocOfToolbox(toolbox)
%% Release: 1.3

%%

error( nargchk(1, 1, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%
% check arguments

checkArgument(toolbox, 'toolbox', 'gecoc_tool', '1st');


%%

toolName= toolbox.getToolboxName();
%toolID=   toolbox.getToolboxID();


%%

uninstallDoc= ...
  { '%% Uninstallation', ...
    sprintf('%% # To uninstall the Toolbox ''%s'' ... TODO!!!', toolName), ...
    '% At the moment it is not yet possible to uninstall GECO-C toolboxes properly. ', ...
    '% At the moment just delete the entry of the toolbox inside the |startup.m| file. ', ...
    '% After a new start of MATLAB make sure that the path to the toolbox is not set ', ...
    '% anymore!', ...
    '', ...
    '' }';

%%



%%


