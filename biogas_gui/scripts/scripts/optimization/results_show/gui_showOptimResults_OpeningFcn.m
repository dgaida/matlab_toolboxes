%% gui_showOptimResults_OpeningFcn
% Executes just before gui_showOptimResults is made visible.
%
function gui_showOptimResults_OpeningFcn(hObject, eventdata, handles, varargin)
%% Release: 1.1

% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_showOptimResults (see VARARGIN)

%%

error( nargchk(3, nargin, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '3rd');

%%
% Choose default command line output for gui_showOptimResults
handles.output = hObject;

%%

for iimage= 2:3
    
  if iimage == 2
      data= get_gecoc_logo(get(handles.gui_showOptimResults, 'Color'));
  else
      data= get_company_logo(get(handles.gui_showOptimResults, 'Color'));
  end

  image(data, 'Parent', handles.(sprintf('axes%i', iimage)));

  clear data;

  axis(handles.(sprintf('axes%i', iimage)), 'off');

end

%%

if nargin >= 4
  handles.equilibrium= varargin{1};

  checkArgument(varargin{1}, 'handles.equilibrium', 'struct', '4th');
else
  error('GUI may not be called without arguments!');
end

if nargin >= 5
  handles.plantID= varargin{2};
  
  checkArgument(handles.plantID, 'handles.plantID', 'char', 5);
end

if nargin >= 6
  handles.model_path= varargin{3};
  
  checkArgument(handles.model_path, 'handles.model_path', 'char', 6);
end

handles.plantName= [];
            
%%

handles= so_callActualizeGUI(handles);

%%
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_showOptimResults wait for user response (see UIRESUME)
% uiwait(handles.gui_showOptimResults);

%%


