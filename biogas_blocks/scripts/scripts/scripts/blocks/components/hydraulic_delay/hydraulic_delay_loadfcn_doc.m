%% Syntax
%       hydraulic_delay_loadfcn()
%       hydraulic_delay_loadfcn(DEBUG_DISP)
%
%% Description
% |hydraulic_delay_loadfcn()| loads the hydraulic delay model by creating
% the dropdown menus of the block's mask. The function is called by the
% hydraulic delay block in the LoadFcn Callback.
%
%%
% |hydraulic_delay_loadfcn(DEBUG_DISP)| additionally displays messages, if
% DEBUG_DISP == 1; DEBUG_DISP == 0, is the default
%
%%
% @param |DEBUG_DISP| : double scalar
%
% * 0 (Default)
% * 1, additionally displays messages
%
%% Example
% 
%
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc bdroot">
% matlab/bdroot</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_blocks/createfermenterpopup')">
% createfermenterpopup</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_blocks/createinitstatetypepopup')">
% createinitstatetypepopup</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_blocks/createdatasourcetypepopup')">
% createdatasourcetypepopup</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('gcb')">
% matlab/gcb</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('get_param')">
% matlab/get_param</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('set_param')">
% matlab/set_param</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/is0or1')">
% script_collection/is0or1</a>
% </html>
%
% and is called by:
%
% (LoadFcn Callback of 'Hydraulic Delay' block)
%
%% See Also
% 
% <html>
% <a href="hydraulic_delay.html">
% hydraulic_delay</a>
% </html>
% ,
% <html>
% <a href="hydraulic_delay_closefcn.html">
% hydraulic_delay_closefcn</a>
% </html>
%
%% TODOs
% # check code
% # improve documentation
%
%% <<AuthorTag_DG/>>


