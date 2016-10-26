%% Syntax
%       createSubstrateFeedsForStateEstimation(substrate,
%       substrate_network_min, substrate_network_max, plant, plant_network,
%       plant_network_min, plant_network_max, timespan, varname) 
%       createSubstrateFeedsForStateEstimation(substrate,
%       substrate_network_min, substrate_network_max, plant, plant_network,
%       plant_network_min, plant_network_max, timespan, varname, n_filter_out)  
%       createSubstrateFeedsForStateEstimation(substrate,
%       substrate_network_min, substrate_network_max, plant, plant_network,
%       plant_network_min, plant_network_max, timespan, varname, n_filter_out,
%       n_filter_in)
%
%% Description
% |createSubstrateFeedsForStateEstimation(substrate, substrate_network_min,
% substrate_network_max, plant, plant_network, plant_network_min,
% plant_network_max, timespan, varname)| creates substrate feeds used to
% learn the state estimator. The method creates all volumeflow_..._user.mat
% files, both for substrates and pumps, calling
% <matlab:doc('createvolumeflowfile') createvolumeflowfile>. The data written
% inside these files is created as random numbers between the given min and
% max values. If the dataset file |varname|.mat already exists, then feeds
% for the substrates are created that are the least represented in the
% dataset yet, using <matlab:doc('hist') hist>. 
%
%% <<substrate/>>
%% <<substrate_network_min/>>
%% <<substrate_network_max/>>
%% <<plant/>>
%% <<plant_network/>>
%% <<plant_network_min/>>
%% <<plant_network_max/>>
%%
% @param |timespan| : the duration of each simulation : e.g. [0 50] for 50
% days. 
%
%%
% @param |varname| : filename of the dataset, without the file extension
% '.mat'. 
%
%%
% @param |n_filter_out| : number of filters for output measurements.
% default: 7 
%
%%
% @param |n_filter_in| : number of filters for input measurements. default:
% 5 
%
%% Example
% 
% 

[substrate, plant, substrate_network, plant_network, ...
 substrate_network_min, substrate_network_max, ...
 plant_network_min, plant_network_max]= load_biogas_mat_files('sunderhook');

varname= 'dataset_complete';

createSubstrateFeedsForStateEstimation(substrate, ...
              substrate_network_min, substrate_network_max, ...
              plant, plant_network, plant_network_min, plant_network_max, ...
              [0 950], varname);

%%
% TODO: add example, where dataset already exists, then compare histograms



%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc createvolumeflowfile">
% createvolumeflowfile</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/is_substrate')">
% biogas_scripts/is_substrate</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/is_substrate_network')">
% biogas_scripts/is_substrate_network</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/is_plant')">
% biogas_scripts/is_plant</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/is_plant_network')">
% biogas_scripts/is_plant_network</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/load_file')">
% biogas_scripts/load_file</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_scripts/getnumdigestersplits')">
% biogas_scripts/getNumDigesterSplits</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="simbiogasplantforprediction.html">
% simBiogasPlantForPrediction</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="createstateestimator.html">
% createStateEstimator</a>
% </html>
%
%% TODOs
% # improve documentation
% # there is a todo for recirculation
% # solve TODOs
%
%% <<AuthorTag_DG/>>


