%% Syntax
%       class_real= get_real_value_from_class(class,
%       digester_state_dataset_min,	digester_state_dataset_max, no_classes)
%
%% Description
% |class_real= get_real_value_from_class(class, digester_state_dataset_min,
% digester_state_dataset_max, no_classes)| returns the real value
% |class_real| to the corresponding class value |class|. 
%
%%
% @param |class| : class number from 0 to |no_classes - 1|
%
%%
% @param |digester_state_dataset_min| : double scalar, lower bound of
% digester state vector component
%
%%
% @param |digester_state_dataset_max| : double scalar, upper bound of
% digester state vector component
%
%%
% @param |no_classes| : number of classes used in classification problem
% for given digester state vector component
%
%%
% @return |class_real| : real value corresponding to given |class|
%
%% Example
% 
%

cd( fullfile( getBiogasLibPath(), 'examples/prediction/Sunderhook' ) );

digester_state_dataset_min= load_file('digester_state_dataset_min');
digester_state_dataset_max= load_file('digester_state_dataset_max');

component_min= digester_state_dataset_min(12, 1);
component_max= digester_state_dataset_max(12, 1);

get_real_value_from_class(5, component_min, component_max, 10)


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('script_collection/isn')">
% script_collection/isN</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/isz')">
% script_collection/isZ</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/isr')">
% script_collection/isR</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc ldastateestimator">
% LDAStateEstimator</a>
% </html>
% ,
% <html>
% <a href="getstateestimateofbiogasplant.html">
% getStateEstimateOfBiogasPlant</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="matlab:doc rfstateestimator">
% RFStateEstimator</a>
% </html>
%
%% TODOs
% # check appearance of documentation
%
%% <<AuthorTag_DG/>>


