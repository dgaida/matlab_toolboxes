%% Syntax
%       save_initstate_to(initstate, plant_id)
%       save_initstate_to(initstate, plant_id, accesstofile)
%       
%% Description
% |save_initstate_to(initstate, plant_id)| saves |initstate| struct to
% different possible sinks. On default saves |initstate| to model workspace
% of currently load model. 
%
%% <<initstate/>>   %%TODO: not yet working
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

initstate= [];

save_initstate_to(initstate, 'koeln', 0)

who

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
% <a href="matlab:doc('biogas_scripts/save_varname')">
% biogas_scripts/save_varname</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/assign_initstate_inmws')">
% biogas_scripts/assign_initstate_inMWS</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('biogas_blocks/adm1de')">
% biogas_blocks/ADM1DE</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/createinitstatefile')">
% biogas_scripts/createinitstatefile</a>
% </html>
% 
%% See Also
% 
% <html>
% <a href="matlab:doc('biogas_scripts/get_initstate_outof_equilibrium')">
% biogas_scripts/get_initstate_outof_equilibrium</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/get_initstate_from')">
% biogas_scripts/get_initstate_from</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/get_initstate_dig_oo_equilibrium')">
% biogas_scripts/get_initstate_dig_oo_equilibrium</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/createnewinitstatefile')">
% biogas_scripts/createNewInitstatefile</a>
% </html>
%
%% TODOs
% # improve documentation
% # check appearance of documentation
%
%% <<AuthorTag_DG/>>


