%% Syntax
%       gui_showOptimResults_OpeningFcn(hObject, eventdata, handles,
%       equilibrium) 
%       gui_showOptimResults_OpeningFcn(hObject, eventdata, handles,
%       equilibrium, plantID) 
%       gui_showOptimResults_OpeningFcn(hObject, eventdata, handles,
%       equilibrium, plantID, model_path) 
%       
%% Description
% |gui_showOptimResults_OpeningFcn(hObject, eventdata, handles, equilibrium)|
% visualizes the logos of GECO-C and PlanET on the gui and sets the given
% arguments (|equilibrium|, same for |plantID| and |model_path| in the
% other calls) inside the handles structure. At the end calls 
% <so_callactualizegui.html so_callActualizeGUI>. 
%
%% Example
% 
%
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="so_callactualizegui.html">
% so_callActualizeGUI</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('imread')">
% doc imread</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('image')">
% doc image</a>
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
% <a href="gui_showoptimresults.html">
% gui_showOptimResults.fig</a>
% </html>
%
%% See also
% 
% <html>
% <a href="gui_showoptimresults.html">
% gui_showOptimResults</a>
% </html>
% ,
% <html>
% <a href="gui_optimization.html">
% gui_optimization</a>
% </html>
% ,
% <html>
% <a href="gui_plot_optimresults.html">
% gui_plot_optimResults</a>
% </html>
%
%% TODOs
%
%
%% <<AuthorTag_DG/>>


