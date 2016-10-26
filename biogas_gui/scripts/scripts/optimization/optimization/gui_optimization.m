%% gui_optimization
% Start optimization processes for a biogas plant model. 
%
function varargout = gui_optimization(varargin)
%% Release: 1.3

% GUI_OPTIMIZATION M-file for gui_optimization.fig
%      GUI_OPTIMIZATION, by itself, creates a new GUI_OPTIMIZATION or raises the existing
%      singleton*.
%
%      H = GUI_OPTIMIZATION returns the handle to a new GUI_OPTIMIZATION or the handle to
%      the existing singleton*.
%
%      GUI_OPTIMIZATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_OPTIMIZATION.M with the given input arguments.
%
%      GUI_OPTIMIZATION('Property','Value',...) creates a new GUI_OPTIMIZATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_optimization_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_optimization_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_optimization

% Last Modified by GUIDE v2.5 16-Oct-2011 15:30:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_optimization_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_optimization_OutputFcn, ...
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
function varargout = gui_optimization_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%%
% --- Executes during object creation, after setting all properties.
function gui_optimization_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gui_optimization (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

handles.plantID= [];
handles.plantName= [];
handles.plant= [];
handles.substrate= [];
handles.plant_network= [];
handles.substrateflow= [];
handles.pumpFlux= [];
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
%
function [state, options,optchanged]= ...
    gaoutputfcn_slider(options,state,flag, handles)
                 
noGenerations= str2double( get(handles.txtNoGenerationen_optima, 'String') );

set(handles.lblGeneration, 'String', ...
    sprintf('%i / %i', min(state.Generation + 1, noGenerations), ...
                       noGenerations));

optchanged= false;


%%
% --- Executes during object creation, after setting all properties.
function txtPopSize_optima_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtPopSize_optima (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%
% --- Executes during object creation, after setting all properties.
function popOptMethod_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popOptMethod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%
% --- Executes during object creation, after setting all properties.
function txtNoGenerationen_optima_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtNoGenerationen_optima (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%
% --- Executes during object creation, after setting all properties.
function txtTSmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtTSmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%
% --- Executes during object creation, after setting all properties.
function txtNWorker_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtNWorker (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%
% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%%
% --- Executes when selected object is changed in radPanel_optima.
function radPanel_optima_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in radPanel_optima 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)

%%

radPanel_SelectionChangeFcn(hObject, eventdata, handles);

%%


