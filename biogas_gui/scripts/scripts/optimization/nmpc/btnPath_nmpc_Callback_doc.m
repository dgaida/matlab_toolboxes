%% btnPath_nmpc_Callback
% Executes on button press in btnPath_nmpc.
%
%% Toolbox
% |btnPath_nmpc_Callback| belongs to the _Biogas Plant Modeling_
% Toolbox. 
%
%% Release
% Approval for Release 1.4, to get the approval for Release 1.5 make the
% TODO, Daniel Gaida 
%
%% Syntax
%       btnPath_nmpc_Callback(hObject, eventdata, handles)
%       
%% Description
% |btnPath_nmpc_Callback(hObject, eventdata, handles)| executes on
% button press in btnPath_nmpc. Lets the user choose the folder to the
% optimization model and sets the plant ID after the model of the plant was
% found. Then calls <nmpc_callActualizeGUI.html nmpc_callActualizeGUI>.
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
% <a href="nmpc_callActualizeGUI.html">
% nmpc_callActualizeGUI</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="gui_nmpc.html">
% gui_nmpc</a>
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
% <a href="searchForModelFile.html">
% searchForModelFile</a>
% </html>
%
%% TODOs
% # searchForModelFile ist sehr ähnlich
%
%% Author
% André Luis Sousa Brito, M.Eng. Automation & IT
%
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


