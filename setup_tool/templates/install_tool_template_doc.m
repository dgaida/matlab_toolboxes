%% Syntax
%       success= install_<<toolbox_id/>>()
%       install_<<toolbox_id/>>(silent)
%
%% Description
% |install_<<toolbox_id/>>()| installs the _<<toolbox_name/>>_ Toolbox,
% calling <matlab:doc('install_tool') setup_tool/install_tool>. The ID of
% this toolbox is |<<toolbox_id/>>|. The folder containing this function
% must be the <matlab:doc(''pwd'') pwd>, otherwise an error is thrown. For
% more informations about the installation process have a look at:
% <matlab:doc('install_tool') setup_tool/install_tool>. 
%
%%
% @return |success| : double scalar, 1, if toolbox was installed
% successfully, else 0.
%
%%
% |install_<<toolbox_id/>>(silent)| lets you specify whether a
% <matlab:doc('questdlg') questdlg> should be shown before installation
% asking if the tool should be installed or not.
%
%%
% @param |silent| : double scalar
%
% * 0 : before installation visualize a <matlab:doc('questdlg') questdlg>
% asking if the tool should be installed (default)
% * 1 : not asking whether the toolbox should be installed, just install
% it. Useful if a couple of toolboxes one after the other have to be
% installed. 
%
%% Example
% 
% This example installs the _<<toolbox_name/>>_ Toolbox.
%

install_<<toolbox_id/>>(1);


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('setup_tool/install_tool')">
% setup_tool/install_tool</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('pwd')">
% matlab/pwd</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('fullfile')">
% matlab/fullfile</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('exist')">
% matlab/exist</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('mfilename')">
% matlab/mfilename</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('setup_tool/getnameoftoolbox')">
% setup_tool/getNameOfToolbox</a>
% </html>
%
% and is called by:
%
% (the user)
%
%% See Also
%
% <html>
% <a href="matlab:doc('setpath_tool')">
% setup_tool/setpath_tool</a>
% </html>
% ,
% <html>
% <a href="setpath_<<toolbox_id/>>.html">
% setpath_<<toolbox_id/>></a>
% </html>
% ,
% <html>
% <a href="matlab:doc('existMPfile')">
% script_collection/existMPfile</a>
% </html>
%
%% TODOs
% 
%
%% Known Bugs
%
% 
%% <<AuthorTag_DG/>>


