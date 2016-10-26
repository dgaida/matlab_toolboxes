%% Preliminaries
% # The simulation model of the biogas plant must be loaded.
% # The name of the ADM1 block inside the block 'with gui' must be named: 
% 'combi - ADM1xp digester'. This is true by default.
%
%% Syntax
%       setSaveStateofADM1Blocks(fcn, value)
%
%% Description
% |setSaveStateofADM1Blocks(fcn, value)| sets the savestate checkbox on
% the gui of the 'ADM1 with gui block' in the model |fcn| to the given
% |value|. If you set |value| to 'on', then the final state of the ADM1
% models inside the model is saved at the end of the simulation. If you set
% |value| to 'off', then the final state is disregarded. 
%
%%
% @param |fcn| : char containing the name of the simulation model with or
% without file extension, e.g. 'plant_gummersbach' or
% 'plant_gummersbach.mdl'. 
%
%%
% @param |value| : char
%
% * 'on' : to set (check) the checkbox
% * 'off' : to uncheck the checkbox
%
%% Example
%
%

cd( fullfile( getBiogasLibPath(), 'examples/model/Gummersbach' ) );

load_biogas_system('plant_gummersbach');

setSaveStateofADM1Blocks('plant_gummersbach', 'off');

close_biogas_system('plant_gummersbach');


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('script_collection/getmatlabversion')">
% script_collection/getMATLABVersion</a>
% </html>
% ,
% <html>
% <a href="matlab:doc find_system">
% matlab/find_system</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('validateattributes')">
% matlab/validateattributes</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('get_param')">
% matlab/get_param</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('set_param')">
% matlab/set_param</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('biogas_control/nonlinearmpc')">
% biogas_control/nonlinearMPC</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_control/biogasepisode')">
% biogas_control/biogas.optimization.biogasRLearner.biogasEpisode</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('adm1_analysis_reachability')">
% ADM1_analysis_reachability</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="load_biogas_system.html">
% load_biogas_system</a>
% </html>
% ,
% <html>
% <a href="close_biogas_system.html">
% close_biogas_system</a>
% </html>
%
%% TODOs
% 
%
%% <<AuthorTag_DG/>>

    
    