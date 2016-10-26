%% Syntax
%       sensorlist= get_sensorlist()
%       sensorlist= get_sensorlist(sensors)
%       
%% Description
% |sensors= get_sensorlist(sensors)| returns list of sensor ids in
% |sensors| object as cell array. If |sensors| is not gien or empty, then
% the sensor network for plant 'gummersbach' is created. 
%
%% <<sensors/>>
%%
% @return |sensorlist| : cell array with list of sensor ids.
%
%% Example
%
%

sensorlist= get_sensorlist();

disp(sensorlist)


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('biogas_scripts/is_sensors')">
% biogas_scripts/is_sensors</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_blocks/create_sensor_network')">
% biogas_blocks/create_sensor_network</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/conv_array2cell')">
% script_collection/conv_Array2cell</a>
% </html>
% 
% and is called by:
%
% <html>
% <a href="matlab:doc('biogas_gui/gui_sensors')">
% biogas_gui/gui_sensors</a>
% </html>
%
%% See Also
%
% <html>
% <a href="matlab:doc('biogas_blocks/sensor_data')">
% biogas_blocks/sensor_data</a>
% </html>
%
%% TODOs
% # check appearance of documentation
% # improve documentation
%
%% <<AuthorTag_DG/>>


