%% Syntax
%       btnStartOptimization_Callback(hObject, eventdata, handles)
%       
%% Description
% |btnStartOptimization_Callback(hObject, eventdata, handles)| executes on
% button press in btnStartOptimization. Starts the optimization run using
% <matlab:doc('findoptimalequilibrium') findOptimalEquilibrium>. Before it sets
% boundaries like max TS of the substrates and the manure bonus. Both are
% saved inside the |fitness_params_...mat| file. For the manure bonus a
% linear inequality constraint for the substrates is introduced and saved
% in |substrate_ineq_...mat|. 
%
%% Example
% 
%
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="matlab:doc('load_file')">
% load_file</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('setlinearmanurebonusconstraint')">
% setLinearManureBonusConstraint</a>
% </html>
% ,
% <html>
% <a href="gui_showoptimresults.html">
% gui_showOptimResults</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('findoptimalequilibrium')">
% findOptimalEquilibrium</a>
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
% <a href="optima_callactualizegui.html">
% optima_callActualizeGUI</a>
% </html>
%
%% TODOs
% # improve documentation
% # check code
%
%% <<AuthorTag_DG/>>


