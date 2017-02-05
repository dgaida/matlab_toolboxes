%% Syntax
%       NMPC_create_ref_biogas_1_slave(sensors, plant)
%       NMPC_create_ref_biogas_1_slave(sensors, plant, init_sim)
%
%% Description
% |NMPC_create_ref_biogas_1_slave(sensors, plant)| creates or appends data
% to file ../ref_biogas_1_slave.mat. This script is called in subfolder
% 'mpc'. It is called after the simulation and produced methane in
% digesters is read out of |sensors|, added and resampled. The resampled
% data is saved in file '../ref_biogas_1_slave.mat'. 
%
%% <<sensors/>>
%% <<plant/>>
%%
% @param |init_sim| : 0 or 1
%
% * 0 : default. The complete resampled methane production stream is
% appended at end of file '../ref_biogas_1_slave.mat'. 
% * 1 : when called after initial simulation, then last methane production
% value (at the end of the simulation) is written inside file
% '../ref_biogas_1_slave.mat' at times -50 and -1. 
%
%% Example
%
% # do simulation
% # call function
% # clean up



%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('matlab/interp1')">
% matlab/interp1</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/save_varname')">
% script_collection/save_varname</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/is0or1')">
% script_collection/is0or1</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/is_plant')">
% biogas_scripts/is_plant</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/is_sensors')">
% biogas_scripts/is_sensors</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/load_file')">
% biogas_scripts/load_file</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('biogas_control/startnmpcatequilibrium')">
% biogas_control/startNMPCatEquilibrium</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="matlab:doc('biogas_control/change_bounds_substrate_stock')">
% biogas_control/change_bounds_substrate_stock</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_gui/gui_nmpc')">
% biogas_gui/gui_nmpc</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_control/startnmpc')">
% biogas_control/startNMPC</a>
% </html>
%
%% TODOs
% # check appearance of documentation
% # improve documentation
% # maybe add example
% # check if function works correctly
%
%% <<AuthorTag_DG/>>


