%% Syntax
%       initstate= get_initstate_from(plant_id)
%       initstate= get_initstate_from(plant_id, accesstofile)
%       
%% Description
% |initstate= get_initstate_from(plant_id)| gets |initstate| struct from
% different possible sources. As default from the model workspace of the
% currently load model, see parameter |accesstofile|. 
%
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
% * 1 : if 1, then really load data from a file, 
% * 0 : if set to 0, then data isn't load from a file, but is load from the 
% base workspace (better for optimization purpose -> speed)
% * -1 : if it is -1, then load data not from the workspace but to the model
% workspace, that's the default value. On new MATLAB versions (>= 7.11)
% the data is not evaluated in the modelworkspace anymore but also load 
% from a file (see e.g. <matlab:doc(eval_initstate_inmws')
% eval_initstate_inMWS>). 
%
%%
% @return |initstate| : struct containing the initial states for all blocks
% in the simulation model. 
%
%% Example
%
% load from base workspace, seems to be existent in the base workspace
% because of another function called earlier

get_initstate_from('gummersbach', 0)

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('matlab/evalin')">
% matlab/evalin</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/load_file')">
% biogas_scripts/load_file</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/eval_initstate_inmws')">
% biogas_scripts/eval_initstate_inMWS</a>
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
% <a href="matlab:doc('biogas_optimization/savestateinequilibriumstruct')">
% biogas_optimization/saveStateInEquilibriumStruct</a>
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
% <a href="matlab:doc('biogas_scripts/save_initstate_to')">
% biogas_scripts/save_initstate_to</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/is_initstate')">
% biogas_scripts/is_initstate</a>
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


