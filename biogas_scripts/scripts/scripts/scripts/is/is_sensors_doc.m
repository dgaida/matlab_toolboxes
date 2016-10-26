%% Syntax
%       is_sensors(argument, argument_number)
%
%% Description
% |is_sensors(argument, argument_number)| checks if the given
% |argument| is an object of the C# class |biogas.sensors|. If it is not,
% an error is thrown. The |argument| is the |argument_number| th argument
% of the calling function. 
%
%%
% @param |argument| : The argument that will be checked. Should be an
% object of the C# class |biogas.sensors|. 
%
%%
% @param |argument_number| : char with the ordinal number of the given
% argument, so its position in the calling function. Should be in between
% '1st' and '15th'. May also be a positive integer value. If it is, then
% during output a 'th' is appended after the number. 
%
%% Example
% 
% This call is ok

[substrate,             plant, ...
 substrate_network,     plant_network, ...
 substrate_network_min, substrate_network_max, ...
     plant_network_min, plant_network_max]= load_biogas_mat_files('gummersbach');

sensors= create_sensor_network(plant, substrate, plant_network, plant_network_max);

is_sensors(sensors, 4)

%%
% The next call throws an error

try
  is_sensors([0 1], '1st')
catch ME
  disp(ME.message)
end

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc script_collection/checkargument">
% script_collection/checkArgument</a>
% </html>
%
% and is called by:
%
% (all functions)
%
%% See Also
% 
% <html>
% <a href="matlab:doc biogas_blocks/create_sensor_network">
% biogas_blocks/create_sensor_network</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/is_substrate">
% biogas_scripts/is_substrate</a>
% </html>
% ,
% <html>
% <a href="matlab:doc validateattributes">
% matlab/validateattributes</a>
% </html>
%
%% TODOs
% # create documentation of script file
% # check documentation
%
%% <<AuthorTag_DG/>>


