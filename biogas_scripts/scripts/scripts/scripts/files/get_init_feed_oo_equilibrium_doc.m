%% Syntax
%       init_substrate_feed= get_init_feed_oo_equilibrium(equilibrium,
%       substrate, plant, control_horizon, delta)
%
%% Description
% |init_substrate_feed= get_init_feed_oo_equilibrium(equilibrium, substrate,
% plant, control_horizon, delta)| gets the first values of the substrate
% feed out of the given |equilibrium|. The substrate feed inside the
% |equilibrium| must either be constant or has as many steps as would be
% calculated by <matlab:doc('biogas_control/getnumsteps_tc')
% getNumSteps_Tc>, given the parameters |control_horizon| and |delta|. 
%
%% <<equilibrium/>>
%% <<substrate/>>
%% <<plant/>>
%%
% @param |control_horizon| : control horizon, measured in days
%
%%
% @param |delta| : control sampling time, measured in days
%
%%
% @return |init_substrate_feed| : matrix with as many rows as there are
% substrates and as many columns as there are digesters. 
%
%% Example
%
% 
%

% exists in MPC folder
equilibrium= load_file('equilibrium_gummersbach.mat');

[substrate, plant]= load_biogas_mat_files('gummersbach');

get_init_feed_oo_equilibrium(equilibrium, substrate, plant, 7, 1)


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('matlab/reshape')">
% matlab/reshape</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/is_equilibrium')">
% biogas_scripts/is_equilibrium</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/is_substrate')">
% biogas_scripts/is_substrate</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/is_plant')">
% biogas_scripts/is_plant</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_control/getnumsteps_tc')">
% biogas_control/getNumSteps_Tc</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('biogas_control/nmpc_tmrfcn')">
% biogas_control/NMPC_TmrFcn</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_control/startnmpcatequilibrium')">
% biogas_control/startNMPCatEquilibrium</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="matlab:doc('biogas_control/startnmpc')">
% biogas_control/startNMPC</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/get_feed_oo_equilibrium')">
% biogas_scripts/get_feed_oo_equilibrium</a>
% </html>
%
%% TODOs
% # improve documentation
% # see TODOs in file
% # check appearance of documentation
%
%% <<AuthorTag_DG/>>


