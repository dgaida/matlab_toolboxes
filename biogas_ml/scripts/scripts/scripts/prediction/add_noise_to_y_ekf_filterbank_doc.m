%% Syntax
%       [y]= add_noise_to_y_ekf_filterbank(y, rel_noise_out, set)
%       [y, std_dev_out]= add_noise_to_y_ekf_filterbank(y, rel_noise_out, set)
%
%% Description
% |[y]= add_noise_to_y_ekf_filterbank(y, rel_noise_out, set)| adds noise to
% measurement data for EKF and filterbank. 
%
%%
% @param |y| : double matrix with one or more columns and as many rows as
% there are instances. 
%
%%
% @param |rel_noise_out| : double scalar defining the noise added to the
% data, measured in 100 %.
%
%%
% @param |set| : 0 or 1. If 1, then the data is plotted in a figure. 0
% symbolizes release version. 
%
%%
% @return |y| : the given data |y| with the specified noise added.
%
%%
% @return |std_dev_out| : for each column of |y| this double vector
% contains the noise signal of each column of returned |y|. 
%
%% Example
% 
%
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
% <a href="matlab:doc('script_collection/isr')">
% script_collection/isR</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/is0or1')">
% script_collection/is0or1</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('numerics_tool/calcrmse')">
% numerics_tool/calcRMSE</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('matlab/randn')">
% matlab/randn</a>
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
% # add example
%
%% <<AuthorTag_DG/>>


