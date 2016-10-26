%% Syntax
%       load_biogas_system(fcn)
%       load_biogas_system(fcn, parallel)
%       load_biogas_system(fcn, parallel, nWorker)
%
%% Description
% |load_biogas_system(fcn)| loads the biogas plant simulation model |fcn|,
% which was created with the library of the _Biogas Plant Modeling_
% Toolbox calling <matlab:doc('load_system') load_system>. Before that the
% model is closed to be sure that the model is closed, calling
% <matlab:doc('close_system') close_system>. 
%
%%
% @param |fcn| : char with the name of the simulation model, with or
% without the file extension '.mdl'
%
%%
% |load_biogas_system(fcn, parallel)| lets you specify how the models will
% be operated. Is only one model operated at a time or are more models
% simulated at a time using multiple workers or even computers. 
%
%%
% @param |parallel| : char, evaluate the individuals in parallel?
%
% * 'none' : single processor, no parallel computing
% * 'multicore' : parallel computing using a multicore processor on one PC
% * 'cluster' : using Parallel Computing Toolbox functions and MATLAB
% Distributed Computing Server on a computer cluster. The 'cluster' option
% is not implemented yet. 
%
% If 'multicore' is used then the models for two (or more, see |nWorkers|)
% workers are created but not loaded. The models, named plant_..._i.mdl (i
% running from 1 to ||nWorkers|, are loaded, simulated and closed by the
% workers themselves. The worker selects one of the two models dynamically. 
% It knows what model is 'free' by looking for a *.mat file with the name of
% the model, this file is created in this function. If the file exists, then
% the model is free, else it is occupied. A worker reserves the model by
% deleting this file and releases the model after the simulation by
% creating the file again, see the file 
% <matlab:doc('biogas_optimization/simbiogasplant') |simBiogasPlant|>. 
%
%%
% |load_biogas_system(fcn, parallel, nWorker)|
%
%%
% @param |nWorker| : number of workers to run in parallel : 
%
% * 2 for a dual core, 
% * 4 for a quadcore, 
% when user with 'multicore', else number of computers (workers) in the
% cluster 
%
%% Example
%
% 

cd( fullfile( getBiogasLibPath(), 'examples/model/Gummersbach' ) );

load_biogas_system('plant_gummersbach');

close_biogas_system('plant_gummersbach');


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('load_system')">
% matlab/load_system</a>
% </html>
% ,
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
% <a href="matlab:doc('validateattributes')">
% matlab/validateattributes</a>
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
% <a href="matlab:doc('adm1_analysis_reachability')">
% ADM1_analysis_reachability</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('adm1_analysis_substrate')">
% ADM1_analysis_substrate</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_optimization/findoptimalequilibrium')">
% biogas_optimization/findOptimalEquilibrium</a>
% </html>
% ,
% <html>
% ...
% </html>
%
%% See Also
%
% <html>
% <a href="matlab:edit('load_biogas_system.m')">
% edit load_biogas_system.m</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_optimization/simbiogasplant')">
% biogas_optimization/simBiogasPlant</a>
% </html>
% ,
% <html>
% <a href="close_biogas_system.html">
% close_biogas_system</a>
% </html>
%
%% TODOs
% # cluster option is not yet implemented
%
%% <<AuthorTag_DG/>>


