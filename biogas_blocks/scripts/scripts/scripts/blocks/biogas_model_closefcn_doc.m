%% Syntax
%       biogas_model_closefcn()
%       biogas_model_closefcn(DEBUG)
%
%% Description
% |biogas_model_closefcn()| saves the currently open biogas plant model
% <matlab:doc('bdroot') bdroot> and is called before the model is closed.
% Can be any Simulink model. 
%
%%
% @param |DEBUG| : 0 or 1, double. At the current implementation |DEBUG|
% has no effect.
%
%% Example
%
% # create a new system, save it calling this function and delete it again.
% 

new_system('test');

biogas_model_closefcn();

delete('test.mdl');

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc save_system">
% matlab/save_system</a>
% </html>
% ,
% <html>
% <a href="matlab:doc questdlg">
% matlab/questdlg</a>
% </html>
% ,
% <html>
% <a href="matlab:doc bdroot">
% matlab/bdroot</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/is0or1')">
% script_collection/is0or1</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/dispmessage')">
% script_collection/dispMessage</a>
% </html>
%
% and is called by:
%
% (CloseFcn Callback of each biogas plant model)
%
%% See Also
% 
% <html>
% <a href="matlab:doc('init_biogas_plant_mdl')">
% init_biogas_plant_mdl</a>
% </html>
%
%% TODOs
% # Is it still important to save the model before closing it?
%
%% <<AuthorTag_DG/>>


