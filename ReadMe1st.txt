MATLAB Toolbox for Simulation, Control & Optimization of Biogas Plants
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
Steinmüllerallee 1
D-51643 Gummersbach
GECO-C Team, 18.06.2014
Contact: 
http://geco.web.fh-koeln.de/
daniel.gaida@fh-koeln.de



INSTALLATION:
_____________

1. Unzip the rar file in a folder of your choice.
   
2. Start MATLAB r2010a or later (as Administrator). Set the chosen folder 
   (containing the toolbox) to the 'Current Directory' ('Current Folder'). 
   
3. In the 'Command Window' type

   install_biogaslibrary_full()

   and call the function while pressing Enter. During the installation process
   you will have to select the folder to the tool 'gecoc_tool_def_1.1', which is 
   located in the rar file as well: '.../gecoc_tool_def_1.1'. 
   All toolboxes will be installed. 
   
   If you get an error, make sure that you have administrator rights on the computer.
   
4. To see the help files of the toolboxes call "doc" or press F1. On the left side
   in the help you find the entry 'Biogas Plant Modeling'. There you will find
   a "Getting Started" section and all other help files.
   The entries 'GECO-C ...' in the help belong to the other toolboxes used by the 
   'Biogas Plant Modeling' toolbox. From MATLAB 2012b onwards the online help 
   for this toolbox is not working anymore. 

5. To start a simulation of a biogas plant, change into the subfolder 
   '.../biogaslibrary/examples/model/Gummersbach' and open the model 
   'plant_gummersbach.mdl' in Simulink. Start the simulation.

6. After the simulation is finished and before you close the model you can
   call the GUI 'gui_sensors' to display graphs of process values that were 
   recorded during the simulation. 


