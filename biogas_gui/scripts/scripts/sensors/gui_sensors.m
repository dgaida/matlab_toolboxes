%% gui_sensors
%
%
function varargout = gui_sensors(varargin)
% GUI_SENSORS MATLAB code for gui_sensors.fig
%      GUI_SENSORS, by itself, creates a new GUI_SENSORS or raises the existing
%      singleton*.
%
%      H = GUI_SENSORS returns the handle to a new GUI_SENSORS or the handle to
%      the existing singleton*.
%
%      GUI_SENSORS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_SENSORS.M with the given input arguments.
%
%      GUI_SENSORS('Property','Value',...) creates a new GUI_SENSORS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_sensors_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_sensors_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_sensors

% Last Modified by GUIDE v2.5 01-Apr-2013 22:25:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 0;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_sensors_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_sensors_OutputFcn, ...
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
% --- Executes just before gui_sensors is made visible.
function gui_sensors_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_sensors (see VARARGIN)

% Choose default command line output for gui_sensors
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_sensors wait for user response (see UIRESUME)
% uiwait(handles.gui_sensors);



%%
% --- Outputs from this function are returned to the command line.
function varargout = gui_sensors_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



%%
% --- Executes on selection change in lstSensors.
function lstSensors_Callback(hObject, eventdata, handles)
% hObject    handle to lstSensors (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%

contents = cellstr(get(handles.lstSensors,'String')); % returns lstSensors contents as cell array
index= get(handles.lstSensors,'Value');
sel_value= contents{index}; % returns selected item from lstSensors

sensors= handles.sensors;

dim= sensors.get_param_of_i(sel_value, 'dimension');

%%

dims= cell(dim, 1);

for iel= 1:numel(dims)

  dims{iel}= iel - 1;

end

set(handles.lstIndex, 'String', dims);

set(handles.lstIndex, 'Value', 1);

%%

handles= plot_sel_value(handles);

%%

guidata(hObject, handles);



%%
% --- Executes during object creation, after setting all properties.
function lstSensors_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lstSensors (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%%
% --- Executes on button press in cmdEvalSensors.
function cmdEvalSensors_Callback(hObject, eventdata, handles)
% hObject    handle to cmdEvalSensors (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
  handles.sensors= evalinMWS('sensors', 1);
catch ME
  disp(ME.message)
  handles.sensors= evalin('base', 'sensors');
end

%%

sensorlist= get_sensorlist(handles.sensors);

set(handles.lstSensors, 'String', sensorlist);

set(handles.lstIndex, 'Value', 1);

%%

% [sensorsData, sensorsSymbolsUnits]= getCurrentSensorMeasurements(handles.sensors);
% 
% handles.sensorsSymbolsUnits= sensorsSymbolsUnits;

%%

guidata(hObject, handles);

%%


%%
% --- Executes on button press in btnOpenFigure.
function btnOpenFigure_Callback(hObject, eventdata, handles)
% hObject    handle to btnOpenFigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

figure;

handles= plot_sel_value(handles);

%%

guidata(hObject, handles);



%%
%
function handles= plot_sel_value(handles)

%%

contents = cellstr(get(handles.lstSensors,'String')); % returns lstSensors contents as cell array
index= get(handles.lstSensors,'Value');
sel_value= contents{index}; % returns selected item from lstSensors

%%
% 0 based
index= get(handles.lstIndex, 'Value') - 1;

%%
%

sensors= handles.sensors;

add_noise= get(handles.chkNoise, 'Value');

data= sensors.getMeasurementStream(sel_value, index, logical(add_noise));
time= sensors.getTimeStream(sel_value);

label= char(sensors.get_physValue_param(sel_value, index, 'Label'));
unit= char(sensors.get_physValue_param(sel_value, index, 'Unit'));

time= double(time);
data= double(data);

% throw time at 0 away
time= time(2:end);
data= data(2:end);

%plot(time, numerics.math.round_float(double(data), 3));
plot(time, data);

%set( get( gca, 'YLabel' ), 'Interpreter', 'none' );

%%

xlabel('time [d]')

%sensorSymbolUnit= handles.sensorsSymbolsUnits{index};

ylabel([label, ' [', unit, ']']);

%ylabel(sel_value)



%%
% --- Executes on button press in chkNoise.
function chkNoise_Callback(hObject, eventdata, handles)
% hObject    handle to chkNoise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkNoise

handles= plot_sel_value(handles);

%%

guidata(hObject, handles);



%%
% --- Executes on selection change in lstIndex.
function lstIndex_Callback(hObject, eventdata, handles)
% hObject    handle to lstIndex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns lstIndex contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lstIndex

handles= plot_sel_value(handles);

%%

guidata(hObject, handles);



%%
% --- Executes during object creation, after setting all properties.
function lstIndex_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lstIndex (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%
