%% gui_showOptimResults
% Show optimization results. 
%
function varargout = gui_showOptimResults(varargin)
%% Release: 1.1

% GUI_SHOWOPTIMRESULTS M-file for gui_showOptimResults.fig
%      GUI_SHOWOPTIMRESULTS, by itself, creates a new GUI_SHOWOPTIMRESULTS or raises the existing
%      singleton*.
%
%      H = GUI_SHOWOPTIMRESULTS returns the handle to a new GUI_SHOWOPTIMRESULTS or the handle to
%      the existing singleton*.
%
%      GUI_SHOWOPTIMRESULTS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_SHOWOPTIMRESULTS.M with the given input arguments.
%
%      GUI_SHOWOPTIMRESULTS('Property','Value',...) creates a new GUI_SHOWOPTIMRESULTS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_showOptimResults_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_showOptimResults_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_showOptimResults

% Last Modified by GUIDE v2.5 19-Oct-2011 11:47:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_showOptimResults_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_showOptimResults_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


%%
% --- Outputs from this function are returned to the command line.
function varargout = gui_showOptimResults_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%%
% --- Executes on button press in btnSaveResults.
function btnSaveResults_Callback(hObject, eventdata, handles)
% hObject    handle to btnSaveResults (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set_input_stream({handles.model_path}, handles.equilibrium, ...
                 'WindowStyle', 'modal');


%%
% --- Executes during object creation, after setting all properties.
function gui_showOptimResults_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gui_showOptimResults (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

handles.plantID= [];
handles.plantName= [];
handles.plant= [];
handles.substrate= [];
handles.plant_network= [];
%handles.substrateflow= [];
%handles.pumpFlux= [];
handles.model_path= [];

guidata(hObject, handles);


%%
% --- Executes on slider movement.
function sliderSubstrate_Callback(hObject, eventdata, handles)
% hObject    handle to sliderSubstrate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


%%
% --- Executes during object creation, after setting all properties.
function sliderSubstrate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sliderSubstrate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


%%
% --- Executes on button press in radSubstrate.
function radSubstrate_Callback(hObject, eventdata, handles)
% hObject    handle to radSubstrate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radSubstrate


%%
% --- Executes on button press in radPumpFlux.
function radPumpFlux_Callback(hObject, eventdata, handles)
% hObject    handle to radPumpFlux (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radPumpFlux


%%
% --- Executes on button press in btnPrint.
function btnPrint_Callback(hObject, eventdata, handles)
% hObject    handle to btnPrint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

printpreview;


%%
% --- Executes on button press in btnVisualize.
function btnVisualize_Callback(hObject, eventdata, handles)
% hObject    handle to btnVisualize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

gui_plot_optimResults();


%%
% Executes when selected object is changed in so_radPanel.
%
function so_radPanel_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in so_radPanel 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)

%%

radTag= get(eventdata.NewValue, 'Tag');

if strcmp(radTag, 'radSubstrate')
    
    set(handles.panSubstrate, 'Visible', 'on');
    set(handles.panPumpFlux, 'Visible', 'off');

else

    set(handles.panSubstrate, 'Visible', 'off');
    set(handles.panPumpFlux, 'Visible', 'on');
    
end


%%


