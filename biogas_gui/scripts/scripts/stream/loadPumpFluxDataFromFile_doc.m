%% Syntax
%       handles= loadPumpFluxDataFromFile(handles, total_number_fluxes)
%
%% Description
% |handles= loadPumpFluxDataFromFile(handles, total_number_fluxes)| belongs
% to <set_input_stream.html set_input_stream>. It loads volumeflow_digester_const 
% files from directory |handles.model_path| and returns them in
% |handles.pumpFlux|. If for some reason |total_number_fluxes| is not equal
% the number of pumps saved in |handles.plant|, then
% |handles.pumpFlux| becomes an zero-columnvector with |total_number_fluxes|
% rows. Reasons could be:
%
% * |handles.plant_network| is empty
% * ...
%
%
%%
% @param |handles| : handle of gui
%
%%
% @param |total_number_fluxes| : double with the number of fluxes between
% fermenters
%
%%
% @return |handles| : handle of gui
%
%% Example
%
% 
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc fullfile">
% matlab/fullfile</a>
% </html>
% ,
% <html>
% <a href="matlab:doc load">
% matlab/load</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/isn')">
% script_collection/isN</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="actualizegui.html">
% actualizeGUI</a>
% </html>
% 
%% See Also
%
% <html>
% <a href="set_input_stream.html">
% set_input_stream</a>
% </html>
%
%% TODOs
%
%
%% <<AuthorTag_DG/>>


