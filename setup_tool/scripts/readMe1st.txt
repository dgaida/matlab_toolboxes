GECO-C Setup for MATLAB Tools
Copyright (C) 2014  Daniel Gaida

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.



Fachhochschule Köln (Campus Gummersbach)
Cologne University of Applied Sciences
Department of Automation & Industrial IT
GECO-C Team
Steinmuellerallee 1
51643 Gummersbach

Gummersbach, 18.06.2014

Contact: 
http://geco.web.fh-koeln.de/
daniel.gaida@fh-koeln.de

Hinweise zu 'GECO-C Setup for MATLAB Tools', v1.1



DEPENDENCIES:
_____________

This toolbox uses

- gecoc_tool_def (GECO-C MATLAB Tools Definition)
- script_collection (GECO-C MATLAB Script Collection) (TODO: Really???)
- doc_tool (GECO-C Documentation for MATLAB Tools)

The first two should be installed afterwards, the latter one is only needed to 
create the documentation. As the documentation is shipped with this toolbox, doc_tool
only is needed for developers.



INSTALLATION [ENGLISH]:
_______________________

1. Create a folder named 'setup_tool' in the 'toolbox' folder of your MATLAB 
   installation (e.g.: 'C:/Programme/MATLAB/R2009a/toolbox'). Copy the 'setup_tool' 
   folder into this folder.
   
2. Start MATLAB. Choose the created 'setup_tool/setup_tool' folder as the 
   'Current Directory', so as an example: 
   'C:/Programme/MATLAB/R2009a/toolbox/setup_tool/setup_tool'. 
   
3. In the 'Command Window' type

   install_setup_tool()

   and call the function while pressing Enter. If you get the message  
   
   'The 'GECO-C Setup for MATLAB Tools' Toolbox was successfully installed. 
   Installation completed!'
   
   the toolbox was installed successfully. 

4. To see the help files of this toolbox call "doc" or press F1. On the left side
   in the help you find the entry 'GECO-C Setup for MATLAB Tools'. There you will find
   a "Getting Started" section and all other help files.



INSTALLATION [DEUTSCH]:
_____________

1. Kopieren Sie den Ordner 'setup_tool' an den Ort Ihrer Wahl. Ein guter Ort 
   wäre z.B. der toolbox Ordner Ihrer MATLAB Installation. Dieser Ort 
   könnte bspw. den Pfad 'C:/Programme/MATLAB/R2009a/toolbox'
   haben, abhängig von Ihrem MATLAB-Installationspfad. Am Besten erstellen 
   Sie dort einen Ordner mit dem Namen 'setup_tool' und kopieren den 
   Ordner 'setup_tool' in den Ordner hinein.

2. Starten Sie MATLAB. Wählen Sie im Feld 'Current Directory' 
   (je nach MATLAB Version: 'Current Folder') den so eben 
   erstellten Pfad zur Biogas Bibliothek aus, hier wäre das: 
   'C:/Programme/MATLAB/R2009a/toolbox/setup_tool/setup_tool'.

3. Geben Sie im 'Command Window' 

	install_setup_tool()

   ein und bestätigen Sie mit Enter. Wenn Sie die Nachricht 
   'The 'GECO-C Setup for MATLAB Tools' Toolbox was successfully installed. 
   Installation completed!' erhalten, 
   haben Sie die Toolbox erfolgreich installiert.



Bedienungsanleitung:
____________________

Die Bedienungsanleitung ist in der MATLAB Hilfe integriert. Nach der Installation
dieser Toolbox erhalten Sie die Hilfe in dem Sie MATLAB starten und die Hilfe
öffnen (doc oder F1). Dort finden Sie in der Liste links einen Eintrag 
'GECO-C Setup for MATLAB Tools'.


