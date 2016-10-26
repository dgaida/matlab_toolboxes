%% Syntax
%       sensors= write_volumeflow_in_sensors(sensors, time, volumeflow,
%       substrate_id) 
%
%% Description
% |sensors= write_volumeflow_in_sensors(sensors, time, volumeflow,
% substrate_id)| writes feed |volumeflow| for given |substrate_id| into
% |sensors| object. 
%
%% <<sensors/>>
%%
% @param |time| : double time vector, measured in days. 
%
%%
% @param |volumeflow| : double vector of volumetric flowrate  in m³/d
% 
%%
% @param |substrate_id| : id of substrate
%
%%
% @return |sensors| : 
%
%% Example
% 
%



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
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('biogas_blocks/createadmstreammix')">
% biogas_blocks/createADMstreamMix</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="matlab:doc('biogas_blocks/substrate_mixer_digester_loadfcn')">
% biogas_blocks/substrate_mixer_digester_loadfcn</a>
% </html>
%
%% TODOs
% # improve documentation
% # check code
%
%% <<AuthorTag_DG/>>


