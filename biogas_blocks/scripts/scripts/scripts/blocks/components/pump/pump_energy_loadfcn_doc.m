%% Syntax
%       pump_energy_loadfcn()
%       pump_energy_loadfcn(DEBUG_DISP)
%
%% Description
% |pump_energy_loadfcn()| loads the 'Pump (Energy)' block by creating the 
% dropdown menu of the block's mask. The function is called by the 'Pump
% (Energy)' block in the LoadFcn Callback.
%
%%
% |pump_energy_loadfcn(DEBUG_DISP)| additionally displays messages, if
% DEBUG_DISP == 1; DEBUG_DISP == 0, is the default
%
%% Example
% 
%

pump_energy_loadfcn()


%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('script_collection/get_param_error')">
% script_collection/get_param_error</a>
% </html>
%
% and is called by:
%
% (pump energy block)
%
%% See Also
% 
% <html>
% <a href="pump.html">
% pump</a>
% </html>
% ,
% <html>
% <a href="pump_energy_closefcn.html">
% pump_energy_closefcn</a>
% </html>
% ,
% <html>
% <a href="pump_energy_setmask.html">
% pump_energy_setmask</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_blocks/createfermenterpopup')">
% createfermenterpopup</a>
% </html>
%
%% TODOs
% # check documentation
% # check code
% # update is called by section
%
%% <<AuthorTag_DG/>>


