%% Syntax
%       [q_id, t_q]= create_volumeflow_from_source(volumeflow_id, vol_type,
%       datasource_type) 
%
%% Description
% |[q_id, t_q]= create_volumeflow_from_source(volumeflow_id, vol_type,
% datasource_type)| sets 
% the field |volumeflow_id| of the structure |t_q| and |q_substrate|. 
% The field is specified by |volumeflow_id| and the
% data is load from the source specified by |datasource_type| and
% |vol_type|.
%
%%
% @param |volumeflow_id| : char with the id of the volumeflow, e.g.
% 'maize', 'manure'
%
%%
% @param |vol_type| : type of volumeflow, e.g. 'const', 'random',
% etc., defined by the MAT-file |volumeflowtypes.mat|. char
%
%%
% @param |datasource_type| : source of the data to be set, e.g. 'file',
% 'workspace', etc., defined by the MAT-file |datasourcetypes.mat|. char
% 
%% Example
% 
%

cd( fullfile( getBiogasLibPath(), 'examples/model/Gummersbach' ) );

[q_id, t_q]= create_volumeflow_from_source('maize', 'const', 'file')


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('biogas_scripts/load_file')">
% biogas_scripts/load_file</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/is_volumeflow_type')">
% biogas_scripts/is_volumeflow_type</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/is_datasource_type')">
% biogas_scripts/is_datasource_type</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/eval_substrateproperty_inmws')">
% biogas_scripts/eval_substrateProperty_inMWS</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('biogas_blocks/createadmstreammix')">
% biogas_blocks/createADMstreamMix</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_blocks/pump_stream')">
% biogas_blocks/pump_stream</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="matlab:doc('biogas_blocks/substrate_mixer_digester_loadfcn')">
% biogas_blocks/substrate_mixer_digester_loadfcn</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/getmatlabversion')">
% script_collection/getMATLABVersion</a>
% </html>
%
%% TODOs
% # If |datasource_type == extern|, dann wird nichts in |t_q| and
% |q_substrate| geschrieben, ist das richtig?
% # improve documentation
% # check code
%
%% <<AuthorTag_DG/>>


