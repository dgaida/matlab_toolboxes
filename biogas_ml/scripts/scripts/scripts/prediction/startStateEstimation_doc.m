%% Preliminaries
% # Before calling the function, change into the folder where the files
% 'dataset_6h_0n_complete.mat' and 'streams_6h_complete.mat' exist. These
% files are created using the method <simbiogasplantforprediction.html
% simBiogasPlantForPrediction>. 
%
%% Syntax
%       []= startStateEstimation(plant_id)
%       []= startStateEstimation(plant_id, parallel)
%       []= startStateEstimation(plant_id, parallel, nWorker)
%       []= startStateEstimation(plant_id, parallel, nWorker, method) 
%       []= startStateEstimation(plant_id, parallel, nWorker, method,
%       sample_times) 
%       []= startStateEstimation(plant_id, parallel, nWorker, method, 
%       sample_times, noise_out) 
%       []= startStateEstimation(plant_id, parallel, nWorker, method, 
%       sample_times, noise_out, doplots) 
%       []= startStateEstimation(plant_id, parallel, nWorker, method, 
%       sample_times, noise_out, doplots, bins) 
%       startStateEstimation(plant_id, parallel, nWorker, method, 
%       sample_times, noise_out, doplots, bins, ma_filters_out_p1) 
%       startStateEstimation(plant_id, parallel, nWorker, method, 
%       sample_times, noise_out, doplots, bins, ma_filters_out_p1,
%       ma_filters_in_p1) 
%
%% Description
%
% |[]= startStateEstimation(plant_id)| basically calls in a big for loop
% the method <startmethodforstateestimation.html
% startMethodforStateEstimation> with different parameters, which are
% changed on different for loop levels. In these for loops the following
% files are load:
%
% * |dataset_...h_...n_complete.mat|
% * |streams_...h_complete.mat|
% * |cutter_...h_complete.mat|
%
% The file |dataset_flag_vec_...mat| is saved, which contains a vector
% defining which column in the dataset is used for prediction (1). This
% depends on the set input and output filters, see parameters
% |ma_filters_out_p1| and |ma_filters_in_p1|. Furthermore columns which are
% completely constant are not used for prediction, because they do not
% contain any informations. 
%
% Writes lower and upper boundaries of dataset in a tex file calling
% <matlab:doc('addnewrowinlatextable') addNewRowInLatexTable>. 
%
%%
% @param |plant_id| : character containing the id of the plant
%
%%
% |[]= startStateEstimation(plant_id, parallel)|
%
%%
% @param |parallel| : Since this function is quite time consuming it is 
% possible to distribute the work to a bunch of computers or processors to 
% solve the classification problems in parallel. The standard value is 'none'.
%
% * 'none'          : use one single processor, no parallel computing
% * 'multicore'     : parallel computing using a multicore processor on one
% PC.
% * 'cluster'       : using Parallel Computing Toolbox functions and MATLAB
% Distributed Computing Server on a computer cluster, such that a number of
% computers can work on the problem. (Not yet working)
%
%%
% |[]= startStateEstimation(plant_id, parallel, nWorker)|
%
%%
% @param |nWorker|    : number of workers to run in parallel : 
% 2 for a dual core, 4 for a quadcore, when using with 'multicore', else
% number of computers (workers) in the cluster. The standard value is 2,
% when using parallel computing, else 1.
%
%%
% |[]= startStateEstimation(plant_id, parallel, nWorker, method)|
%
%%
% @param |methods| : cell array of characters defining the used pattern
% recognition methods
%
% * {'RF'} : Random Forest
% * {'LDA'} : Linear Discriminant Analysis
% * {'SVM'} : Support Vector Machines
% * {'GerDA'} : Generalized Discriminant Analysis
%
% examples: {'GerDA'}, {'RF', 'LDA'}
%
%%
% |[]= startStateEstimation(plant_id, parallel, nWorker, method,
% sample_times)| 
%
%%
% @param |sample_times| : cell array of doubles defining the sampling time
% for the data to be read, used in the state estimator. The sampling time
% is given in hours. Per default only the sampling time= 6 hours is used. 
%
% For each sample time the two files:
%
% * |dataset_...h_...n_complete.mat|
% * |streams_...h_complete.mat|
%
% must exist, where the sampling time is abbreviated by the dots followed
% by |h| (hours). Both files are created, calling
% <simbiogasplantforprediction.html simBiogasPlantForPrediction>. 
%
%%
% |[]= startStateEstimation(plant_id, parallel, nWorker, method,
% sample_times, noise_out)| 
%
%%
% @param |noise_out| : cell of double arrays defining the noise which
% should be added to the output measurements. 
%
% noise added to the four measurements:
%
% * pH value
% * ch4 content in biogas
% * co2 content in biogas
% * total biogas production
%
% For each element in the cell array one file 
%
% * |dataset_...h_...n_complete.mat|
%
% must exist, where the number before the dots n (...n) just is the cell
% counter, running from 0, 1, 2, ...
%
%%
% |[]= startStateEstimation(plant_id, parallel, nWorker, method,
% sample_times, noise_out, doplots)| 
%
%%
% @param |doplots| : if 1, then the data is plotted, else set to 0
% (default). The data plotted are the columns of the dataarray inside the
% load |dataset_...mat| file. 
%
%%
% |[]= startStateEstimation(plant_id, parallel, nWorker, method,
% sample_times, noise_out, doplots, bins)| 
%
%%
% @param |bins| : number of classes used in the classification problem, per
% default= 10.
%
%%
% @param |ma_filters_out_p1| : cell array of output filters used to include
% past measurement values into the dataset used for state estimation. As the original
% measurement plus 7 moving average filters are used ([12, 24, 3*24, 7*24,
% 14*24, 21*24, 31*24]) the cell array consists of 8 dimensional double
% vectors. A |1| symbolizes that the filter is used and a |0|, that the
% filter is not used. 
%
%%
% @param |ma_filters_in_p1| : cell array of input filters used to include
% past substrate feed values into the dataset used for state estimation. As the original
% measurement plus 5 moving average filters are used ([12, 24, 3*24, 7*24,
% 14*24]) the cell array consists of 6 dimensional double
% vectors. A |1| symbolizes that the filter is used and a |0|, that the
% filter is not used. 
%
%% Example
%
% |startStateEstimation('sunderhook');|
%
% |startStateEstimation('sunderhook', [], [], {'RF'});|
%
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc addnewrowinlatextable">
% addNewRowInLatexTable</a>
% </html>
% ,
% <html>
% <a href="startmethodforstateestimation.html">
% startMethodforStateEstimation</a>
% </html>
% ,
% <html>
% <a href="matlab:doc load_biogas_mat_files">
% load_biogas_mat_files</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('optimization_tool/setparallelconfiguration')">
% optimization_tool/setParallelConfiguration</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('createtask')">
% matlab/createTask</a>
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
% <a href="createdatasetforpredictor.html">
% createDataSetForPredictor</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('ml_tool/katz_lda')">
% ml_tool/katz_lda</a>
% </html>
% ,
% <html>
% <a href="simbiogasplantforprediction.html">
% simBiogasPlantForPrediction</a>
% </html>
%
%% TODOs
% # improve documentation
% # add an example
% # if release version of startMethodforStateEstimation is increased, then
% also increase the release version here
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


