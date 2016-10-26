%% gui_optimization_OpeningFcn
% Executes just before gui_optimization is made visible.
%
function gui_optimization_OpeningFcn(hObject, eventdata, handles, varargin)
%% Release: 1.5

% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_optimization (see VARARGIN)

%%

error( nargchk(3, nargin, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '3rd');

%%
% Choose default command line output for gui_optimization
handles.output = hObject;

handles.optParams= [];

%%

for iimage= 2:3
    
  if iimage == 2
      data= get_gecoc_logo(get(handles.gui_optimization, 'Color'));
  else
      data= get_company_logo(get(handles.gui_optimization, 'Color'));
  end

  image(data, 'Parent', handles.(sprintf('axes%i', iimage)));

  clear data;

  axis(handles.(sprintf('axes%i', iimage)), 'off');

end

%%
%handles= findPlants(handles);

if exist('matlabpool', 'file') == 2
    set(handles.chkParallel, 'Visible', 'on');
    set(handles.txtNWorker,  'Visible', 'on');
    set(handles.chkParallel, 'Value',   1);
else
    set(handles.chkParallel, 'Visible', 'off');
    set(handles.chkParallel, 'Value',   0);
    set(handles.txtNWorker,  'Visible', 'off');
end

%%
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_optimization wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%%


