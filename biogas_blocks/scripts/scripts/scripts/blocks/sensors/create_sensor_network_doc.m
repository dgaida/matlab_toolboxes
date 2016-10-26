%% Syntax
%       sensors= create_sensor_network(plant, substrate, plant_network,
%       plant_network_max) 
%       sensors= create_sensor_network(plant_id) 
%       
%% Description
% |sensors= create_sensor_network(plant, substrate)| creates network of
% sensors, which are inside the simulation model. Calls the C# method
% |biogas.sensors.create_sensor_network|. After a simulation you can
% visualize the measured values using the GUI
% <matlab:doc('biogas_gui/gui_sensors') biogas_gui/gui_sensors>. 
%
%% <<plant/>>
%
%% <<substrate/>>
%
%% <<plant_network/>>
%
%% <<plant_network_max/>>
%
%%
% @param |plant_id| : ID of the plant, char.
%
%%
% @return |sensors| : object of C# class |biogas.sensors|. Contains all
% sensors which are installed inside the model. 
%
%% Example
%
%

[substrate,             plant, ...
 substrate_network,     plant_network, ...
 substrate_network_min, substrate_network_max, ...
     plant_network_min, plant_network_max]= load_biogas_mat_files('gummersbach');

sensors= create_sensor_network(plant, substrate, plant_network, plant_network_max);

disp(sensors);


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('biogas_scripts/is_plant')">
% biogas_scripts/is_plant</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/is_substrate')">
% biogas_scripts/is_substrate</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/is_plant_network')">
% biogas_scripts/is_plant_network</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/load_biogas_mat_files')">
% biogas_scripts/load_biogas_mat_files</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('convertarray')">
% NET.convertArray</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('biogas_blocks/init_biogas_plant_mdl')">
% biogas_blocks/init_biogas_plant_mdl</a>
% </html>
%
%% See Also
%
% <html>
% <a href="matlab:doc('biogas_gui/gui_sensors')">
% biogas_gui/gui_sensors</a>
% </html>
%
%% TODOs
% # check appearance of documentation
% # improve documentation
% # muss vor erstellung eines modells aufgerufen werden. in dokumentation
% an entsprechender stelle erwähnen. deeshalb methode erweitern, dass nur
% plant_id übergeben werden muss. in dem fall evtl. auch zurückgeegebenes
% objekt direkt in xml datei speichern
%
%% <<AuthorTag_DG/>>


