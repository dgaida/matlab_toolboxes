%% Syntax
%       simudata= createvolumeflowfile(type, q_max, substrate_name)
%       simudata= createvolumeflowfile(type, q_max, substrate_name,
%       user_deltatime, user_data) 
%       simudata= createvolumeflowfile(type, q_max, substrate_name,
%       user_deltatime, user_data, user_density) 
%       simudata= createvolumeflowfile(type, q_max, substrate_name,
%       user_deltatime, user_data, user_density, user_unit)
%       simudata= createvolumeflowfile(type, q_max, substrate_name,
%       user_deltatime, user_data, user_density, user_unit, accesstofile)
%       simudata= createvolumeflowfile(type, q_max, substrate_name,
%       user_deltatime, user_data, user_density, user_unit, accesstofile,
%       pathToSaveIn) 
%       simudata= createvolumeflowfile(type, q_max, substrate_name,
%       user_deltatime, user_data, user_density, user_unit, accesstofile,
%       pathToSaveIn, file_id) 
%       simudata= createvolumeflowfile(type, q_max, substrate_name,
%       user_deltatime, user_data, user_density, user_unit, accesstofile,
%       pathToSaveIn, file_id, add_intermediates) 
%
%% Description
% |simudata= createvolumeflowfile(type, q_max, substrate_name)| creates the
% volumeflow file for data input, the unit of the volumeflow is [m^3/day].
% The file is called 'volumeflow__substrate_name___type_.mat' and contains
% a 2dim array with two rows. The first row defines the time measured in
% days, the 2nd row defines the voluemflow measured in m³/d. 
%
%%
% @param |type| : char, defining the type of volumeflow
%
% * 'random' : random volumeflow. Here the volumeflow is generated using
% uniformly distributed pseudorandom numbers ranging from 0 to |q_max|. 
% * 'const' : constant volumeflow. the volumflow is constant = |q_max|. 
% * 'user' : user defined volumeflow. It is not possible to call this
% function with 3 arguments and using this option. 
%
%%
% @param |q_max| : maximal volume flow, if |type| = 'user' is selected,
% then |q_max| is not used. double scalar. 
%
%%
% @param |substrate_name| : char with the id of the substrate/volumeflow
% (defines the filename), depends on the values in the struct
% substrate.ids, e.g. 'maize', 'bullmanure', etc. 
%
%%
% |simudata= createvolumeflowfile(type, q_max, substrate_name,
% user_deltatime, user_data)| 
%
%%
% the following four parameters are only used if |type| = 'user'
%
%%
% @param |user_deltatime| : time duration between the given entries in the
% |data| vector in days, double scalar. 
%
%%
% @param |user_data| : the data, a double row or column vector. the unit of
% the data is measurd in |user_unit|. 
%
%%
% @param |user_density| : the density of the substrate, is needed if the
% given data has unit kg/day. The value of |user_density| must have the
% unit [g/m^3]. If |user_unit| is not passed to the function, then
% |user_density| is overwritten to 1, because it is assumed that
% |user_data| is measured in |m³/d|. 
%
%%
% @param |user_unit| : defines the unit of the input data: 
%
% * 'kg_day' for kg/day or 
% * 'm3_day' for m³/day (default)
%
% the output data has always the unit [m^3/day]
%
%%
% |simudata= createvolumeflowfile(type, q_max, substrate_name,
% user_deltatime, user_data, user_density, user_unit, accesstofile)|
%
%%
% @param |accesstofile| : 
%
% * 1 : if 1, then really save the data to a file. 
% * 0 : if set to 0, then the data isn't saved to a file, but is as always
% returned by the function (good for optimization purpose -> speed) and
% saved to the base workspace (even better for optimization purpose ->
% speed) 
% * -1 : if it is -1, then save the data not to the workspace but to the
% model workspace. In the newest MATLAB versions, from 7.11 on, it is not
% allowed anymore to save into the modelworkspace while the model is
% running. So then we save to a file using <matlab:doc('save')
% matlab/save>. In case we are running the models in parallel, then to the
% filename an integer is appended, this is the integer of the currently
% load model. 
%
%%
% |simudata= createvolumeflowfile(type, q_max, substrate_name,
% user_deltatime, user_data, user_density, user_unit, accesstofile,
% pathToSaveIn)| 
%
%%
% @param |pathToSaveIn| : path where the created file is saved, if a file
% is saved. Default is |pwd|.
%
%%
% |simudata= createvolumeflowfile(type, q_max, substrate_name,
% user_deltatime, user_data, user_density, user_unit, accesstofile,
% pathToSaveIn, file_id)| 
%
%%
% @param |file_id| : id appended to the filename, double scalar. Then the
% filename becomes 'volumeflow__substrate_name___type__file_id_.mat' (in
% case a file is generated at all). 
%
%%
% @param |add_intermediates| : 0 or 1
%
% * 1 : if |type == 'user'| then intermediate values in the volumeflow are
% added to get a piecewise constant signal. default. 
% * 0 : do not add intermediate values. the values are interpolated
% linearly then by Simulink.
%
%% Example
% 

simudata= createvolumeflowfile('user', 20, 'maize', 5, [10,20,10,15], [], [], 0);

disp(simudata)

plot(simudata(1,:), simudata(2,:))

%%

utest= create_rand_signal(100, 4, [0 5], 'nearest');
plot(utest)
createvolumeflowfile('user', [], 'maize', 1, utest./100, [], [], 0);

%%

createvolumeflowfile('const', 68.1935, 'bullmanure', [], [], [], [], 0)

createvolumeflowfile('const', 0.0, 'grass', [], [], [], [], 0)

createvolumeflowfile('const', 0.0, 'greenrye', [], [], [], [], 0)

createvolumeflowfile('const', 40.4838, 'maize1')

createvolumeflowfile('const', 0.0, 'oat')

createvolumeflowfile('const', 0.688824, 'silojuice')

% delete files again

delete('volumeflow_maize1_const.mat')
delete('volumeflow_oat_const.mat')
delete('volumeflow_silojuice_const.mat')


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
% <a href="matlab:doc('script_collection/assigninmws')">
% script_collection/assigninMWS</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('validateattributes')">
% matlab/validateattributes</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('validatestring')">
% matlab/validatestring</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/isr')">
% script_collection/isR</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/isz')">
% script_collection/isZ</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/save')">
% matlab/save</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/bdroot')">
% matlab/bdroot</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/assignin')">
% matlab/assignin</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('biogas_gui/set_input_stream')">
% biogas_gui/set_input_stream</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_control/nmpc_save_simoptmimdata')">
% biogas_control/NMPC_save_SimOptmimData</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_optimization/setnetworkfluxinworkspace')">
% biogas_optimization/setNetworkFluxInWorkspace</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_ml/simbiogasplantforprediction')">
% biogas_ml/simBiogasPlantForPrediction</a>
% </html>
%
%% See Also
%
% <html>
% <a href="createinitstatefile.html">
% createinitstatefile</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('data_tool/create_rand_signal')">
% data_tool/create_rand_signal</a>
% </html>
% ,
% <html>
% <a href="createtimeseriesfile.html">
% createtimeseriesfile</a>
% </html>
%
%% TODOs
%
%
%% <<AuthorTag_DG/>>

    
