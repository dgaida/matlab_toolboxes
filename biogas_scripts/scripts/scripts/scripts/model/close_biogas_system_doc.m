%% Syntax
%       close_biogas_system(fcn)
%       
%% Description
% |close_biogas_system(fcn)| closes the biogas plant simulation model
% |fcn|, which was created with the library of the _Biogas Plant Modeling_
% Toolbox. To do this it saves and closes the biogas plant simulation
% model |fcn|. If the model can not be closed, then an error is thrown. 
%
%%
% @param |fcn| : char, the name of the simulation model, with or without
% the file extension '.mdl'
%
%% Example
%
% 

cd( fullfile( getBiogasLibPath(), 'examples/model/Gummersbach' ) );

load_biogas_system('plant_gummersbach');

close_biogas_system('plant_gummersbach');

clear;


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('save_system')">
% matlab/save_system</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('close_system')">
% matlab/close_system</a>
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
% <a href="matlab:doc('adm1_analysis_substrate')">
% ADM1_analysis_substrate</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_calibration/calib_steadystatecalc')">
% biogas_calibration/calib_SteadyStateCalc</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_optimization/findoptimalequilibrium')">
% biogas_optimization/findOptimalEquilibrium</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_control/nonlinearmpc')">
% biogas_control/nonlinearMPC</a>
% </html>
% ,
% <html>
% ...
% </html>
%
%% See Also
%
% <html>
% <a href= "matlab:edit('close_biogas_system.m')">
% edit close_biogas_system.m</a>
% </html>
% ,
% <html>
% <a href="load_biogas_system.html">
% load_biogas_system</a>
% </html>
%
%% TODOs
% 
%
%% <<AuthorTag_DG/>>


