%% Syntax
%       hydraulic_delay_closefcn()
%       hydraulic_delay_closefcn(DEBUG_DISP)
%
%% Description
% |hydraulic_delay_closefcn()| closes the block 'Hydraulic Delay' and
% is called in the ModelCloseFcn Callback. During the (Closing)
% finalization the block sets the selected value in the drop down menus
% back to the default entry of the library, which is 'Bitte ... wählen'.
% Otherwise the library would return an error since it does not know the
% other values selectable in the drop down menus, since they depend on the
% plant. The real selected value in the drop down menu is saved in the
% UserData of the block (this is also done in this function) and is read in
% the LoadFcn Callback (see <hydraulic_delay_loadfcn.html
% |hydraulic_delay_loadfcn|>).
%
%%
% |hydraulic_delay_closefcn(DEBUG_DISP)| additionally displays messages, if
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
% (CloseFcn Callback of 'Hydraulic Delay' block)
%
%% See Also
% 
% <html>
% <a href="hydraulic_delay.html">
% hydraulic_delay</a>
% </html>
% ,
% <html>
% <a href="hydraulic_delay_loadfcn.html">
% hydraulic_delay_loadfcn</a>
% </html>
%
%% TODOs
% # improve documentation
% # check code
%
%% <<AuthorTag_DG/>>


