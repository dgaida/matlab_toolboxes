%% gui_nmpc
% Start nonlinear model predictive control processes for a biogas plant model. 
%
function varargout = gui_nmpc(varargin)
% GUI_NMPC M-file for gui_nmpc.fig
%      GUI_NMPC, by itself, creates a new GUI_NMPC or raises the existing
%      singleton*.
%
%      H = GUI_NMPC returns the handle to a new GUI_NMPC or the handle to
%      the existing singleton*.
%
%      GUI_NMPC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_NMPC.M with the given input arguments.
%
%      GUI_NMPC('Property','Value',...) creates a new GUI_NMPC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_nmpc_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_nmpc_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_nmpc

% Last Modified by GUIDE v2.5 16-Oct-2011 15:28:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_nmpc_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_nmpc_OutputFcn, ...
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
function varargout = gui_nmpc_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%%
% --- Executes during object creation, after setting all properties.
function gui_nmpc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gui_nmpc (see GCBO)
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
                 
%%

noGenerations= str2double( get(handles.txtNoGenerationen_nmpc, 'String') );

set(handles.lblGeneration, 'String', ...
    sprintf('%i / %i', min(state.Generation + 1, noGenerations), ...
                       noGenerations));

optchanged= false;


%%
% --- Executes during object creation, after setting all properties.
function txtPopSize_nmpc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtPopSize_nmpc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%
% --- Executes during object creation, after setting all properties.
function popOptMethod_nmpc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popOptMethod_nmpc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%
% --- Executes during object creation, after setting all properties.
function txtNoGenerationen_nmpc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtNoGenerationen_nmpc (see GCBO)
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
% --- Executes on button press in chkParallel.
function chkParallel_Callback(hObject, eventdata, handles)
% hObject    handle to chkParallel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkParallel

if get(hObject,'Value')
    set(handles.txtNWorker, 'String', '4');
else
    set(handles.txtNWorker, 'String', 'none');
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
% --- Executes on button press in btnOptimParams.
function btnOptimParams_Callback(hObject, eventdata, handles)
% hObject    handle to btnOptimParams (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% set handles.optParams

prompt={'Enter the 1st parameter:',...
        'Enter the 2nd parameter:'};
name='Input of parameters of optimization method';
numlines=1;
defaultanswer={'20','20'};
answer=inputdlg(prompt,name,numlines,defaultanswer);

if size( answer ) < 1
    handles.optParams.p1= 20;
    handles.optParams.p2= 20;
else
    handles.optParams.p1= str2double(answer{1});    
    handles.optParams.p2= str2double(answer{2});
end
if isnan( str2double(answer{1}) )
    handles.optParams.p1= 20;
end
if isnan( str2double(answer{2}) )
    handles.optParams.p2= 20;
end

%%


%%
% --- Executes during object creation, after setting all properties.
function change_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to change_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%
% --- Executes on selection change in change_type_edit.
function change_type_edit_Callback(hObject, eventdata, handles)
% hObject    handle to change_type_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns change_type_edit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from change_type_edit

switch ( get(handles.change_type_edit, 'Value') )
    case 1
        change_type = 'percentual';
        set(handles.change_edit, 'String', '0.05'); 
        set(handles.text38, 'String', '%');
    case 2
        method= 'absolute';
        set(handles.change_edit, 'String', '1');
        set(handles.text38, 'String', 'm³/day');
end


%%
% --- Executes during object creation, after setting all properties.
function change_type_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to change_type_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%
%
function N_edit_Callback(hObject, eventdata, handles)
% hObject    handle to N_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of N_edit as text
%        str2double(get(hObject,'String')) returns contents of N_edit as a double

%%

estimatedtime= ( 125 + str2double( get(handles.txtPopSize_nmpc, 'String') )* ...
                   str2double( get(handles.txtNoGenerationen_nmpc, 'String') ) * 30 * ...
                   str2double( get(handles.N_edit, 'String') ) )/60; % minutes

estimatedtime_h= fix( estimatedtime / 60 ); % hours
estimatedtime_min= round( estimatedtime - estimatedtime_h * 60); % minutes
           
set(handles.lblRestTime, 'String', sprintf('%i h : %i min', ...
                         estimatedtime_h, estimatedtime_min));

set( handles.text22, 'ForegroundColor', [1, 0, 0]);


%%
% --- Executes during object creation, after setting all properties.
function N_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to N_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%
% --- Executes during object creation, after setting all properties.
function prediction_horizon_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to prediction_horizon_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%
% --- Executes during object creation, after setting all properties.
function control_horizon_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to control_horizon_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%
% --- Executes on button press in read_write_option.
function read_write_option_Callback(hObject, eventdata, handles)
% hObject    handle to read_write_option (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global id_write id_read

prompt={'Enter the Read file parameter:',...
        'Enter the Write file parameter:'};
name='Define Read and Write files for NMPC';
numlines=1;
defaultanswer={'[ ]','1'};
answer=inputdlg(prompt,name,numlines,defaultanswer);

% if cancell button is pressed, default values are applied !
if size( answer ) < 1
    id_read = [];
    id_write = 1; 
else
    id_read = str2double(answer{1});
    id_write = str2double(answer{2});
end

if isnan( id_read )
   id_read = [];
end
if isnan( id_write )
   id_write = 1;
end


%%
% --- Executes during object creation, after setting all properties.
function chkParallel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to chkParallel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


%%
% --- Executes during object creation, after setting all properties.
function read_write_option_CreateFcn(hObject, eventdata, handles)
% hObject    handle to read_write_option (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


%%
% --- Executes on button press in fit_trig_checkbox.
function fit_trig_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to fit_trig_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of fit_trig_checkbox
if get(hObject,'Value')
  set(handles.fit_trg_edit, 'String', 'Inf'); 
else
  set(handles.fit_trg_edit, 'String', 'none'); 
end


%%
% --- Executes during object creation, after setting all properties.
function fit_trg_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fit_trg_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%% radPanel_nmpc_SelectionChangeFcn
% Executes when selected object is changed in radPanel.
%
function radPanel_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in radPanel 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)

%%

radPanel_nmpc_SelectionChangeFcn(hObject, eventdata, handles);


%%


