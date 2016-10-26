%% Syntax
%       success= install_tool(tool_name, tool_id)
%       install_tool(tool_name, tool_id, silent)
%
%% Description
% |success= install_tool(tool_name, tool_id)| installs the MATLAB toolbox 
% with the given |tool_name| and |tool_id|. This is done by 
% adding a couple of lines to the <matlab:edit('startup.m') |startup.m|>
% file, which is located inside the MATLAB user home
% directory <matlab:doc('userpath') |userpath|>. 
% Furthermore in MATLAB's toolbox path <matlab:doc('matlabroot')
% |matlabroot|\toolbox> a folder named |tool_id| is created 
% in which three text files are created, the first one collects all installed
% versions of the toolbox 'installed_versions.txt', the second one defines
% which toolbox to start on MATLAB start 'start_version.txt' and the third
% one saves all folders which belong to the toolbox and are set in the
% MATLAB path. Maybe this file 'path_install.txt' is needed for
% uninstallation sometimes. To avoid a new start of MATLAB the path to all
% folders of the toolbox is set directly after install, as it is done at
% every MATLAB startup in the future.
%
%%
% @param |tool_name| : char, defining the name of the toolbox to be
% installed. The given name does not matter and is just used for
% information.
%
%%
% @param |tool_id| : char, defining the ID of the toolbox to be installed.
% The ID is very important, each toolbox has a unique ID.
%
%%
% @return |success| : double scalar, 1, if toolbox was installed
% successfully, else 0.
%
%%
% |install_tool(tool_name, tool_id, silent)| lets you specify whether a
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
% This example installs the 'GECO-C Setup for MATLAB Tools' toolbox needed to
% install GECO-C MATLAB toolboxes.
%

install_tool('GECO-C Setup for MATLAB Tools', 'setup_tool', 1);


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('questdlg')">
% matlab/questdlg</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('userpath')">
% matlab/userpath</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('mkdir')">
% matlab/mkdir</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('pwd')">
% matlab/pwd</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/validateattributes')">
% matlab/validateattributes</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="install_setup_tool.html">
% install_setup_tool</a>
% </html>
%
%% See Also
%
% <html>
% <a href="setpath_tool.html">
% setpath_tool</a>
% </html>
%
%% TODOs
% # Um eine saubere Deinstallation zu ermöglichen, sollte während der
% Installation in einer Datei notiert werden, was alles installiert wurde.
% Bspw. was in den MATLAB Pfad geschrieben wurde. -> Erledigt. Ein
% Deinstallationsprogramm braucht man insbesondere deshalb, da falls der
% MATLAB Pfad vom Benutzer manuell gespeichert wird, dann ist dieser auch
% bei einem Neustart da. Insbesondere muss ein Deinstallationsprogramm nach
% dem Löschen des Pfades den Pfad auch speichern. Dann ist die Frage ob man
% das bei der Installation nicht genau so macht und die startup.m damit
% umgeht...?
% # Vielleicht muss man bei jeder Beendigung von MATLAB den Pfad zur
% aktuellen Bib löschen?
% # Die |startup.m| Datei vor der Installation von alten Installationen
% bereinigen 
%
%% Known Bugs
%
% # evtl. muss Matlab als Admin gestartet werden. Matlab kann auch
% dauerhaft als Admin gestartet werden, wenn man über rechte Maustaste auf
% das desktop icon von matlab klickt, dann auf
% Eigenschaften/Einstellungen geht und dort ein Häkchen setzt.
% # falls toolbox übers Internet heruntergeladen wird, dann kann es
% passieren, dass die dll im Unterordner c# nicht ausführbar ist, dann muss
% man mit der rechten Maustaste auf die DLL klicken und Eigenschaften
% auswählen. Unten gibt es eine Schaltfläche
% „Zulassen“, auf die geklickt werden muss und dann auf OK.   
%
%% <<AuthorTag_DG/>>


