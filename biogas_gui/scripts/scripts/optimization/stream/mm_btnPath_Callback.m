%% mm_btnPath_Callback
% Executes on button press in mm_btnPath.
%
%% Toolbox
% |mm_btnPath_Callback| belongs to the _Biogas Plant Modeling_ Toolbox
% and is an internal function.
%
%% Release
% Approval for Release 1.1, to get the approval for Release 1.2 make a
% thorough review, Daniel Gaida 
%
%% Syntax
%       mm_btnPath_Callback(hObject, eventdata, handles)
%
%% Description
% |mm_btnPath_Callback(hObject, eventdata, handles)|. 
% GUI <set_input_stream_min_max.html set_input_stream_min_max>.
%
%%
% @param |hObject| : 
%
%%
% @param |eventdata| : 
%
%%
% @param |handles| : handle of gui
%
%% Example
%
% 
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="searchForModelFile.html">
% searchForModelFile</a>
% </html>
% ,
% <html>
% <a href="mm_callActualizeGUI.html">
% mm_callActualizeGUI</a>
% </html>
%
% and is called by:
%
% <html>
% <a href="set_input_stream_min_max.html">
% set_input_stream_min_max.fig</a>
% </html>
% 
%% See Also
%
% <html>
% <a href="set_input_stream_min_max.html">
% set_input_stream_min_max</a>
% </html>
% ,
% <html>
% <a href="stream\set_input_stream.html">
% set_input_stream</a>
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
% Last Update: 17.10.2011
%
%% Function
%
function mm_btnPath_Callback(hObject, eventdata, handles)
% hObject    handle to mm_btnPath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%

error( nargchk(3, 3, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

if ~isstruct(handles)
  error(['The 3rd parameter handles must be of type struct, ', ...
         'but is of type ', class(handles), '!']);
end

%%
% search and default Selection of "plant" file to edit

if isempty(handles.model_path)
    handles.model_path= uigetdir(pwd);
else
    handles.model_path= uigetdir(handles.model_path);
end


%%

if ~isa(handles.model_path, 'double')

  set(handles.lblPath, 'String', handles.model_path);

  handles= searchForModelFile(handles);

  if isfield(handles, 'plantID') && ~isempty( handles.plantID )
      handles= mm_callActualizeGUI(handles);
  end

else

  set(handles.lblPath, 'String', '');
  handles.model_path= [];
    
end

%%

guidata(hObject, handles);

%%


