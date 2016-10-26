%% Syntax
%       btnPath_po_Callback(hObject, eventdata, handles)
%       
%% Description
% |btnPath_po_Callback(hObject, eventdata, handles)| executes on button
% press in |btnPath_po| of gui <gui_plot_optimresults.html
% gui_plot_optimResults>. Gets the to be diplayed file using 
% <matlab:doc('uigetfile') doc:uigetfile> and changes to the folder in
% which the file is located. If a file was selected, then calls 
% <po_callactualizegui.html po_callActualizeGUI>. 
%
%% Example
% 
%

btnPath_po_Callback();

%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="po_callactualizegui.html">
% po_callActualizeGUI</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('uigetfile')">
% doc:uigetfile</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('cd')">
% doc:cd</a>
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
% <a href="gui_plot_optimresults.html">
% gui_plot_optimResults.fig</a>
% </html>
%
%% See also
% 
% <html>
% <a href="gui_plot_optimresults.html">
% gui_plot_optimResults</a>
% </html>
% ,
% <html>
% <a href="gui_optimization.html">
% gui_optimization</a>
% </html>
%
%% TODOs
%
%
%% <<AuthorTag_DG/>>


