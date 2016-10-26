%% Syntax
%       [plant_id, DEBUG, showGUIs, appendDATA]= get_biogas_block_params() 
%
%% Description
% |[plant_id, DEBUG, showGUIs, appendDATA]= get_biogas_block_params()|
% returns the values set in model gui. 
%
%%
% @return |plant_id| : id of the plant. char. 
% 
%%
% @return |DEBUG| : 0 or 1. depends on chosen value of checkbox on gui. 
%
%%
% @return |showGUIs| : 0 or 1. at the moment equal to |DEBUG|. 
%
% * 0 : do not show digester guis during simulation
% * 1 : do show digester guis during simulation
%
%%
% @return |appendDATA| : 0 or 1. At the moment always: 1.
%
% * 0 : do not append new measured data to sensors object, but overwrite
% old data
% * 1 : do append new measured data to sensors object to create time
% series. 
%
%% Example
%
%
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
% <html>
% <a href="init_biogas_plant_mdl.html">
% init_biogas_plant_mdl</a>
% </html>
%
%% See Also
% 
% -
%
%% TODOs
% # improve documentation a little
% # maybe change functionality of script a bit
%
%% <<AuthorTag_DG/>>


