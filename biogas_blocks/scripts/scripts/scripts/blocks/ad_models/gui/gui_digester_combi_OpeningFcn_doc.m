%% Syntax
%       gui_digester_combi_OpeningFcn(hObject, eventdata, handles)
%       gui_digester_combi_OpeningFcn(hObject, eventdata, handles, plant)
%       gui_digester_combi_OpeningFcn(hObject, eventdata, handles, plant,
%       fermenter_name) 
%       
%% Description
% |gui_digester_combi_OpeningFcn(hObject, eventdata, handles)|
% executes just before gui_digester_combi is made visible. Positions the
% gui but does not start the timer for gui update.
%
%%
% |gui_digester_combi_OpeningFcn(hObject, eventdata, handles, plant)|
% additionally starts the timer to display the values for the first
% fermenter in the given plant
%
%% <<plant/>>
%%
% |gui_digester_combi_OpeningFcn(hObject, eventdata, handles, plant,
% fermenter_name)| starts the timer and visualizes the given fermenter
% |fermenter_name| on the gui.
%
%%
% @param |fermenter_name| : char with the name of the fermenter, must be
% inside the object |plant|. 
%
%% Example
% 
%
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="tmrfcn.html">
% TmrFcn</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('timer')">
% matlab/timer</a>
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
% <a href="gui_digester_combi.html">
% gui_digester_combi (gui)</a>
% </html>
%
%% See also
% 
% <html>
% <a href="matlab:doc('adm1de')">
% ADM1DE</a>
% </html>
%
%% TODOs
% # improve documentation
%
%% <<AuthorTag_DG/>>


