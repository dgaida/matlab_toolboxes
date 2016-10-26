%% Syntax
%       [uused]= add_noise_to_u_filterbank(uused, rel_noise_in)
%
%% Description
% |[uused]= add_noise_to_u_filterbank(uused, rel_noise_in)| 
%
%%
% @param |uused| : double matrix with two columns and as many rows as there
% are instances. 
%
%%
% @param |rel_noise_in| : double scalar defining the noise added to the
% data, measured in 100 %.
%
%%
% @return |uused| : the given data |uused| with the specified noise added.
%
%% Example
% 
%

[U, u_sample]= create_U_ekf_and_filterbank('ADode6');

[uused]= add_noise_to_u_filterbank(U{1}, 0.05);

plot(0:u_sample*1/24:(size(uused, 1) - 1)*u_sample*1/24, uused(:,1), 'r', ...
     0:u_sample*1/24:(size(uused, 1) - 1)*u_sample*1/24, uused(:,2), 'm');
hold on;
plot(0:u_sample*1/24:(size(U{1}, 1) - 1)*u_sample*1/24, U{1});
hold off;

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
% <a href="matlab:doc('script_collection/isr')">
% script_collection/isR</a>
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
%
%% <<AuthorTag_DG/>>


