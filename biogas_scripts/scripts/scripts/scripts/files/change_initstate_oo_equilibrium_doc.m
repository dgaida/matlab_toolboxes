%% Syntax
%       initstate= change_initstate_oo_equilibrium(equilibrium, plant_id)
%       initstate= change_initstate_oo_equilibrium(equilibrium, plant_id,
%       accesstofile) 
%       
%% Description
% |initstate= change_initstate_oo_equilibrium(equilibrium, plant_id)|
% changes initstate user entries for digesters to given values in
% |equilibrium|. Loads and saves initstate struct out of different sources
% (see param |accesstofile|) and overwrites the user entries of the
% digesters with the values in |equilibrium|. 
%
%% <<equilibrium/>>
%% <<plant_id/>>
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
% 

cd( fullfile( getBiogasLibPath(), 'examples/model/Gummersbach' ) );

%%

% file does exist in biogas_control toolbox
equilibrium= load_file('equilibrium_gummersbach.mat');

% updates initstate file for user entries of digesters
change_initstate_oo_equilibrium(equilibrium, 'gummersbach', 1)


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('matlab/fieldnames')">
% matlab/fieldnames</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/isz')">
% script_collection/isZ</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/is_equilibrium')">
% biogas_scripts/is_equilibrium</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/is_plant_id')">
% biogas_scripts/is_plant_id</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/createinitstatefile')">
% biogas_scripts/createinitstatefile</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('biogas_scripts/setinitstateinworkspace')">
% biogas_scripts/setInitStateInWorkspace</a>
% </html>
% 
%% See Also
% 
% <html>
% <a href="matlab:doc('biogas_scripts/get_initstate_dig_oo_equilibrium')">
% biogas_scripts/get_initstate_dig_oo_equilibrium</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/get_initstate_outof_equilibrium')">
% biogas_scripts/get_initstate_outof_equilibrium</a>
% </html>
%
%% TODOs
% # improve documentation a little
% # check appearance of documentation
% # get_initstate_dig_oo_equilibrium is very similar
%
%% <<AuthorTag_DG/>>


