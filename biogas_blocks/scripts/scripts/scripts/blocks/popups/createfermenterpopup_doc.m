%% Syntax
%       createfermenterpopup(id_fermenter, y_text_pos, display, init)
%       createfermenterpopup(id_fermenter, y_text_pos, display, init,
%       model_closes) 
%       createfermenterpopup(id_fermenter, y_text_pos, display, init,
%       model_closes, id_is_loaded_and_is_being_loaded) 
%
%% Description
% |createfermenterpopup(id_fermenter, y_text_pos, display, init)|
% creates the dropdown menu for selecting a fermenter via a block's mask.
% The function is called by functions of the library.
% It gets the fermenter collection object out of
% the modelworkspace using <matlab:doc('script_collection/evalinmws')
% script_collection/evalinMWS> and generates the content of the dropdown
% list and sets MaskStyleString to the block using <matlab:doc('set_param')
% set_param>. Furthermore reads UserData of the block and sets MaskValues
% to the saved fermenter in UserData, but only if |init| is 1. If |display|
% is 1, then using <display_selected_fermenter.html
% display_selected_fermenter> the selected fermenter is displayed on the
% block. The selected value is always saved inside UserData. 
%
%%
% @param |id_fermenter| : index of the element on the mask which belongs to
% the fermenter, starting with 1. Double, numeric.
%
%%
% @param |y_text_pos| : vertical position of the name of the selected fermenter
% displayed on the block. Only used if |display| == 1. As the units of the
% block are normalised, the 
% value must be a float between 0 and 1. The vertical position is measured
% from the bottom of the block.
%
%%
% @param |display| : double. If 1, then display the name of the selected
% fermenter on the block using <display_selected_fermenter.html
% display_selected_fermenter>. No further use. 
%
% * 0 : don't display the name of the selected fermenter on the block
% * 1 : display the name of the selected fermenter on the block
%
%%
% @param |init| : double. If 1, then the fermenter entry of MaskValues is
% set to the saved UserData. No further use. 
%
% * 0 : set to 0, when block is not called for the first time
% * 1 : set to 1, when block is called for the first time
%
%%
% |createfermenterpopup(id_fermenter, y_text_pos, display, init,
% model_closes)| must be called when the model is closed. If the model is
% closed, then the selected substrate is set back to '--- Bitte Substrat
% wählen ---'. 
%
%%
% @param |model_closes| : char. if model closes, then set this value to
% 'Close'. Then mask of this block is reset to default values.
%
%%
% |createfermenterpopup(id_fermenter, y_text_pos, display, init,
% model_closes, id_is_loaded_and_is_being_loaded)| sets back the entries
% for block 'is_loaded' and 'is_being_loaded' to 'off'. 
%
%%
% @param |id_is_loaded_and_is_being_loaded| : 2dim double array with the
% ids signalizing the positions in the mask of the block that the block is
% loaded and is being loaded. Both are set to 'off' when closing the model.
%
%% Example
% 
%

createfermenterpopup(1, 0.4, 1, 0)

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('script_collection/evalinmws')">
% script_collection/evalinMWS</a>
% </html>
% ,
% <html>
% <a href="display_selected_fermenter.html">
% display_selected_fermenter</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('gcb')">
% matlab/gcb</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/get_param_error')">
% script_collection/get_param_error</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/set_param_tc')">
% script_collection/set_param_tc</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('validateattributes')">
% matlab/validateattributes</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/isn')">
% script_collection/isN</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/is0or1')">
% script_collection/is0or1</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="matlab:doc('bioags_blocks/callback_adm1_gui')">
% Callback_ADM1_gui</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('bioags_blocks/adm1_closefcn')">
% adm1_closefcn</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('bioags_blocks/adm1_loadfcn')">
% adm1_loadfcn</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('bioags_blocks/heating_closefcn')">
% heating_closefcn</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('bioags_blocks/heating_loadfcn')">
% heating_loadfcn</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('bioags_blocks/hydraulic_delay_closefcn')">
% hydraulic_delay_closefcn</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('bioags_blocks/hydraulic_delay_loadfcn')">
% hydraulic_delay_loadfcn</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('bioags_blocks/pump_energy_closefcn')">
% pump_energy_closefcn</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('bioags_blocks/pump_energy_loadfcn')">
% pump_energy_loadfcn</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('bioags_blocks/pump_stream_closefcn')">
% pump_stream_closefcn</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('bioags_blocks/pump_stream_loadfcn')">
% pump_stream_loadfcn</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('bioags_blocks/kalman_closefcn')">
% kalman_closefcn</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('bioags_blocks/kalman_loadfcn')">
% kalman_loadfcn</a>
% </html>
% ,
% <html>
% ...
% </html>
%
%% See Also
% 
% <html>
% <a href="createdatasourcetypepopup.html">
% createdatasourcetypepopup</a>
% </html>
% ,
% <html>
% <a href="createinitstatetypepopup.html">
% createinitstatetypepopup</a>
% </html>
% ,
% <html>
% <a href="creategas2bhkwsplittypepopup.html">
% creategas2bhkwsplittypepopup</a>
% </html>
% ,
% <html>
% <a href="createtimevaluepopup.html">
% createtimevaluepopup</a>
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
%
%% TODOs
% # check appearance of documentation
%
%% <<AuthorTag_DG/>>


