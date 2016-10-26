%% Syntax
%       initstate= createinitstatefile_plant(type, plant_id)
%       initstate= createinitstatefile_plant(type, plant_id, user_state)
%       initstate= createinitstatefile_plant(type, plant_id, user_state,
%       accesstofile) 
%
%% Description
% |initstate= createinitstatefile_plant(type, plant_id)| creates the
% initial state file for all state-dependent blocks in the 
% biogas library, respectively in the actual model. First, if existent, the
% file is load (on default: from the modelworkspace), then parts of it (all
% fermenter) are 
% overwritten and then saved (on default: in the modelworkspace) again, see
% parameter |accesstofile|. For new MATLAB versions (>= 7.11) the
% modelworkspace may not be written and evaluated during runtime anymore,
% so then |initstate| is load and saved from file. For more informations on
% this particular issue see the functions:
% <eval_initstate_inmws.html eval_initstate_inMWS> and
% <assign_initstate_inmws.html assign_initstate_inMWS>. If
% |initstate| does not exist in the specified location a
% <matlab:doc('warning') warning> is thrown, but no error.
%
%%
% @param |type| : type of initial state (char):
%
% * 'random'  : random state, a random state is created and written inside
% the |initstate| variable
% * 'default' : default state, the default state is written inside the
% |initstate| variable 
% * 'user'    : user defined state, the given |user_state| is written into
% the |initstate| variable 
%
%% <<plant_id/>>
%%
% @return |initstate| : the new initstate structure containing the double
% column vectors containing the initial states 
% which were saved inside the structure at the given locations. 
%
%%
% |createinitstatefile_plant(type, plant_id, user_state)| lets you
% specify the state vector for the to be set digesters. 
%
%%
% @param |user_state| : double matrix, 
% this parameter is only used if |type| == 'user'. It is the 
% initial state vector defined by the user for all digesters. Number of
% columns must be equal to number of digesters. number of rows equal to
% dimension of state vector. 
%
%%
% |createinitstatefile_plant(type, plant_id, user_state, accesstofile)|
% lets you specify different locations instead of the
% <matlab:doc('simulink.modelworkspace') modelworkspace>. 
%
%%
% @param |accesstofile| : double scalar
%
% * 1, then really load and save the state from/to a file
% * 0, then the state isn't load/saved from/to a file, but is, as always, 
% returned by the function (good for optimization purpose -> speed) and
% load/saved from/to the base workspace (even better for optimization
% purpose -> speed) 
% * -1, then the state is load/saved from/to the model workspace (default).
% In the newest MATLAB versions, from 7.11 on, it is not allowed anymore to 
% save into the modelworkspace while the model is running. So then we
% also load and save from/to a file using
% <eval_initstate_inmws.html eval_initstate_inMWS> and 
% <assign_initstate_inmws.html assign_initstate_inMWS>.
%
%% Example
% 
% Create an |initstate| variable in the base workspace. The 'user' field of
% the two digesters of the plant with the ID 'gummersbach' are overwritten
% by the default state.
%

createinitstatefile_plant('user', 'gummersbach', ...
                    repmat(double(biogas.ADMstate.getDefaultADMstate())', 1, 2), ...
                    0)

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="createinitstatefile.html">
% createinitstatefile</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/isz')">
% script_collection/isZ</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/validatestring')">
% matlab/validatestring</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/load_biogas_mat_files')">
% biogas_scripts/load_biogas_mat_files</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('biogas_optimization/simbiogasplantbasic_xu')">
% biogas_optimization/simBiogasPlantBasic_xu</a>
% </html>
%
%% See Also
%
% <html>
% <a href="matlab:doc('biogas_scripts/createnewinitstatefile')">
% biogas_scripts/createNewInitstatefile</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/eval_initstate_inmws')">
% biogas_scripts/eval_initstate_inMWS</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/assign_initstate_inmws')">
% biogas_scripts/assign_initstate_inMWS</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/get_initstate_from')">
% biogas_scripts/get_initstate_from</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/save_initstate_to')">
% biogas_scripts/save_initstate_to</a>
% </html>
% ,
% <html>
% <a href="createvolumeflowfile.html">
% createvolumeflowfile</a>
% </html>
%
%% TODOs
% # create documentation for script file
% # improve documentation a little
% # check appearance of documentation
%
%% <<AuthorTag_DG/>>


