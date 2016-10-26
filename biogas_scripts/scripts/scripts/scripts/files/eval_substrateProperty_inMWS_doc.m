%% Syntax
%       [property_id, t_property]= eval_substrateProperty_inMWS(volumeflow_id,
%       volumeflow_type, property) 
%       
%% Description
% |[property_id, t_property]= eval_substrateProperty_inMWS(volumeflow_id,
% volumeflow_type, property)| 
% evaluates a substrate property |property| in the modelworkspace of 
% the <matlab:doc('bdroot') current model> using
% <matlab:doc('script_collection/evalinmws') script_collection/evalinMWS>.
% For new MATLAB versions (>= 7.11) the substrate |property| is 
% <load_file.html load_file> out of the file
% |property__volumeflow_id___volumeflow_type_.mat| which must 
% be in the current path. The flow of the |property| is returned inside the
% sructure |property_id|, which can be accessed by
% |property_id.volumeflow_id|. 
%
% During parallel simulation of models, in case of loading |property| from
% file, the file must have the structure
% |property__volumeflow_id___volumeflow_type__1.mat|. 
% Where |1| symbolizes the number of the model. Therefore, to avoid
% confusion, the 
% plant ID should not contain underscores |_| and numbers at the same time.
%
%%
% @param |volumeflow_id| : char with the id of the substrate or fermenter
% recirculation e.g. 'maize', 'manure'
%
%%
% @param |volumeflow_type| : type of volumeflow, e.g. 'const', 'random',
% etc., defined by the MAT-file |volumeflowtypes.mat|. char
%
%%
% @param |property| : char, containing the property
%
% * 'volumeflow'  : 
% * 'RFRPRL'      : parameters raw fat, raw protein, raw lipid
% * 'COD'         : parameter COD
% * ...
%
%%
% @return |property_id| : sructure containing the |property| variable,
% which can be accessed by |property_id.volumeflow_id|. 
%
%%
% @return |t_property| : sructure containing |property| time,
% which can be accessed by |t_property.volumeflow_id|. 
%
%% Example
%
%

cd( fullfile( getBiogasLibPath(), 'examples/model/Gummersbach' ) );

[property_id, t_property]= ...
        eval_substrateProperty_inMWS('maize', 'const', 'volumeflow');
      
disp(property_id)
disp(t_property)

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('script_collection/evalinmws')">
% script_collection/evalinMWS</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/getmatlabversion')">
% script_collection/getMATLABVersion</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/is_volumeflow_type')">
% biogas_scripts/is_volumeflow_type</a>
% </html>
% ,
% <html>
% <a href="load_file.html">
% load_file</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('create_volumeflow_from_source')">
% create_volumeflow_from_source</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="eval_initstate_inmws.html">
% eval_initstate_inMWS</a>
% </html>
% ,
% <html>
% <a href="assign_initstate_inmws.html">
% assign_initstate_inMWS</a>
% </html>
%
%% TODOs
% # this function is relatively new, so check it again, maybe is has to be
% changed in the future
%
%% <<AuthorTag_DG/>>


