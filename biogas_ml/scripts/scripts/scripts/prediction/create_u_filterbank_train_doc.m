%% Syntax
%       [u, u_sample]= create_u_filterbank_train(system, toiteration)
%
%% Description
% |[u, u_sample]= create_u_filterbank_train(system, toiteration)| creates u
% for filterbank for training. Loads 'u_rand_signal_train_v2.mat' and
% resamples it by calling <matlab:doc('matlab/interp1') matlab/interp1>. 
%
%%
% @param |system| : char defining the name of the simulation system:
%
% * 'AM1'
% * 'ADode6'
%
%%
% @param |toiteration| : number of hours
%
%%
% @return |u| : resampled input data. 
%
%%
% @return |u_sample| : sample time of input data. Always: 1/60. That means:
% 1 min. if the sampletime of the system is 1 h.
%
%% Example
% 
%

[u, u_sample]= create_u_filterbank_train('ADode6', 100*24);

plot(0:u_sample*1/24:(size(u, 1) - 1)*u_sample*1/24, u);
xlabel('t [d]')


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
% <a href="matlab:doc('script_collection/isn')">
% script_collection/isN</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/load_file')">
% script_collection/load_file</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/interp1')">
% matlab/interp1</a>
% </html>
%
% and is called by:
%
% (the user)
%
%% See Also
% 
% <html>
% <a href="matlab:doc biogas_ml/applyfilterbanktodatastream">
% biogas_ml/applyFilterBankToDataStream</a>
% </html>
% ,
% <html>
% <a href="matlab:doc data_tool/ekf_hybrid_simon">
% data_tool/ekf_hybrid_simon</a>
% </html>
% ,
% <html>
% <a href="matlab:doc data_tool/mhe">
% data_tool/MHE</a>
% </html>
%
%% TODOs
% # improve documentation
% # check appearance of documentation
%
%% <<AuthorTag_DG/>>


