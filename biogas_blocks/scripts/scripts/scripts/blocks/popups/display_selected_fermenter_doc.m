%% Syntax
%       display_selected_fermenter(id_fermenter, y_text_pos)
%
%% Description
% |display_selected_fermenter(id_fermenter, y_text_pos)| displays the
% selected fermenter on the <matlab:doc('gcb') current block>. Therefore it
% gets the current selected fermenter out of the parmater |MaskValues| and
% sets the parameter |MaskDisplay| using <matlab:doc('set_param') set_param>. 
%
%%
% @param |id_fermenter| : index of the element on the mask which belongs to
% the selected name of the fermenter, starting with 1. Double, numeric. At the
% ADM block it is 1, because the first Parameter on the mask is the
% popup menu where the user can select the name of the digester.
%
%%
% @param |y_text_pos| : vertical position of the name of the selected
% digester displayed on the block. As the units of the block are normalised, the
% value must be a float between 0 and 1. The vertical position is measured
% from the bottom of the block.
%
%% Example
% 
%
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('script_collection/getmatlabversion')">
% script_collection/getMATLABVersion</a>
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
% <a href="matlab:doc('script_collection/get_param_error')">
% script_collection/get_param_error</a>
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
% 
% and is called by:
%
% <html>
% <a href="createfermenterpopup.html">
% createfermenterpopup</a>
% </html>
%
%% See Also
%
% -
%
%% TODOs
% # herausfinden warum mask display bei neuen matlab versionen nicht mehr
% gesetzt werden kann
%
%% <<AuthorTag_DG/>>


    