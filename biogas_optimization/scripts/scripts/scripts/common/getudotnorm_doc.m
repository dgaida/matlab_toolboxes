%% Syntax
%       udotnorm= getudotnorm(substrate, sensors, t)
%       udotnorm= getudotnorm(substrate, sensors, t, init_substrate_feed)
%       
%% Description
% |udotnorm= getudotnorm(substrate, sensors, t)| returns 1/T * int ( || u'(t)
% ||_2^2 ) dt, where u(t) is the substrate feed of the biogas plant. The
% function may only be called after a simulation, because of |sensors|. The
% integral is calculated over the time domain given by |t|. At the
% end the calculated value is divided by the simulation duration (duration
% of the integral) T= max(t) - min(t), respectively. 
%
%% <<substrate/>>
%% <<sensors/>>
%%
% @param |t| : time vector returned by the simulation. 
%
%%
% @return |udotnorm| : 1/T * int ( || u'(t) ||_2^2 ) dt
%
%%
% @param |init_substrate_feed| : this is the initial substrate feed of the
% plant, before the simulation is started. This is needed to calculate the
% change of the substrate feed from the initial to the one first applied to
% the plant. If this is unknown, it is assumed, that the feed which is
% applied in the beginning of the simulation is equal to the initial feed.
% It is in the responsibility of the user to assure this, otherwise the
% returned value of this function will not be exact. It is a double matrix
% with number of rows equal to the substrates and number of columns equal
% to number of digesters. The values are the feeds meaaured in m³/d. If the
% plant has only one digester or one substrate, then it does not matter,
% whether a column or row vector is passed to the function. 
%
%% Example
%
%

cd( fullfile( getBiogasLibPath(), 'examples/model/Gummersbach' ) );

[substrate, plant, plant_network, plant_network_max]= ...
  load_biogas_mat_files('gummersbach', [], {'substrate', 'plant', ...
  'plant_network', 'plant_network_max'});

volumeflows= get_volumeflows_from(substrate, 'const', 1);

%%

sensors= create_sensor_network(plant, substrate, plant_network, ...
     plant_network_max);

fields= fieldnames(volumeflows);

for isubstrate= 1:numel(fields)
  
  substrate_id= fields{isubstrate};
  
  time= volumeflows.(substrate_id)(1,:);
  volumeflow= volumeflows.(substrate_id)(2,:);
  
  sensors= write_volumeflow_in_sensors(sensors, time, volumeflow, substrate_id);

end

%%

getudotnorm(substrate, sensors, [0:0.5:10], [])

%%

getudotnorm(substrate, sensors, [0:0.5:10], [15 15 5; 0 0 0]')

%%

getudotnorm(substrate, sensors, [0:1:20], [15 15 5; 0 0 0]')

%%

getudotnorm(substrate, sensors, [5:1:15], [15 15 5; 0 0 0]')

%%

getudotnorm(substrate, sensors, [45:1:55], [15 15 5; 0 0 0]')

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc script_collection/checkargument">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/is_sensors">
% biogas_scripts/is_sensors</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_scripts/is_substrate">
% biogas_scripts/is_substrate</a>
% </html>
% ,
% <html>
% <a href="matlab:doc data_tool/deleteduplicates">
% data_tool/deleteDuplicates</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/interp1">
% matlab/interp1</a>
% </html>
% ,
% <html>
% <a href="matlab:doc matlab/diff">
% matlab/diff</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc biogas_optimization/getrecordedfitnessextended">
% biogas_optimization/getRecordedFitnessExtended</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="matlab:doc biogas_optimization/getxdotnorm">
% biogas_optimization/getxdotnorm</a>
% </html>
% ,
% <html>
% <a href="matlab:doc biogas_optimization/getrecordedfitness">
% biogas_optimization/getRecordedFitness</a>
% </html>
%
%% TODOs
% # improve documentation a little bit
% # add code documentation
% # make TODOs
%
%% <<AuthorTag_DG/>>


