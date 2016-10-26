%% btnStartNMPC_Callback
% Executes on button press in btnStartNMPC.
%
%% Toolbox
% |btnStartNMPC_Callback| belongs to the _Biogas Plant Modeling_
% Toolbox. 
%
%% Release
% Approval for Release 1.5, to get the approval for Release 1.6 make the
% TODO, Daniel Gaida 
%
%% Syntax
%       btnStartNMPC_Callback(hObject, eventdata, handles)
%       
%% Description
% |btnStartNMPC_Callback(hObject, eventdata, handles)| executes on
% button press in btnStartNMPC. Starts the nmpc run using
% <matlab:doc('biogas_control/nonlinearmpc') nonlinearMPC>. Before it sets
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
% <a href="gui_showOptimResults.html">
% gui_showOptimResults</a>
% </html>
% ,
% <html>
% <a href="matlab:doc('biogas_control/nonlinearmpc')">
% biogas_control/nonlinearMPC</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="gui_nmpc.html">
% gui_nmpc (gui)</a>
% </html>
%
%% See also
% 
% <html>
% <a href="gui_nmpc.html">
% gui_nmpc</a>
% </html>
% ,
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
% <a href="nmpc_callActualizeGUI.html">
% nmpc_callActualizeGUI</a>
% </html>
%
%% TODOs
%
%
%% Author
% Daniel Gaida, M.Sc.EE.IT
%
% Cologne University of Applied Sciences (Campus Gummersbach)
%
% Department of Automation & Industrial IT
%
% GECO-C Group
%
% daniel.gaida@fh-koeln.de
%
% Copyright 2010-2011
%
% Last Update: 16.10.2011
%


