%% Syntax
%       equilibria= simEquilibria(plant_id, indexlist, timespan)
%
%% Description
% simulates the selected equilibria out of the equilibria struct file
%
%%
% @param |plant_id| : char with the id of the plant (see plant struct)
%
%%
% @param |indexlist| : horizontal vector defining what equilibria to simulate
% in the form as used in for loops
% e.g. : [1:2:5] : simulates the 1st, 3rd and 5th equilibrium
%
%%
% @param |timespan| : duration to simulate : e.g. [0 100] simulates 100 days
%
%% Example
%
% equilibria= simEquilibria('sunderhook', [1:3], [0 50])
%
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="simbiogasplantextended.html">
% simBiogasPlantExtended</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/load_biogas_mat_files')">
% biogas_scripts/load_biogas_mat_files</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/load_biogas_system')">
% biogas_scripts/load_biogas_system</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/close_biogas_system')">
% biogas_scripts/close_biogas_system</a>
% </html>
%
% and is called by:
%
% (the user)
%
%% See Also
% 
% <html>
% <a href="matlab:doc('biogas_optimization/findoptimalequilibrium')">
% biogas_optimization/findOptimalEquilibrium</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_optimization/getinitpopofequilibria')">
% biogas_optimization/getInitPopOfEquilibria</a>
% </html>
%
%% TODOs
% # make this a real function
% # check params
% # check script
% # improve documentation
% # make an example
%
%% <<AuthorTag_DG/>>


