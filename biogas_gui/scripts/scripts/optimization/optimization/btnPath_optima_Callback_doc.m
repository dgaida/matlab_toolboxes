%% Syntax
%       btnPath_optima_Callback(hObject, eventdata, handles)
%       
%% Description
% |btnPath_optima_Callback(hObject, eventdata, handles)| executes on
% button press in btnPath_optima. Lets the user choose the folder to the
% optimization model and sets the plant ID after the model of the plant was
% found. Then calls <optima_callactualizegui.html optima_callActualizeGUI>.
% 
% 
%% Example
% 
%
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="optima_callactualizegui.html">
% optima_callActualizeGUI</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('uigetdir')">
% doc:uigetdir</a>
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
% <a href="gui_optimization.html">
% gui_optimization (gui)</a>
% </html>
%
%% See also
% 
% <html>
% <a href="gui_optimization.html">
% gui_optimization</a>
% </html>
% ,
% <html>
% <a href="set_input_stream_min_max.html">
% set_input_stream_min_max</a>
% </html>
% ,
% <html>
% <a href="searchformodelfile.html">
% searchForModelFile</a>
% </html>
%
%% TODOs
% # searchForModelFile ist sehr ähnlich
% # improve documentation
% # check code
%
%% <<AuthorTag_DG/>>


