%% set_sensors_sampling_time
% Sets sampling_time in sensors xml file, loads and saves the file
%
function sensors= set_sensors_sampling_time(plant_id, sampling_time)
%% Release: 1.3

%%

error( nargchk(2, 2, nargin, 'struct') );
error( nargoutchk(0, 1, nargout, 'struct') );

%%

checkArgument(plant_id, 'plant_id', 'char', '1st');
isR(sampling_time, 'sampling_time', 2, '+');

%%

plant= load_biogas_mat_files(plant_id, [], 'plant');


%% 

file_path= get_path2xml_configfile(plant_id, 'sensors_%s.xml');

%%

sensors= biogas.sensors(file_path, plant);

%%

sensors.sampling_time= sampling_time;

%% 

sensors.saveAsXML( sprintf('sensors_%s.xml', plant_id) );

%%


