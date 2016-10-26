%% Syntax
%       handles= loadDataFromFile(handles, n_substrates)
%
%% Description
% |handles= loadDataFromFile(handles, n_substrates)| belongs to the GUI 
% <set_input_stream.html set_input_stream>. It loads volumeflow_substrates_const
% files from directory |handles.model_path| and returns them in
% |handles.substrateflow|. If for some reason |n_substrates| is not equal
% the number of substrates saved in |handles.substrate|, then
% |handles.substrateflow| becomes an zero-columnvector with |n_substrates|
% rows. Reasons could be:
%
% * |handles.substrate| is empty
% * ...
%
%%
% @param |handles| : handle of gui
%
%%
% @param |n_substrates| : double with the number of substrates
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


