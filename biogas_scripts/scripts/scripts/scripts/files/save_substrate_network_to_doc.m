%% Syntax
%       save_substrate_network_to(substrate_network, plant_id)
%       save_substrate_network_to(substrate_network, plant_id, accesstofile)
%       
%% Description
% |save_substrate_network_to(substrate_network, plant_id)| saves
% |substrate_network| array to different possible sinks. On default saves
% |substrate_network| to model workspace of currently load model. 
%
%% <<substrate_network/>>
%%
% @param |plant_id| : char with the id of the simulation model of the
% biogas plant. The plant's id is defined in the object |plant| and has 
% to be set in the simulation model, which is
% <matlab:doc('develop_model_stepbystep') created> 
% using the toolbox's library. 
%
%%
% @param |accesstofile| : double scalar
%
% * 1 : if 1, then really save data to a file, 
% * 0 : if set to 0, then data isn't saved to a file, but is saved to the 
% base workspace (better for optimization purpose -> speed)
% * -1 : if it is -1, then save data not to the workspace but to the model
% workspace, that's the default value. On new MATLAB versions (>= 7.11)
% the data is not assigned to the modelworkspace anymore but also saved 
% to a file (see e.g. <matlab:doc(assign_initstate_inmws')
% assign_initstate_inMWS>). 
%
%% Example
%
% 

substrate_network= [];

save_substrate_network_to(substrate_network, 'koeln', 0)

disp(substrate_network)


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('matlab/assignin')">
% matlab/assignin</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/save')">
% matlab/save</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/getmatlabversion')">
% script_collection/getMATLABVersion</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/assigninmws')">
% script_collection/assigninMWS</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('biogas_optimization/setnetworkfluxinworkspace')">
% biogas_optimization/setNetworkFluxInWorkspace</a>
% </html>
% 
%% See Also
% 
% <html>
% <a href="matlab:doc('biogas_scripts/save_initstate_to')">
% biogas_scripts/save_initstate_to</a>
% </html>
%
%% TODOs
% # improve documentation
% # check appearance of documentation
% # improve script, save_initstate_to is very similar, maybe possible to
% merge both
%
%% <<AuthorTag_DG/>>


