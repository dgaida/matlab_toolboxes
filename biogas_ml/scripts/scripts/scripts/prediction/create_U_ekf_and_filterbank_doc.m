%% Syntax
%       [U, u_sample]= create_U_ekf_and_filterbank(system)
%
%% Description
% |[U, u_sample]= create_U_ekf_and_filterbank(system)| create U for EKF and
% filterbank for validation. Loads 'u_rand_signal.mat' and resamples it by
% calling <matlab:doc('matlab/interp1') matlab/interp1>. 
%
%%
% @param |system| : char defining the name of the simulation system:
%
% * 'AM1'
% * 'ADode6'
%
%%
% @return |U| : 
%
%%
% @return |u_sample| : sample time of input data. Always: 1/60. That means:
% 1 min. if the sampletime of the system is 1 h.
%
%% Example
% 
%

[U, u_sample]= create_U_ekf_and_filterbank('ADode6');

plot(0:u_sample*1/24:(size(U{1}, 1) - 1)*u_sample*1/24, U{1});
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
% <a href="matlab:doc('matlab/load')">
% matlab/load</a>
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


