%% Preliminaries
% # Create a new folder.
% # Inside this folder copy the simulation model of your biogas plant.
% Along with the model copy the |initstate__plant_id_.mat| and the
% |volumeflow_..._const.mat| files. 
% # Inside the model the following settings have to be taken:
%
% * Set the substrate feed and the pump flows to |user|. 
% * Better do not save the final state of the digesters, because
% simulations could get stuck in difficult states. 
% * Set the sampling rate of the sensors at least to 1 hour. The filter
% with the smallest sampling time is 12 hours, sampling time in the model may
% also be smaller then 1 hour, does not matter (would improve the result).
% 1 hour is defined by the parameter |sample_times| of the called method
% <simbiogasplantforprediction.html simBiogasPlantForPrediction>. In this
% method the parameter is set to 6 hours, so currently a value up to 6
% hours seems appropriate. 
%
% # Copy the files |substrate_network_min/max__plant_id_.mat| and
% |plant_network_min/max__plant_id_.mat| in the folder. They define the range of
% substrate feed values used in the simulations. They should span the whole
% range of possible substrate feeds. 
% # Edit the file |sensors_...xml|. The sensors for pH, biogas, Q of
% substrates, should be modelled as real sensors. Edit the drift and sensor
% noise values accordingly. 
%
% # If you want to do a lot of simulations (> 20) increase the Java Heap
% Memory (around 1 GB). 
%
%% Syntax
%       createStateEstimator(plant_id)
%       createStateEstimator(plant_id, parallel)
%       createStateEstimator(plant_id, parallel, nWorker)
%       createStateEstimator(plant_id, parallel, nWorker, nSimulations)
%       createStateEstimator(plant_id, parallel, nWorker, nSimulations,
%       timespan) 
%       createStateEstimator(plant_id, parallel, nWorker, nSimulations,
%       timespan, methods) 
%       createStateEstimator(plant_id, parallel, nWorker, nSimulations,
%       timespan, methods, do_shutdown) 
%       createStateEstimator(plant_id, parallel, nWorker, nSimulations,
%       timespan, methods, do_shutdown, mail_address) 
%       createStateEstimator(plant_id, parallel, nWorker, nSimulations,
%       timespan, methods, do_shutdown, mail_address, tasks) 
%       createStateEstimator(plant_id, parallel, nWorker, nSimulations,
%       timespan, methods, do_shutdown, mail_address, tasks, sample_times) 
%       
%% Description
% |createStateEstimator(plant_id)| creates the State Estimator for the
% given plant |plant_id|. First many simulations are done calling
% <simbiogasplantforprediction.html simBiogasPlantForPrediction> to
% create a huge dataset for training and validation and 
% then out of this data a State Estimator is learned, usually using LDA or
% Random Forest, see <startstateestimation.html startStateEstimation>. 
%
%% <<plant_id/>>
%% <<parallel/>>
%% <<nWorker/>>
%%
% @param |nSimulations| : number of simulations to run. The data recorded
% during the simulations is used to create training and validation
% datasets. Default: 7. 
%
%%
% @param |timespan| : the duration of each simulation : e.g. [0 50] for 50
% days. Default: [0 950]. 
%
%%
% @param |methods| : Machine Learning methods. Examples are: 'RF', 'LDA',
% 'GerDA'. They always must be passed in a cellstring, could also be more
% than one. Default: {'RF'}. 
%
%%
% @param |do_shutdown| : if 1, then shut down the computer at the end. Else
%: 0. Default: 0.
%
%%
% @param |mail_address| : if it is a char, then at the end of the function
% an email is send to given address. May also be a cellstr with more than
% one email address. If no mail shoild be send, then the value must be
% empty: []. Default: [].
%
%%
% @param |tasks| : cellstring with one or two elements. The contents may
% be:
% * 'sim' : do the simulations
% * 'estimate' : learn the state estimator
%
% If you only want to do one of both tasks, you can specify it using this
% parameter. E.g. {'sim'} only does the simulations. 
%
%%
% @param |sample_times| : sample times used to resample the measurement
% data. The sample time is given in hours. As a default the sample time is
% set to |{1, 2, 6, 12}| hours (default is: {6}). double cell vector. For
% each sample time each one file dataset and stream is created. 
%
%% Example
% |createStateEstimator('gummersbach');|
%
%%
% |createStateEstimator('geiger', [], [], 0, [], {'LDA'}, 0, [], {'estimate'});|
%
%%
% |createStateEstimator('geiger', [], [], 0, [], {'RF'}, 0, [], {'estimate'});|
%
%%
% |createStateEstimator('geiger', [], [], 0, [], {'LDA_PCA'}, 0, [], {'estimate'});|
%
%%
% |createStateEstimator('geiger', [], [], 0, [], {'RF_PCA'}, 0, [], {'estimate'});|
%
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="simbiogasplantforprediction.html">
% simBiogasPlantForPrediction</a>
% </html>
% ,
% <html>
% <a href="startstateestimation.html">
% startStateEstimation</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/isn')">
% script_collection/isN</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/validatestring')">
% matlab/validatestring</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/shutdown')">
% script_collection/shutdown</a>
% </html>
%
% and is called by:
%
% (the user)
%
%% See Also
% 
% <html>
% <a href="createdatasetforpredictor.html">
% createDataSetForPredictor</a>
% </html>
% ,
% <html>
% <a href="startmethodforstateestimation.html">
% startMethodforStateEstimation</a>
% </html>
%
%% TODOs
% # improve documentation
% # make a small example (maybe)
%
%% <<AuthorTag_DG/>>
%% References
%
% <html>
% <ol>
% <li> 
% Gaida, D.; Wolf, C.; Meyer, C.; Stuhlsatz, A.; Lippel, J.; Bäck, T.,
% Bongards, M.; McLoone, S.: 
% <a href="matlab:feval(@open, 
% eval('sprintf(''%s\\pdfs\\WST-EM12287R1.pdf'', 
% biogas_ml.getHelpPath())'))">
% State estimation for anaerobic digesters using the ADM1</a>, 
% in Water Science & Technology, 66.5, pp. 1088-1095, IWA, 2012. 
% </li>
% </ol>
% </html>
%


