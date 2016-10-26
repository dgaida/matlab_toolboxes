%% set_input_stream_min_max_OpeningFcn
% Executes just before set_input_stream_min_max is made visible.
%
%% Toolbox
% |set_input_stream_min_max_OpeningFcn| belongs to the _Biogas Plant
% Modeling_ Toolbox. 
%
%% Release
% Approval for Release 1.1, to get the approval for Release 1.2 make the
% TODOs and a thorough review, Daniel Gaida 
%
%% Syntax
%       set_input_stream_min_max_OpeningFcn(hObject, eventdata, handles, varargin)
%
%% Description
% |set_input_stream_min_max_OpeningFcn(hObject, eventdata, handles, varargin)|
% GUI <set_input_stream_min_max.html set_input_stream_min_max>.
%
%% Example
%
%
%% Dependencies
% 
% This function calls:
%
% <html>
% <a href="mm_callActualizeGUI.html">
% mm_callActualizeGUI</a>
% </html>
% ,
% <html>
% <a href="searchForModelFile.html">
% searchForModelFile</a>
% </html>
% ,
% <html>
% <a href="mm_findPlants.html">
% mm_findPlants</a>
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
function set_input_stream_min_max_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to set_input_stream_min_max (see VARARGIN)

%%

error( nargchk(3, nargin, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%
% Choose default command line output for set_input_stream_min_max
handles.output = hObject;

for iimage= 2:3
    
  if iimage == 2
      data= get_gecoc_logo(get(handles.set_input_stream_min_max, 'Color'));
  else
      data= get_company_logo(get(handles.set_input_stream_min_max, 'Color'));
  end

  image(data, 'Parent', handles.(sprintf('axes%i', iimage)));

  clear data;

  axis(handles.(sprintf('axes%i', iimage)), 'off');

end

%%

handles= mm_findPlants(handles);

%%

if nargin >= 4
    
  handles.model_path= char(varargin{1});

  set(handles.mm_popPlant, 'Enable', 'off');
  set(handles.mm_btnPath, 'Enable', 'off');

  %%
  
  if ~isa(handles.model_path, 'double')

      set(handles.lblPath, 'String', handles.model_path);

      handles= searchForModelFile(handles);

      if isfield(handles, 'plantID') && ~isempty( handles.plantID )
          handles= mm_callActualizeGUI(handles);
      end

  else

      set(handles.lblPath, 'String', '');

  end
    
end

%%
% Update handles structure
guidata(hObject, handles);

%%

if nargin >= 4
 
    % UIWAIT makes set_input_stream_min_max wait for user response (see UIRESUME)
    uiwait(handles.set_input_stream_min_max);

end

%%


