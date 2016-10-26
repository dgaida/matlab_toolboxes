%% gui_plant
% Gui for editing the "plant" struct variables of the 'Biogas Plant
% Modeling' library.
%
function varargout = gui_plant(varargin)
%% Release: 1.4

% GUI_PLANT M-file for gui_plant.fig
%      GUI_PLANT, by itself, creates a new GUI_PLANT or raises the existing
%      singleton*.
%
%      H = GUI_PLANT returns the handle to a new GUI_PLANT or the handle to
%      the existing singleton*.
%
%      GUI_PLANT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_PLANT.M with the given input arguments.
%
%      GUI_PLANT('Property','Value',...) creates a new GUI_PLANT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_plant_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_plant_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_plant

% Last Modified by GUIDE v2.5 01-Jul-2012 11:37:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @gui_plant_OpeningFcn, ...
    'gui_OutputFcn',  @gui_plant_OutputFcn, ...
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
function varargout = gui_plant_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1}= handles.output;


%%
% --- Executes on selection change in listDigesters.
function listDigesters_Callback(hObject, eventdata, handles)
% hObject    handle to listDigesters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns listDigesters contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listDigesters


%%
% --- Executes during object creation, after setting all properties.
function listDigesters_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listDigesters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%
% --- Executes during object creation, after setting all properties.
function edit_Tout_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Tout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%
% --- Executes during object creation, after setting all properties.
function edit_Hch4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Hch4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%
% --- Executes during object creation, after setting all properties.
function edit_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%
% --- Executes on selection change in listPlants.
function listPlants_Callback(hObject, eventdata, handles)
% hObject    handle to listPlants (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listPlants contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listPlants


%%
% --- Executes during object creation, after setting all properties.
function listPlants_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listPlants (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%
% --- Executes during object creation, after setting all properties.
function popPlants_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popPlants (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%
% --- Executes on button press in cmdDeleteFermenter.
function cmdDeleteFermenter_Callback(hObject, eventdata, handles)
% hObject    handle to cmdDeleteFermenter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles= gui_plant_deletefermenter(handles);

guidata(hObject, handles);


%%
% --- Executes on button press in cmdDeleteBHKW.
function cmdDeleteBHKW_Callback(hObject, eventdata, handles)
% hObject    handle to cmdDeleteBHKW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles= gui_plant_deletebhkw(handles);

guidata(hObject, handles);


%%
% --- Executes on button press in cmdDeletePump.
function cmdDeletePump_Callback(hObject, eventdata, handles)
% hObject    handle to cmdDeletePump (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles= gui_plant_deletepump(handles);

guidata(hObject, handles);


%%
% --- Executes on button press in btnDeletePlant.
function btnDeletePlant_Callback(hObject, eventdata, handles)
% hObject    handle to btnDeletePlant (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%

% Construct a questdlg with three options
choice= questdlg(sprintf(...
    'Do you really want to delete the plant file %s?', ...
    fullfile(handles.p_path, handles.p_file)), ...
                 'Delete plant file', 'Yes','No','No');

if isempty(choice)
  return;
end

% Handle response
switch choice
  case 'No'
    return;
end

%%

delete(fullfile(handles.p_path, handles.p_file));

%%
% TODO, was passiert danach?


