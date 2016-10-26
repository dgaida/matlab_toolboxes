%% Syntax
%       []= simBiogasPlantForPrediction(plant_id)
%       []= simBiogasPlantForPrediction(plant_id, parallel)
%       []= simBiogasPlantForPrediction(plant_id, parallel, nWorker)
%       simBiogasPlantForPrediction(plant_id, parallel, nWorker,
%       n_simulations) 
%       simBiogasPlantForPrediction(plant_id, parallel, nWorker,
%       n_simulations, timespan) 
%       simBiogasPlantForPrediction(plant_id, parallel, nWorker,
%       n_simulations, timespan, sample_times) 
%       simBiogasPlantForPrediction(plant_id, parallel, nWorker,
%       n_simulations, timespan, sample_times, noise_out) 
%       simBiogasPlantForPrediction(plant_id, parallel, nWorker,
%       n_simulations, timespan, sample_times, noise_out, noise_in) 
%       
%% Description
% |[]= simBiogasPlantForPrediction(plant_id)| runs the simulation model in
% a for loop with user defined, random, substrate feed. After each
% simulation data for state estimation is created using
% <createdatasetforpredictor.html createDataSetForPredictor> and saved in
% mat-files. At the end two file types do exist:
%
% * |dataset_...h_...n.mat| : dataset files containing the four measurements
% for each fermenter:
%
% * pH value inside the digester
% * CH4 content of the biogas of each digester [%]
% * CO2 content of the biogas of each digester [%]
% * biogas stream of each digester [m³/d]
%
% Furthermore it contains the substrate feeds for ach digester.
%
% For each sample time and for each noise value one file is created. 
%
% * |streams_...h.mat| : stream of 37 dimensional state vectors for each
% digester. For each sample time one file is generated. Inside this file
% there is a struct, with one field for each digester. 
%
% Another file which is created is |cutter_...h.mat|. It contains a matrix
% with as many rows as there are sampling times and as many columns as
% there are simulations. It contains the number of samples done in each
% simulation, such that later the datasets of one simulation can either be
% put into the training or validation dataset. 
%
%%
% @param |plant_id|   : char with the id of the simulation model of the
% biogas plant. The plant's id is defined in the structure |plant| and has
% to be set in the simulation model, which is
% <matlab:doc('develop_model_stepbystep') created> 
% using the toolbox's library. 
%
%%
% |[]= simBiogasPlantForPrediction(plant_id, parallel)|
%
%%
% @param |parallel| : defines how to distribute the work to a bunch of
% computers or processors to do the simulations in parallel. The standard
% value is 'none'. 
%
% * 'none'          : use one single processor, no parallel computing
% * 'multicore'     : parallel computing using a multicore processor on one
% PC.
% * 'cluster'       : using Parallel Computing Toolbox functions and MATLAB
% Distributed Computing Server on a computer cluster, such that a number of
% computers can work on the problem. (Not yet working)
%
%%
% |[]= simBiogasPlantForPrediction(plant_id, parallel, nWorker)|
%
%%
% @param |nWorker|    : number of workers to run in parallel : 
% 2 for a dual core, 4 for a quadcore, when using with 'multicore', else
% number of computers (workers) in the cluster. The standard value is 2,
% when using parallel computing, else 1.
%
%%
% @param |n_simulations| : double scalar with the number of simulations to
% perform. Default: 7
%
%%
% @param |timespan| : the duration of each simulation : e.g. [0 50] for 50
% days. Default: [0 950]. 
%
%%
% @return |[]| . nothing is returned
%
%%
% @param |sample_times| : sample times used to resample the measurement
% data. The sample time is given in hours. As a default the sample time is
% set to |[1 2 6 12]| hours. double vector. For each sample time each one
% file dataset and stream is created. 
%
%%
% @param |noise_out| : cell array of double 4d-array defining the noise
% added to the measurements of
%
% * pH value
% * ch4 content in biogas
% * co2 content in biogas
% * total biogas production
%
% Default: 
%
% |{[0, 0, 0, 0], [0.01, 0.01, 0.01, 0.01], ...
%  [0.01, 0.02, 0.02, 0.01], [0.01, 0.05, 0.05, 0.01], ...
%  [0.01, 0.05, 0.05, 0.01], [0.01, 0.1, 0.1, 0.01]}|
%
% TODO: has no effect anymore, replaced by
% parameter |noisy|.
%
%%
% @param |noise_in| : cell array of double scalar value defining the
% relative noise added to the substrate feed values. To each substrate the
% same defined error/noise is added. 
%
% Default: 
%
% |{0, 0, 0, 0, 0.01, 0.01}|
%
% TODO: has no effect anymore, replaced by
% parameter |noisy|.
%
%% Example
%
% |simBiogasPlantForPrediction('sunderhook');|
%
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="createsubstratefeedsforstateestimation.html">
% createSubstrateFeedsForStateEstimation</a>
% </html>
% ,
% <html>
% <a href="createdatasetforpredictor.html">
% createDataSetForPredictor</a>
% </html>
% ,
% <html>
% <a href="matlab:doc load_biogas_mat_files">
% load_biogas_mat_files</a>
% </html>
% ,
% <html>
% <a href="matlab:doc load_biogas_system">
% load_biogas_system</a>
% </html>
% ,
% <html>
% <a href="matlab:doc close_biogas_system">
% close_biogas_system</a>
% </html>
% ,
% <html>
% <a href="matlab:doc sim">
% sim</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="createstateestimator.html">
% createStateEstimator</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="matlab:doc('ml_tool/katz_lda')">
% ml_tool/katz_lda</a>
% </html>
% ,
% <html>
% <a href="startmethodforstateestimation.html">
% startMethodforStateEstimation</a>
% </html>
% ,
% <html>
% <a href="matlab:doc addnewrowinlatextable">
% addNewRowInLatexTable</a>
% </html>
%
%% TODOs
% # improve documentation a little bit
% # make an example
% # make TODOs, especially substrate feed generation (should be ok)
% # check code at the end of the function (TODO)
%
%% <<AuthorTag_DG/>>


