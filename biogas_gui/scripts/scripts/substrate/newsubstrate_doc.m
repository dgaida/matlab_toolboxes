%% Syntax
%       handles= newsubstrate(handles, substrate_id_name)
%
%% Description
% |handles= newsubstrate(handles, substrate_id_name)| creates a new
% substrate structure containing one substrate with given id and name and
% updates the gui calling <after_substrate_loaded.html
% after_substrate_loaded>. 
%
%%
% @param |handles| : handles structure of gui
%
%%
% @param |substrate_id_name| : 2dim cell of strings with id and name of the
% to be created substrate in the new substrate structure.
%
%%
% @return |handles| : updated handles structure
%
%% Example
% 
%
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="after_substrate_loaded.html">
% after_substrate_loaded</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('script_collection/checkargument')">
% script_collection/checkArgument</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="gui_substrate.html">
% gui_substrate</a>
% </html>
% ,
% <html>
% <a href="cmdaddsubstrate_callback.html">
% cmdAddSubstrate_Callback</a>
% </html>
%
%% See Also
% 
% <html>
% <a href="gui_substrate.html">
% gui_substrate</a>
% </html>
% ,
% <html>
% <a href="cmdeditsubstrate_callback.html">
% cmdEditSubstrate_Callback</a>
% </html>
% ,
% <html>
% <a href="s_panradio_selectionchangefcn.html">
% s_panRadio_SelectionChangeFcn</a>
% </html>
%
%% TODOs
% # improve documentation
% # check code
%
%% <<AuthorTag_DG/>>


