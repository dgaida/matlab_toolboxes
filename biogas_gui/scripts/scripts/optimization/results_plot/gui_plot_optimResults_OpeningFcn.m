%% gui_plot_optimResults_OpeningFcn
% Executes just before gui_plot_optimResults is made visible.
%
function gui_plot_optimResults_OpeningFcn(hObject, eventdata, handles, varargin)
%% Release: 1.6

% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_plot_optimResults (see VARARGIN)

%%

error( nargchk(3, nargin, nargin, 'struct') );
error( nargoutchk(0, 0, nargout, 'struct') );

%%

checkArgument(handles, 'handles', 'struct', '3rd');

%%
% Choose default command line output for gui_plot_optimResults
handles.output= hObject;

%%

for iimage= 2:3
    
  %%
  
  if iimage == 2
      data= get_gecoc_logo(get(handles.gui_plot_optimResults, 'Color'));
  else
      data= get_company_logo(get(handles.gui_plot_optimResults, 'Color'));
  end

  %%
  
  image(data, 'Parent', handles.(sprintf('axes%i', iimage)));

  clear data;

  axis(handles.(sprintf('axes%i', iimage)), 'off');

end

%%
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_plot_optimResults wait for user response (see UIRESUME)
% uiwait(handles.gui_plot_optimResults);

%%


