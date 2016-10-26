%% gui_plot_optimResults
% Plot the results of optimization runs done for a biogas plant model. 
%
function varargout = gui_plot_optimResults(varargin)
%% Release: 1.1

% GUI_PLOT_OPTIMRESULTS M-file for gui_plot_optimResults.fig
%      GUI_PLOT_OPTIMRESULTS, by itself, creates a new GUI_PLOT_OPTIMRESULTS or raises the existing
%      singleton*.
%
%      H = GUI_PLOT_OPTIMRESULTS returns the handle to a new GUI_PLOT_OPTIMRESULTS or the handle to
%      the existing singleton*.
%
%      GUI_PLOT_OPTIMRESULTS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_PLOT_OPTIMRESULTS.M with the given input arguments.
%
%      GUI_PLOT_OPTIMRESULTS('Property','Value',...) creates a new GUI_PLOT_OPTIMRESULTS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_plot_optimResults_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_plot_optimResults_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_plot_optimResults

% Last Modified by GUIDE v2.5 02-Nov-2011 14:51:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_plot_optimResults_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_plot_optimResults_OutputFcn, ...
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
function varargout = gui_plot_optimResults_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%%
% --- Executes when user attempts to close gui_plot_optimResults.
function gui_plot_optimResults_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to gui_plot_optimResults (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if isfield(handles, 'axes2')
  try
    delete(handles.axes2);
  catch ME
  end
end

if isfield(handles, 'axes3')
  try
    delete(handles.axes3);
  catch ME
  end
end

% Hint: delete(hObject) closes the figure
delete(hObject);


%%
% --- Executes during object creation, after setting all properties.
function gui_plot_optimResults_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gui_plot_optimResults (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

handles.plantName= [];
handles.model_path= [];

guidata(hObject, handles);


%%
% --- Executes on selection change in lstXAxis.
function lstXAxis_Callback(hObject, eventdata, handles)
% hObject    handle to lstXAxis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns lstXAxis contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lstXAxis

handles= plot_xyz(handles);

guidata(hObject, handles);


%%
% --- Executes during object creation, after setting all properties.
function lstXAxis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lstXAxis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%
% --- Executes on selection change in lstYAxis.
function lstYAxis_Callback(hObject, eventdata, handles)
% hObject    handle to lstYAxis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns lstYAxis contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lstYAxis

handles= plot_xyz(handles);

guidata(hObject, handles);


%%
% --- Executes during object creation, after setting all properties.
function lstYAxis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lstYAxis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%
% --- Executes on selection change in lstZAxis.
function lstZAxis_Callback(hObject, eventdata, handles)
% hObject    handle to lstZAxis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns lstZAxis contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lstZAxis

handles= plot_xyz(handles);

guidata(hObject, handles);


%%
% --- Executes during object creation, after setting all properties.
function lstZAxis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lstZAxis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%
% --- Executes on button press in chkScatter.
function chkScatter_Callback(hObject, eventdata, handles)
% hObject    handle to chkScatter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkScatter

handles= plot_xyz(handles);

guidata(hObject, handles);


%%
% --- Executes on button press in btnOpenFigure.
function btnOpenFigure_Callback(hObject, eventdata, handles)
% hObject    handle to btnOpenFigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

figure('Position', [580 45 560*2 420*2]);

handles= plot_xyz(handles);

guidata(hObject, handles);


%%
% --- Executes on selection change in lst4Daxis.
function lst4Daxis_Callback(hObject, eventdata, handles)
% hObject    handle to lst4Daxis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns lst4Daxis contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lst4Daxis

handles= plot_xyz(handles);

guidata(hObject, handles);


%%
% --- Executes during object creation, after setting all properties.
function lst4Daxis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lst4Daxis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%
